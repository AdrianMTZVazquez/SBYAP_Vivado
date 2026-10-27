# botones (activos en bajo)
set_property PACKAGE_PIN M15 [get_ports key1]
set_property PACKAGE_PIN M14 [get_ports key2]
# LEDs (activos en bajo)
set_property PACKAGE_PIN J14 [get_ports {led[0]}]
set_property PACKAGE_PIN K14 [get_ports {led[1]}]
set_property PACKAGE_PIN J18 [get_ports {led[2]}]
set_property PACKAGE_PIN H18 [get_ports {led[3]}]
# Voltaje definido por separado
set_property IOSTANDARD LVCMOS33 [get_ports {key1 key2}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[*]}]