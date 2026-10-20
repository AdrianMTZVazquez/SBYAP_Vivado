library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_and_dsg is
end tb_and_dsg;

architecture Sim of tb_and_dsg is
    signal tb_a, tb_b : std_logic := '0';
    signal tb_y       : std_logic;
begin
    uut : entity work.and_dsg
        Port map (
            a => tb_a,
            b => tb_b,
            y => tb_y);
    process
    begin
        tb_a <= '0'; tb_b <= '0'; wait for 10 ns;
        tb_a <= '0'; tb_b <= '1'; wait for 10 ns;
        tb_a <= '1'; tb_b <= '0'; wait for 10 ns;
        tb_a <= '1'; tb_b <= '1'; wait for 10 ns;
    end process;
end Sim;
