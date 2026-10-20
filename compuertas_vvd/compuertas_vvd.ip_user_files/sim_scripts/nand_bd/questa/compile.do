vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vcom -work xil_defaultlib -64 -93  \
"../../../bd/nand_bd/ip/nand_bd_and_dsg_0_0/sim/nand_bd_and_dsg_0_0.vhd" \
"../../../bd/nand_bd/ip/nand_bd_not_dsg_0_0/sim/nand_bd_not_dsg_0_0.vhd" \
"../../../bd/nand_bd/sim/nand_bd.vhd" \


