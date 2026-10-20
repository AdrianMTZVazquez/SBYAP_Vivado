//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2026.1 (lin64) Build 6511674 Tue Jun 16 11:01:26 MDT 2026
//Date        : Thu Oct  8 16:06:47 2026
//Host        : labperception-ciiccte running 64-bit Ubuntu 24.04.5 LTS
//Command     : generate_target nand_bd.bd
//Design      : nand_bd
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "nand_bd,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=nand_bd,x_ipVersion=1.00.a,x_ipLanguage=VERILOG}" *) (* HW_HANDOFF = "nand_bd.hwdef" *) 
module nand_bd
   (a_0,
    b_0,
    y_0);
  input a_0;
  input b_0;
  output y_0;

  wire a_0;
  wire and_dsg_0_y;
  wire b_0;
  wire y_0;

  nand_bd_and_dsg_0_0 and_dsg_0
       (.a(a_0),
        .b(b_0),
        .y(and_dsg_0_y));
  nand_bd_not_dsg_0_0 not_dsg_0
       (.a(and_dsg_0_y),
        .y(y_0));
endmodule
