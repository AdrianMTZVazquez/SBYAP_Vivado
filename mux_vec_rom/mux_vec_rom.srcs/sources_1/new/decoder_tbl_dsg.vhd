----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/27/2026 03:00:33 PM
-- Design Name: 
-- Module Name: decoder_tbl_dsg - Behavioral
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

entity decoder_tbl_dsg is
    Port (
        dir : in  STD_LOGIC_VECTOR(1 downto 0);
        sel : out STD_LOGIC_VECTOR(3 downto 0)
    );
end decoder_tbl_dsg;

architecture Behavioral of decoder_tbl_dsg is
begin
    with dir select
        sel <= "0001" when "00",
               "0010" when "01",
               "0100" when "10",
               "1000" when others;
end Behavioral;
