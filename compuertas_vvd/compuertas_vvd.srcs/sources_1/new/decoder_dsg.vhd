----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/20/2026 03:09:21 PM
-- Design Name: 
-- Module Name: decoder_dsg - Behavioral
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

entity decoder_dsg is
    Port (
        a1, a0    : in  STD_LOGIC;
        sel_rom   : out STD_LOGIC;
        sel_ram   : out STD_LOGIC;
        sel_io    : out STD_LOGIC;
        sel_disco : out STD_LOGIC
    );
end decoder_dsg;

architecture Behavioral of decoder_dsg is

begin
    sel_rom   <= (not a1) and (not a0);
    sel_ram   <= (not a1) and a0;
    sel_io    <= a1 and (not a0);
    sel_disco <= a1 and a0;
end Behavioral;
