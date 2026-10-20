----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/13/2026 03:54:21 PM
-- Design Name: 
-- Module Name: top_and - Behavioral
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

entity top_and is
    Port (
        key1 : in std_logic;
        key2 : in std_logic;
        led1 : out std_logic 
    );
end top_and;

architecture Behavioral of top_and is
    signal a, b, y : std_logic;
begin
    a <= not key1;
    b <= not key2;
    
    u_and : entity work.and_dsg
        Port Map (
            a => a,
            b => b,
            y => y
        );
        
    led1 <= not y;
end Behavioral;
