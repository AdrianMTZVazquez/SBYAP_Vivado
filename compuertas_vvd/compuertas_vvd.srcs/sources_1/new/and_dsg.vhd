library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and_dsg is
    Port (
        a: in std_logic;
        b: in std_logic;
        y: out std_logic
    );
end and_dsg;

architecture Behavioral of and_dsg is
begin
    y <= a and b;
end Behavioral;
