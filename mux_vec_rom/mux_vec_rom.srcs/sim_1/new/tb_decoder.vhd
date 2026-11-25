----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/27/2026 03:02:56 PM
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
    signal dir        : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal sel_vectr  : STD_LOGIC_VECTOR(3 downto 0);
    signal sel_tabla  : STD_LOGIC_VECTOR(3 downto 0); 
begin
    uut_ecuac: entity work.decoder_vec_dsg
      port map (dir => dir, sel => sel_vectr);
    uut_tabla: entity work.decoder_tbl_dsg
      port map (dir => dir, sel => sel_tabla);
    
    process
    begin
        dir <= "00"; wait for 10 ns;
        dir <= "01"; wait for 10 ns;
        dir <= "10"; wait for 10 ns;
        dir <= "11"; wait for 10 ns;
        wait;
    end process;
end Sim;
