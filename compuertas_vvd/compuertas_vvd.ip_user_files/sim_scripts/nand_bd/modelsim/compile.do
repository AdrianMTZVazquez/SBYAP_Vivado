vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vcom -work xil_defaultlib -64 -93  \
"../../../bd/nand_bd/ip/nand_bd_and_dsg_0_0/sim/nand_bd_and_dsg_0_0.vhd" \
"../../../bd/nand_bd/ip/nand_bd_not_dsg_0_0/sim/nand_bd_not_dsg_0_0.vhd" \
"../../../bd/nand_bd/sim/nand_bd.vhd" \


