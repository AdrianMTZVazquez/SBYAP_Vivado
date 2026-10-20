// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2026.1 (lin64) Build 6511674 Tue Jun 16 11:01:26 MDT 2026
// Date        : Thu Oct  8 16:09:11 2026
// Host        : labperception-ciiccte running 64-bit Ubuntu 24.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/labperception/compuertas_vvd/compuertas_vvd.gen/sources_1/bd/nand_bd/nand_bd_stub.v
// Design      : nand_bd
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tfbg676-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* core_generation_info = "nand_bd,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=nand_bd,x_ipVersion=1.00.a,x_ipLanguage=VHDL}" *) (* hw_handoff = "nand_bd.hwdef" *) 
module nand_bd(a_0, b_0, y_0)
/* synthesis syn_black_box black_box_pad_pin="a_0,b_0,y_0" */;
  input a_0;
  input b_0;
  output y_0;
endmodule
