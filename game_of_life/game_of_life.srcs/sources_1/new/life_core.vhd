----------------------------------------------------------------------------------
-- Module Name: life_core
-- Description: Tablero del Juego de la Vida de Conway (COLS x ROWS, toroidal).
--   El tablero vive en registros. Una generacion se calcula fila por fila
--   (ROWS ciclos) sobreescribiendo en sitio; se guardan las filas viejas que
--   aun hacen falta (la anterior y la fila 0 para cerrar el toro).
--   Comandos (pulsos de 1 ciclo, solo se aceptan si busy = '0'):
--     cmd_load   : carga el patron inicial (Gosper glider gun + acorn)
--     cmd_random : llena el tablero con bits de un LFSR (COLS*ROWS ciclos)
--     cmd_step   : calcula la siguiente generacion
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity life_core is
    generic (
        COLS : positive := 80;
        ROWS : positive := 60
    );
    port (
        clk         : in  std_logic;
        rst         : in  std_logic;
        cmd_load    : in  std_logic;
        cmd_random  : in  std_logic;
        cmd_step    : in  std_logic;
        busy        : out std_logic;
        -- Puerto de lectura para el video (1 ciclo de latencia)
        rd_row      : in  integer range 0 to ROWS-1;
        rd_row_data : out std_logic_vector(COLS-1 downto 0)
    );
end life_core;

architecture Behavioral of life_core is

    subtype row_t  is std_logic_vector(COLS-1 downto 0);
    type    grid_t is array (0 to ROWS-1) of row_t;

    -- Coordenadas (x, y) de los patrones iniciales
    type point_t  is record x, y : natural; end record;
    type points_t is array (natural range <>) of point_t;

    constant GOSPER_GUN : points_t := (
        (24,0),
        (22,1),(24,1),
        (12,2),(13,2),(20,2),(21,2),(34,2),(35,2),
        (11,3),(15,3),(20,3),(21,3),(34,3),(35,3),
        (0,4),(1,4),(10,4),(16,4),(20,4),(21,4),
        (0,5),(1,5),(10,5),(14,5),(16,5),(17,5),(22,5),(24,5),
        (10,6),(16,6),(24,6),
        (11,7),(15,7),
        (12,8),(13,8));

    constant ACORN : points_t := (
        (1,0),(3,1),(0,2),(1,2),(4,2),(5,2),(6,2));

    function place(g : grid_t; p : points_t; x0, y0 : natural) return grid_t is
        variable r : grid_t := g;
    begin
        for i in p'range loop
            r((y0 + p(i).y) mod ROWS)((x0 + p(i).x) mod COLS) := '1';
        end loop;
        return r;
    end function;

    function init_grid return grid_t is
        variable g : grid_t := (others => (others => '0'));
    begin
        g := place(g, GOSPER_GUN, 2, 2);
        g := place(g, ACORN, COLS*2/3, ROWS*2/3);
        return g;
    end function;

    constant INIT_PATTERN : grid_t := init_grid;

    -- Siguiente estado de una fila a partir de sus vecinas (con vuelta en x)
    function next_row(up, cur, dn : row_t) return row_t is
        variable r    : row_t;
        variable n    : integer range 0 to 8;
        variable l, d : integer range 0 to COLS-1;
    begin
        for c in 0 to COLS-1 loop
            l := (c + COLS - 1) mod COLS;
            d := (c + 1) mod COLS;
            n := 0;
            if up(l)  = '1' then n := n + 1; end if;
            if up(c)  = '1' then n := n + 1; end if;
            if up(d)  = '1' then n := n + 1; end if;
            if cur(l) = '1' then n := n + 1; end if;
            if cur(d) = '1' then n := n + 1; end if;
            if dn(l)  = '1' then n := n + 1; end if;
            if dn(c)  = '1' then n := n + 1; end if;
            if dn(d)  = '1' then n := n + 1; end if;
            if n = 3 or (n = 2 and cur(c) = '1') then
                r(c) := '1';
            else
                r(c) := '0';
            end if;
        end loop;
        return r;
    end function;

    type state_t is (IDLE, STEP, RAND);
    signal state : state_t := IDLE;

    signal grid      : grid_t := INIT_PATTERN;
    signal row       : integer range 0 to ROWS-1 := 0;
    signal col       : integer range 0 to COLS-1 := 0;
    signal prev_row  : row_t;   -- fila r-1 antes de actualizarse
    signal first_row : row_t;   -- fila 0 antes de actualizarse
    signal rand_row  : row_t;
    signal lfsr      : std_logic_vector(31 downto 0) := (others => '0');

begin

    busy <= '0' when state = IDLE else '1';

    -- LFSR de 32 bits libre (taps 32,22,2,1, XNOR). La semilla efectiva
    -- depende de cuando se presiona el boton.
    process(clk)
    begin
        if rising_edge(clk) then
            lfsr <= lfsr(30 downto 0) & (lfsr(31) xnor lfsr(21) xnor lfsr(1) xnor lfsr(0));
        end if;
    end process;

    process(clk)
        variable dn : row_t;
    begin
        if rising_edge(clk) then
            rd_row_data <= grid(rd_row);

            if rst = '1' then
                state <= IDLE;
                grid  <= INIT_PATTERN;
            else
                case state is
                    when IDLE =>
                        row <= 0;
                        col <= 0;
                        if cmd_load = '1' then
                            grid <= INIT_PATTERN;
                        elsif cmd_random = '1' then
                            state <= RAND;
                        elsif cmd_step = '1' then
                            prev_row  <= grid(ROWS-1);
                            first_row <= grid(0);
                            state     <= STEP;
                        end if;

                    when STEP =>
                        if row = ROWS-1 then
                            dn := first_row;
                        else
                            dn := grid(row + 1);
                        end if;
                        grid(row) <= next_row(prev_row, grid(row), dn);
                        prev_row  <= grid(row);
                        if row = ROWS-1 then
                            state <= IDLE;
                        else
                            row <= row + 1;
                        end if;

                    when RAND =>
                        rand_row <= rand_row(COLS-2 downto 0) & lfsr(31);
                        if col = COLS-1 then
                            col       <= 0;
                            grid(row) <= rand_row(COLS-2 downto 0) & lfsr(31);
                            if row = ROWS-1 then
                                state <= IDLE;
                            else
                                row <= row + 1;
                            end if;
                        else
                            col <= col + 1;
                        end if;
                end case;
            end if;
        end if;
    end process;

end Behavioral;
