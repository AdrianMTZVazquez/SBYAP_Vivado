## Tarjeta 1: top_rom (copiado del XDC maestro ax7z020b_base.xdc)
## Botones (activos en bajo)
set_property -dict {PACKAGE_PIN M15 IOSTANDARD LVCMOS33} [get_ports {key[0]}]
set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports {key[1]}]
## LEDs (activos en bajo)
set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports {led[0]}]
set_property -dict {PACKAGE_PIN K14 IOSTANDARD LVCMOS33} [get_ports {led[1]}]
set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports {led[2]}]
set_property -dict {PACKAGE_PIN H18 IOSTANDARD LVCMOS33} [get_ports {led[3]}]