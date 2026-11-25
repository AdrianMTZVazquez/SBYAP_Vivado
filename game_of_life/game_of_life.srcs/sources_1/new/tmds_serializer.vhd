----------------------------------------------------------------------------------
-- Module Name: tmds_serializer
-- Description: Serializador 10:1 para un canal TMDS. Dos OSERDESE2 en cascada
--   (maestro + esclavo) en modo DDR: clk_x5 = 5 x clk_pix. Bit 0 sale primero.
--   Salida diferencial con OBUFDS (IOSTANDARD TMDS_33 en el XDC).
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity tmds_serializer is
    port (
        clk_pix : in  std_logic;
        clk_x5  : in  std_logic;
        rst     : in  std_logic;
        data    : in  std_logic_vector(9 downto 0);
        out_p   : out std_logic;
        out_n   : out std_logic
    );
end tmds_serializer;

architecture Behavioral of tmds_serializer is
    signal shift1, shift2 : std_logic;
    signal serial         : std_logic;
begin

    master : OSERDESE2
        generic map (
            DATA_RATE_OQ   => "DDR",
            DATA_RATE_TQ   => "SDR",
            DATA_WIDTH     => 10,
            SERDES_MODE    => "MASTER",
            TRISTATE_WIDTH => 1)
        port map (
            OQ        => serial,
            OFB       => open,
            TQ        => open,
            TFB       => open,
            SHIFTOUT1 => open,
            SHIFTOUT2 => open,
            TBYTEOUT  => open,
            CLK       => clk_x5,
            CLKDIV    => clk_pix,
            D1 => data(0), D2 => data(1), D3 => data(2), D4 => data(3),
            D5 => data(4), D6 => data(5), D7 => data(6), D8 => data(7),
            OCE       => '1',
            RST       => rst,
            SHIFTIN1  => shift1,
            SHIFTIN2  => shift2,
            T1 => '0', T2 => '0', T3 => '0', T4 => '0',
            TBYTEIN   => '0',
            TCE       => '0');

    slave : OSERDESE2
        generic map (
            DATA_RATE_OQ   => "DDR",
            DATA_RATE_TQ   => "SDR",
            DATA_WIDTH     => 10,
            SERDES_MODE    => "SLAVE",
            TRISTATE_WIDTH => 1)
        port map (
            OQ        => open,
            OFB       => open,
            TQ        => open,
            TFB       => open,
            SHIFTOUT1 => shift1,
            SHIFTOUT2 => shift2,
            TBYTEOUT  => open,
            CLK       => clk_x5,
            CLKDIV    => clk_pix,
            D1 => '0', D2 => '0', D3 => data(8), D4 => data(9),
            D5 => '0', D6 => '0', D7 => '0', D8 => '0',
            OCE       => '1',
            RST       => rst,
            SHIFTIN1  => '0',
            SHIFTIN2  => '0',
            T1 => '0', T2 => '0', T3 => '0', T4 => '0',
            TBYTEIN   => '0',
            TCE       => '0');

    obuf : OBUFDS
        port map (I => serial, O => out_p, OB => out_n);

end Behavioral;
