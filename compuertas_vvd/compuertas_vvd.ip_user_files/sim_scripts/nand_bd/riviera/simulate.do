transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+nand_bd  -L xil_defaultlib -L secureip -O5 xil_defaultlib.nand_bd

do {nand_bd.udo}

run 1000ns

endsim

quit -force
