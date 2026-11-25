----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/27/2026 02:58:05 PM
-- Design Name: 
-- Module Name: decoder_vec_dsg - Behavioral
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

entity decoder_vec_dsg is
    Port (
        dir : in  STD_LOGIC_VECTOR(1 downto 0);
        sel : out STD_LOGIC_VECTOR(3 downto 0)
    );
end decoder_vec_dsg;

architecture Behavioral of decoder_vec_dsg is
begin
    sel(0) <= (not dir(1)) and (not dir(0));   -- 00 ROM
    sel(1) <= (not dir(1)) and dir(0);         -- 01 RAM
    sel(2) <= dir(1)       and (not dir(0));   -- 10 E/S
    sel(3) <= dir(1)       and dir(0);         -- 11 Disco
end Behavioral;
