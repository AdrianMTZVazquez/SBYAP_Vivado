----------------------------------------------------------------------------------
-- Module Name: debounce
-- Description: Sincroniza y filtra un boton activo en bajo. Genera un pulso de
--   1 ciclo (press) cuando el boton se presiona y se mantiene estable durante
--   2**CNT_BITS ciclos (~10 ms con CNT_BITS = 18 a 25 MHz).
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounce is
    generic (
        CNT_BITS : positive := 18
    );
    port (
        clk   : in  std_logic;
        key_n : in  std_logic;
        press : out std_logic
    );
end debounce;

architecture Behavioral of debounce is
    signal sync   : std_logic_vector(1 downto 0) := "11";
    signal stable : std_logic := '1';
    signal cnt    : unsigned(CNT_BITS-1 downto 0) := (others => '0');
begin

    process(clk)
    begin
        if rising_edge(clk) then
            sync  <= sync(0) & key_n;
            press <= '0';
            if sync(1) = stable then
                cnt <= (others => '0');
            elsif cnt = 2**CNT_BITS - 1 then
                stable <= sync(1);
                cnt    <= (others => '0');
                if sync(1) = '0' then
                    press <= '1';
                end if;
            else
                cnt <= cnt + 1;
            end if;
        end if;
    end process;

end Behavioral;
