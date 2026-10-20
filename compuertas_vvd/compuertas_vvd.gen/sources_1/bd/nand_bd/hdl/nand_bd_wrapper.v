//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2026.1 (lin64) Build 6511674 Tue Jun 16 11:01:26 MDT 2026
//Date        : Thu Oct  8 16:06:47 2026
//Host        : labperception-ciiccte running 64-bit Ubuntu 24.04.5 LTS
//Command     : generate_target nand_bd_wrapper.bd
//Design      : nand_bd_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module nand_bd_wrapper
   (a_0,
    b_0,
    y_0);
  input a_0;
  input b_0;
  output y_0;

  wire a_0;
  wire b_0;
  wire y_0;

  nand_bd nand_bd_i
       (.a_0(a_0),
        .b_0(b_0),
        .y_0(y_0));
endmodule
