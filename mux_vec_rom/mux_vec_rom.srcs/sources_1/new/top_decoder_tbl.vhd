----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/03/2026 03:07:58 PM
-- Design Name: 
-- Module Name: top_decoder_tbl - Behavioral
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

entity top_decoder_tbl is
    Port (
        key : in  STD_LOGIC_VECTOR(1 downto 0);
        led : out STD_LOGIC_VECTOR(3 downto 0)
    );
end top_decoder_tbl;

architecture Behavioral of top_decoder_tbl is
    signal dir  : STD_LOGIC_VECTOR(1 downto 0);
    signal dato : STD_LOGIC_VECTOR(3 downto 0);
begin
    dir <= not key;  -- botón = '1'
    u_rom: entity work.decoder_vec_dsg
      port map (dir => dir, sel => dato);
    led <= not dato; -- '1' = encendido
end Behavioral;
