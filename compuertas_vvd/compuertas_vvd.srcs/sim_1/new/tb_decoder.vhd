----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/20/2026 03:17:18 PM
-- Design Name: 
-- Module Name: tb_decoder - Sim
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

entity tb_decoder is
--  Port ( );
end tb_decoder;

architecture Sim of tb_decoder is
    signal a1, a0 : STD_LOGIC := '0';
    signal sel_rom, sel_ram, sel_io, sel_disco : STD_LOGIC;
begin
    uut: entity work.decoder_dsg port map (
        a1 => a1, a0 => a0, sel_rom => sel_rom,
        sel_ram => sel_ram, sel_io => sel_io, sel_disco => sel_disco);
    process begin
      a1 <= '0'; a0 <= '0'; wait for 10 ns;
      a1 <= '0'; a0 <= '1'; wait for 10 ns;
      a1 <= '1'; a0 <= '0'; wait for 10 ns;
      a1 <= '1'; a0 <= '1'; wait for 10 ns;
      wait;
    end process;
end Sim;
