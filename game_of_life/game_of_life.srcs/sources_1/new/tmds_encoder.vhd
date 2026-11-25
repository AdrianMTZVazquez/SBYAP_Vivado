----------------------------------------------------------------------------------
-- Module Name: tmds_encoder
-- Description: Codificador TMDS 8b/10b segun la especificacion DVI 1.0.
--   de = '1' : codifica el pixel (minimiza transiciones y balancea DC)
--   de = '0' : envia el token de control c1c0 (hsync/vsync en el canal azul)
--   q(0) es el primer bit que se transmite.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tmds_encoder is
    port (
        clk  : in  std_logic;
        data : in  std_logic_vector(7 downto 0);
        c    : in  std_logic_vector(1 downto 0);
        de   : in  std_logic;
        q    : out std_logic_vector(9 downto 0)
    );
end tmds_encoder;

architecture Behavioral of tmds_encoder is

    function ones(v : std_logic_vector) return integer is
        variable n : integer := 0;
    begin
        for i in v'range loop
            if v(i) = '1' then n := n + 1; end if;
        end loop;
        return n;
    end function;

    -- Disparidad acumulada (unos - ceros) de lo ya transmitido
    signal cnt : integer range -16 to 16 := 0;

begin

    process(clk)
        variable qm       : std_logic_vector(8 downto 0);
        variable n1d, n1q : integer range 0 to 8;
        variable diff     : integer range -8 to 8;  -- unos - ceros en qm(7:0)
    begin
        if rising_edge(clk) then
            -- Etapa 1: XOR o XNOR para minimizar transiciones
            n1d := ones(data);
            qm(0) := data(0);
            if n1d > 4 or (n1d = 4 and data(0) = '0') then
                for i in 1 to 7 loop
                    qm(i) := qm(i-1) xnor data(i);
                end loop;
                qm(8) := '0';
            else
                for i in 1 to 7 loop
                    qm(i) := qm(i-1) xor data(i);
                end loop;
                qm(8) := '1';
            end if;

            -- Etapa 2: balance DC
            n1q  := ones(qm(7 downto 0));
            diff := 2*n1q - 8;

            if de = '0' then
                cnt <= 0;
                case c is
                    when "00"   => q <= "1101010100";
                    when "01"   => q <= "0010101011";
                    when "10"   => q <= "0101010100";
                    when others => q <= "1010101011";
                end case;
            elsif cnt = 0 or diff = 0 then
                q(9) <= not qm(8);
                q(8) <= qm(8);
                if qm(8) = '1' then
                    q(7 downto 0) <= qm(7 downto 0);
                    cnt <= cnt + diff;
                else
                    q(7 downto 0) <= not qm(7 downto 0);
                    cnt <= cnt - diff;
                end if;
            elsif (cnt > 0 and diff > 0) or (cnt < 0 and diff < 0) then
                q(9) <= '1';
                q(8) <= qm(8);
                q(7 downto 0) <= not qm(7 downto 0);
                if qm(8) = '1' then
                    cnt <= cnt + 2 - diff;
                else
                    cnt <= cnt - diff;
                end if;
            else
                q(9) <= '0';
                q(8) <= qm(8);
                q(7 downto 0) <= qm(7 downto 0);
                if qm(8) = '1' then
                    cnt <= cnt + diff;
                else
                    cnt <= cnt - 2 + diff;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
