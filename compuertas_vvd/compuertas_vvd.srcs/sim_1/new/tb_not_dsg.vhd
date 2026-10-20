----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/08/2026 03:34:57 PM
-- Design Name: 
-- Module Name: tb_not_dsg - Sim
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

entity tb_not_dsg is
end tb_not_dsg;

architecture Sim of tb_not_dsg is
    signal tb_a : std_logic := '0';
    signal tb_y : std_logic;
begin
    uut : entity work.not_dsg
        Port Map (
            a => tb_a,
            y => tb_y
        );
    process
    begin
        tb_a <= '0'; wait for 10 ns;
        tb_a <= '1'; wait for 10 ns;
    end process;
end Sim;
