----------------------------------------------------------------------------------
-- Module Name: game_of_life_top
-- Target Devices: ALINX AX7Z020B (XC7Z020-2CLG400I), solo PL
-- Description: Juego de la Vida de Conway por HDMI, 640x480 @ 60 Hz.
--   Tablero de 80 x 60 celdas de 8 x 8 pixeles (toroidal).
--   Reloj: 50 MHz (U18) -> MMCM -> 25 MHz pixel, 125 MHz serial (DDR 10:1).
--   Las generaciones se calculan al inicio del blanking vertical.
--
--   KEY1 : cargar patron inicial (Gosper glider gun + acorn)
--   KEY2 : llenar el tablero al azar
--   KEY3 : pausa / continuar
--   KEY4 : cambiar velocidad (1, 2, 4, 10, 20, 60 generaciones/s)
--   LED1 : encendido mientras corre
--   LED2-LED4 : indice de velocidad en binario (LED2 = bit 0)
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity game_of_life_top is
    port (
        sys_clk    : in  std_logic;                     -- 50 MHz
        keys_n     : in  std_logic_vector(3 downto 0);  -- KEY4..KEY1, activos en bajo
        leds_n     : out std_logic_vector(3 downto 0);  -- LED4..LED1, activos en bajo
        hdmi_clk_p : out std_logic;
        hdmi_clk_n : out std_logic;
        hdmi_d_p   : out std_logic_vector(2 downto 0);  -- 0 = azul, 1 = verde, 2 = rojo
        hdmi_d_n   : out std_logic_vector(2 downto 0)
    );
end game_of_life_top;

architecture Behavioral of game_of_life_top is

    constant COLS : positive := 80;
    constant ROWS : positive := 60;

    -- 640x480 @ 60 Hz (pixel 25 MHz), sincronias negativas
    constant H_VISIBLE : integer := 640;
    constant H_FRONT   : integer := 16;
    constant H_SYNC    : integer := 96;
    constant H_TOTAL   : integer := 800;
    constant V_VISIBLE : integer := 480;
    constant V_FRONT   : integer := 10;
    constant V_SYNC    : integer := 2;
    constant V_TOTAL   : integer := 525;

    -- Cuadros por generacion para cada velocidad
    type speed_table_t is array (0 to 5) of integer range 1 to 60;
    constant FRAMES_PER_GEN : speed_table_t := (60, 30, 15, 6, 3, 1);

    constant COLOR_ALIVE : std_logic_vector(23 downto 0) := x"30E060";
    constant COLOR_DEAD  : std_logic_vector(23 downto 0) := x"101418";
    constant COLOR_GRID  : std_logic_vector(23 downto 0) := x"000000";

    -- Relojes y reset
    signal clkfb, clk_pix_mmcm, clk_x5_mmcm : std_logic;
    signal clk_pix, clk_x5, locked          : std_logic;
    signal rst_sync                         : std_logic_vector(3 downto 0) := (others => '1');
    signal rst                              : std_logic;

    -- Temporizacion de video
    signal hcount : integer range 0 to H_TOTAL-1 := 0;
    signal vcount : integer range 0 to V_TOTAL-1 := 0;
    signal frame_tick : std_logic;

    -- Pipeline de pixel: etapa 1 (fila leida), etapa 2 (color)
    signal x1, y1           : unsigned(9 downto 0);
    signal de1, hs1, vs1    : std_logic;
    signal de2, hs2, vs2    : std_logic;
    signal rgb              : std_logic_vector(23 downto 0);
    signal sync_b           : std_logic_vector(1 downto 0);  -- c1 = vsync, c0 = hsync
    signal rd_row           : integer range 0 to ROWS-1;
    signal row_data         : std_logic_vector(COLS-1 downto 0);

    -- Control
    signal press            : std_logic_vector(3 downto 0);
    signal running          : std_logic := '1';
    signal speed            : integer range 0 to 5 := 3;
    signal speed_u          : unsigned(2 downto 0);
    signal frame_cnt        : integer range 0 to 60 := 0;
    signal pend_load, pend_random : std_logic := '0';
    signal cmd_load, cmd_random, cmd_step : std_logic := '0';
    signal busy             : std_logic;

    -- TMDS
    signal tmds_b, tmds_g, tmds_r : std_logic_vector(9 downto 0);
    type tmds_array_t is array (0 to 2) of std_logic_vector(9 downto 0);
    signal tmds : tmds_array_t;
    constant TMDS_CLK_PATTERN : std_logic_vector(9 downto 0) := "0000011111";
    constant NO_SYNC          : std_logic_vector(1 downto 0) := "00";

