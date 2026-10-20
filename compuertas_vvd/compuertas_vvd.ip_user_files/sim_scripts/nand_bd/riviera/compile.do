transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vcom -work xil_defaultlib -93  -incr \
"../../../bd/nand_bd/ip/nand_bd_and_dsg_0_0/sim/nand_bd_and_dsg_0_0.vhd" \
"../../../bd/nand_bd/ip/nand_bd_not_dsg_0_0/sim/nand_bd_not_dsg_0_0.vhd" \
"../../../bd/nand_bd/sim/nand_bd.vhd" \


