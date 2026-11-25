----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/03/2026 03:20:02 PM
-- Design Name: 
-- Module Name: tb_registro4 - Sim
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_registro4 is
--  Port ( );
end tb_registro4;

architecture Sim of tb_registro4 is
    signal clk : STD_LOGIC := '0';
    signal en  : STD_LOGIC := '0';
    signal d   : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal q   : STD_LOGIC_VECTOR(3 downto 0);
begin
    clk <= not clk after 5 ns;        -- reloj de 10 ns (100 MHz)

    uut: entity work.registro4_dsg
        port map (clk => clk, en => en, d => d, q => q);

    process
    begin
        wait for 12 ns;
        d <= "1010"; en <= '1'; wait for 10 ns;   -- guarda 1010
        en <= '0';
        d <= "0110";            wait for 30 ns;   -- d cambia, q NO (recuerda 1010)
        en <= '1';              wait for 10 ns;   -- ahora si guarda 0110
        en <= '0';
        d <= "1111";            wait for 30 ns;   -- q se queda en 0110
        wait;
    end process;
end Sim;
