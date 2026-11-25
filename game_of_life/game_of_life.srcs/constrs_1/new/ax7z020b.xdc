# ALINX AX7Z020B - pines segun AX7Z020B_User_Manual (bancos 34/35 a 3.3 V)

# Reloj PL 50 MHz (PL_GCLK1)
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports sys_clk]
create_clock -period 20.000 -name sys_clk [get_ports sys_clk]

# Botones de usuario KEY1..KEY4 (activos en bajo)
set_property -dict {PACKAGE_PIN M15 IOSTANDARD LVCMOS33} [get_ports {keys_n[0]}]
set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports {keys_n[1]}]
set_property -dict {PACKAGE_PIN L17 IOSTANDARD LVCMOS33} [get_ports {keys_n[2]}]
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports {keys_n[3]}]

# LEDs de usuario LED1..LED4 (activos en bajo)
set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports {leds_n[0]}]
set_property -dict {PACKAGE_PIN K14 IOSTANDARD LVCMOS33} [get_ports {leds_n[1]}]
set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports {leds_n[2]}]
set_property -dict {PACKAGE_PIN H18 IOSTANDARD LVCMOS33} [get_ports {leds_n[3]}]

# HDMI TMDS (banco 34)
set_property -dict {PACKAGE_PIN U13 IOSTANDARD TMDS_33} [get_ports hdmi_clk_p]
set_property -dict {PACKAGE_PIN V13 IOSTANDARD TMDS_33} [get_ports hdmi_clk_n]
set_property -dict {PACKAGE_PIN W14 IOSTANDARD TMDS_33} [get_ports {hdmi_d_p[0]}]
set_property -dict {PACKAGE_PIN Y14 IOSTANDARD TMDS_33} [get_ports {hdmi_d_n[0]}]
set_property -dict {PACKAGE_PIN Y18 IOSTANDARD TMDS_33} [get_ports {hdmi_d_p[1]}]
set_property -dict {PACKAGE_PIN Y19 IOSTANDARD TMDS_33} [get_ports {hdmi_d_n[1]}]
set_property -dict {PACKAGE_PIN Y16 IOSTANDARD TMDS_33} [get_ports {hdmi_d_p[2]}]
set_property -dict {PACKAGE_PIN Y17 IOSTANDARD TMDS_33} [get_ports {hdmi_d_n[2]}]

# Botones y LEDs son asincronos / lentos
set_false_path -from [get_ports {keys_n[*]}]
set_false_path -to [get_ports {leds_n[*]}]

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
