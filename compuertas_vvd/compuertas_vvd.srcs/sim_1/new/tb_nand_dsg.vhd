----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/08/2026 04:13:14 PM
-- Design Name: 
-- Module Name: tb_nand_dsg - Sim
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

entity tb_nand_dsg is
end tb_nand_dsg;

architecture Sim of tb_nand_dsg is
    signal tb_a, tb_b: std_logic := '0';
    signal tb_y : std_logic;
begin
    uut : entity work.nand_bd_wrapper
        Port Map (
            a_0 => tb_a,
            b_0 => tb_b,
            y_0 => tb_y
        );
    process
    begin
        tb_a <= '0'; tb_b <= '0'; wait for 10 ns;
        tb_a <= '0'; tb_b <= '1'; wait for 10 ns;
        tb_a <= '1'; tb_b <= '0'; wait for 10 ns;
        tb_a <= '1'; tb_b <= '1'; wait for 10 ns;
    end process;
end Sim;
