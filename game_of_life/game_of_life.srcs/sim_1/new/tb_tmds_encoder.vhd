----------------------------------------------------------------------------------
-- Module Name: tb_tmds_encoder
-- Description: Envia datos pseudoaleatorios y periodos de control al codificador,
--   decodifica cada simbolo y verifica: dato recuperado, token de control
--   correcto y disparidad acumulada acotada (balance DC).
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_tmds_encoder is
end tb_tmds_encoder;

architecture Behavioral of tb_tmds_encoder is

    signal clk  : std_logic := '0';
    signal data : std_logic_vector(7 downto 0) := (others => '0');
    signal c    : std_logic_vector(1 downto 0) := "00";
    signal de   : std_logic := '0';
    signal q    : std_logic_vector(9 downto 0);
    signal done : boolean := false;

    function decode(s : std_logic_vector(9 downto 0)) return std_logic_vector is
        variable v : std_logic_vector(7 downto 0);
        variable d : std_logic_vector(7 downto 0);
    begin
        if s(9) = '1' then v := not s(7 downto 0); else v := s(7 downto 0); end if;
        d(0) := v(0);
        for i in 1 to 7 loop
            if s(8) = '1' then
                d(i) := v(i) xor v(i-1);
            else
                d(i) := v(i) xnor v(i-1);
            end if;
        end loop;
        return d;
    end function;

    function token(cc : std_logic_vector(1 downto 0)) return std_logic_vector is
    begin
        case cc is
            when "00"   => return "1101010100";
            when "01"   => return "0010101011";
            when "10"   => return "0101010100";
            when others => return "1010101011";
        end case;
    end function;

begin

    clk <= not clk after 20 ns when not done;

    dut : entity work.tmds_encoder
        port map (clk => clk, data => data, c => c, de => de, q => q);

    process
        variable lfsr      : std_logic_vector(15 downto 0) := x"ACE1";
        variable exp_d     : std_logic_vector(7 downto 0);
        variable exp_c     : std_logic_vector(1 downto 0);
        variable exp_de    : std_logic;
        variable disparity : integer := 0;
        variable max_disp  : integer := 0;
        variable errors    : integer := 0;
        variable n1        : integer;
    begin
        for i in 0 to 20000 loop
            -- Estimulo: lineas de 640 datos y 160 de control
            for k in 1 to 8 loop
                lfsr := lfsr(14 downto 0) & (lfsr(15) xor lfsr(13) xor lfsr(12) xor lfsr(10));
            end loop;
            exp_c := c;
            if (i mod 800) < 640 then
                exp_de := '1';
                -- Mezcla de valores aleatorios y fijos (colores del juego)
                case (i / 50) mod 4 is
                    when 0      => exp_d := lfsr(7 downto 0);
                    when 1      => exp_d := x"E0";
                    when 2      => exp_d := x"00";
                    when others => exp_d := x"FF";
                end case;
            else
                exp_de := '0';
                exp_d  := lfsr(7 downto 0);
                exp_c  := lfsr(9 downto 8);
            end if;
            de   <= exp_de;
            data <= exp_d;
            c    <= exp_c;
            wait until rising_edge(clk);
            wait for 1 ns;

            -- q corresponde al estimulo registrado en este flanco
            if exp_de = '1' then
                if decode(q) /= exp_d then
                    errors := errors + 1;
                    report "dato incorrecto en i=" & integer'image(i) severity error;
                end if;
                n1 := 0;
                for b in 0 to 9 loop
                    if q(b) = '1' then n1 := n1 + 1; end if;
                end loop;
                disparity := disparity + 2*n1 - 10;
                if abs(disparity) > max_disp then max_disp := abs(disparity); end if;
            else
                disparity := 0;
                if q /= token(exp_c) then
                    errors := errors + 1;
                    report "token incorrecto en i=" & integer'image(i) severity error;
                end if;
            end if;
        end loop;

        if max_disp > 20 then
            errors := errors + 1;
            report "disparidad fuera de rango: " & integer'image(max_disp) severity error;
        end if;
        report "tb_tmds_encoder: errores=" & integer'image(errors) &
               " disparidad_max=" & integer'image(max_disp) severity note;
        if errors = 0 then
            report "tb_tmds_encoder: PASS" severity note;
        else
            report "tb_tmds_encoder: FAIL" severity failure;
        end if;
        done <= true;
        wait;
    end process;

end Behavioral;