begin

    ------------------------------------------------------------------------
    -- Relojes: VCO = 50 MHz x 20 = 1000 MHz; /40 = 25 MHz; /8 = 125 MHz
    ------------------------------------------------------------------------
    mmcm : MMCME2_BASE
        generic map (
            CLKIN1_PERIOD    => 20.0,
            DIVCLK_DIVIDE    => 1,
            CLKFBOUT_MULT_F  => 20.0,
            CLKOUT0_DIVIDE_F => 40.0,
            CLKOUT1_DIVIDE   => 8)
        port map (
            CLKIN1   => sys_clk,
            CLKFBIN  => clkfb,
            CLKFBOUT => clkfb,
            CLKOUT0  => clk_pix_mmcm,
            CLKOUT1  => clk_x5_mmcm,
            LOCKED   => locked,
            PWRDWN   => '0',
            RST      => '0');

    bufg_pix : BUFG port map (I => clk_pix_mmcm, O => clk_pix);
    bufg_x5  : BUFG port map (I => clk_x5_mmcm,  O => clk_x5);

    process(clk_pix, locked)
    begin
        if locked = '0' then
            rst_sync <= (others => '1');
        elsif rising_edge(clk_pix) then
            rst_sync <= rst_sync(2 downto 0) & '0';
        end if;
    end process;
    rst <= rst_sync(3);

    ------------------------------------------------------------------------
    -- Contadores de video
    ------------------------------------------------------------------------
    process(clk_pix)
    begin
        if rising_edge(clk_pix) then
            if rst = '1' then
                hcount <= 0;
                vcount <= 0;
            elsif hcount = H_TOTAL-1 then
                hcount <= 0;
                if vcount = V_TOTAL-1 then
                    vcount <= 0;
                else
                    vcount <= vcount + 1;
                end if;
            else
                hcount <= hcount + 1;
            end if;
        end if;
    end process;

    frame_tick <= '1' when hcount = 0 and vcount = V_VISIBLE else '0';

    ------------------------------------------------------------------------
    -- Botones y control de la simulacion
    ------------------------------------------------------------------------
    gen_keys : for i in 0 to 3 generate
        db : entity work.debounce
            port map (clk => clk_pix, key_n => keys_n(i), press => press(i));
    end generate;

    process(clk_pix)
    begin
        if rising_edge(clk_pix) then
            cmd_load   <= '0';
            cmd_random <= '0';
            cmd_step   <= '0';

            if rst = '1' then
                running     <= '1';
                speed       <= 3;
                frame_cnt   <= 0;
                pend_load   <= '0';
                pend_random <= '0';
            else
                if press(0) = '1' then pend_load   <= '1'; end if;
                if press(1) = '1' then pend_random <= '1'; end if;
                if press(2) = '1' then running <= not running; end if;
                if press(3) = '1' then
                    if speed = 5 then speed <= 0; else speed <= speed + 1; end if;
                end if;

                -- Los cambios al tablero solo se hacen en el blanking vertical
                if frame_tick = '1' and busy = '0' then
                    if pend_load = '1' then
                        cmd_load  <= '1';
                        pend_load <= '0';
                        frame_cnt <= 0;
                    elsif pend_random = '1' then
                        cmd_random  <= '1';
                        pend_random <= '0';
                        frame_cnt   <= 0;
                    elsif running = '1' then
                        if frame_cnt + 1 >= FRAMES_PER_GEN(speed) then
                            cmd_step  <= '1';
                            frame_cnt <= 0;
                        else
                            frame_cnt <= frame_cnt + 1;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process;

    speed_u   <= to_unsigned(speed, 3);
    leds_n(0) <= not running;
    leds_n(1) <= not speed_u(0);
    leds_n(2) <= not speed_u(1);
    leds_n(3) <= not speed_u(2);

    ------------------------------------------------------------------------
    -- Tablero
    ------------------------------------------------------------------------
    rd_row <= vcount / 8 when vcount < V_VISIBLE else 0;

    core : entity work.life_core
        generic map (COLS => COLS, ROWS => ROWS)
        port map (
            clk         => clk_pix,
            rst         => rst,
            cmd_load    => cmd_load,
            cmd_random  => cmd_random,
            cmd_step    => cmd_step,
            busy        => busy,
            rd_row      => rd_row,
            rd_row_data => row_data);

    ------------------------------------------------------------------------
    -- Generacion de pixeles
    ------------------------------------------------------------------------
    process(clk_pix)
    begin
        if rising_edge(clk_pix) then
            -- Etapa 1: alinear con la fila leida del tablero
            x1  <= to_unsigned(hcount, 10);
            y1  <= to_unsigned(vcount, 10);
            de1 <= '0';
            hs1 <= '1';
            vs1 <= '1';
            if hcount < H_VISIBLE and vcount < V_VISIBLE then
                de1 <= '1';
            end if;
            if hcount >= H_VISIBLE + H_FRONT and hcount < H_VISIBLE + H_FRONT + H_SYNC then
                hs1 <= '0';
            end if;
            if vcount >= V_VISIBLE + V_FRONT and vcount < V_VISIBLE + V_FRONT + V_SYNC then
                vs1 <= '0';
            end if;

            -- Etapa 2: color de la celda (ultima columna/fila de cada celda = rejilla)
            de2 <= de1;
            hs2 <= hs1;
            vs2 <= vs1;
            if x1(2 downto 0) = "111" or y1(2 downto 0) = "111" then
                rgb <= COLOR_GRID;
            elsif row_data(to_integer(x1(9 downto 3)) mod COLS) = '1' then
                rgb <= COLOR_ALIVE;
            else
                rgb <= COLOR_DEAD;
            end if;
        end if;
    end process;

    ------------------------------------------------------------------------
    -- HDMI (DVI): codificacion TMDS y serializacion
    ------------------------------------------------------------------------
    enc_b : entity work.tmds_encoder
        port map (clk => clk_pix, data => rgb(7 downto 0),   c => sync_b,    de => de2, q => tmds_b);
    enc_g : entity work.tmds_encoder
        port map (clk => clk_pix, data => rgb(15 downto 8),  c => NO_SYNC,   de => de2, q => tmds_g);
    enc_r : entity work.tmds_encoder
        port map (clk => clk_pix, data => rgb(23 downto 16), c => NO_SYNC,   de => de2, q => tmds_r);

    sync_b  <= vs2 & hs2;
    tmds(0) <= tmds_b;
    tmds(1) <= tmds_g;
    tmds(2) <= tmds_r;

    gen_ser : for i in 0 to 2 generate
        ser : entity work.tmds_serializer
            port map (
                clk_pix => clk_pix,
                clk_x5  => clk_x5,
                rst     => rst,
                data    => tmds(i),
                out_p   => hdmi_d_p(i),
                out_n   => hdmi_d_n(i));
    end generate;

    ser_clk : entity work.tmds_serializer
        port map (
            clk_pix => clk_pix,
            clk_x5  => clk_x5,
            rst     => rst,
            data    => TMDS_CLK_PATTERN,
            out_p   => hdmi_clk_p,
            out_n   => hdmi_clk_n);

end Behavioral;
