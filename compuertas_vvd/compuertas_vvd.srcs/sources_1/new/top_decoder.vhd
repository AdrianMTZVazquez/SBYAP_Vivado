----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2026 02:24:09 PM
-- Design Name: 
-- Module Name: top_decoder - Behavioral
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

entity top_decoder is
    Port (
        key1, key2 : in  STD_LOGIC;
        led : out STD_LOGIC_VECTOR(3 downto 0)
    );
end top_decoder;

architecture Behavioral of top_decoder is
    signal a1, a0, s0, s1, s2, s3 : STD_LOGIC;
begin
    a0 <= not key1;  a1 <= not key2;
    u_dec: entity work.decoder_dsg port map (
        a1, a0, s0, s1, s2, s3);
    led(0) <= not s0;  led(1) <= not s1;
    led(2) <= not s2;  led(3) <= not s3;
end Behavioral;
