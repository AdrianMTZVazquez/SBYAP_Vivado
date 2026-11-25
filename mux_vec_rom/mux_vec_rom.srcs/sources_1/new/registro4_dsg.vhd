----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/03/2026 03:17:53 PM
-- Design Name: 
-- Module Name: registro4_dsg - Behavioral
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

entity registro4_dsg is
    Port (
        clk : in  STD_LOGIC;
        en  : in  STD_LOGIC;                    -- '1' = guardar
        d   : in  STD_LOGIC_VECTOR(3 downto 0);
        q   : out STD_LOGIC_VECTOR(3 downto 0)
    );
end registro4_dsg;

architecture Behavioral of registro4_dsg is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if en = '1' then
                q <= d;          -- guarda en el flanco de subida
            end if;              -- si en = '0', q conserva su valor
        end if;
    end process;
end Behavioral;
