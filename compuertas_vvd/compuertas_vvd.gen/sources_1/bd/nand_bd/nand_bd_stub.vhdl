-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2026.1 (lin64) Build 6511674 Tue Jun 16 11:01:26 MDT 2026
-- Date        : Thu Oct  8 16:09:11 2026
-- Host        : labperception-ciiccte running 64-bit Ubuntu 24.04.5 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/labperception/compuertas_vvd/compuertas_vvd.gen/sources_1/bd/nand_bd/nand_bd_stub.vhdl
-- Design      : nand_bd
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a200tfbg676-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nand_bd is
  Port ( 
    a_0 : in STD_LOGIC;
    b_0 : in STD_LOGIC;
    y_0 : out STD_LOGIC
  );

  attribute core_generation_info : string;
  attribute core_generation_info of nand_bd : entity is "nand_bd,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=nand_bd,x_ipVersion=1.00.a,x_ipLanguage=VHDL}";
  attribute hw_handoff : string;
  attribute hw_handoff of nand_bd : entity is "nand_bd.hwdef";
end nand_bd;

architecture stub of nand_bd is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "a_0,b_0,y_0";
begin
end;
