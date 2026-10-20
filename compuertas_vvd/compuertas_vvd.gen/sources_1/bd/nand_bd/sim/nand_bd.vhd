--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2026.1 (lin64) Build 6511674 Tue Jun 16 11:01:26 MDT 2026
--Date        : Thu Oct  8 16:08:36 2026
--Host        : labperception-ciiccte running 64-bit Ubuntu 24.04.5 LTS
--Command     : generate_target nand_bd.bd
--Design      : nand_bd
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity nand_bd is
  port (
    a_0 : in STD_LOGIC;
    b_0 : in STD_LOGIC;
    y_0 : out STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of nand_bd : entity is "nand_bd,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=nand_bd,x_ipVersion=1.00.a,x_ipLanguage=VHDL}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of nand_bd : entity is "nand_bd.hwdef";
end nand_bd;

architecture STRUCTURE of nand_bd is
  component nand_bd_and_dsg_0_0 is
  port (
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    y : out STD_LOGIC
  );
  end component nand_bd_and_dsg_0_0;
  component nand_bd_not_dsg_0_0 is
  port (
    a : in STD_LOGIC;
    y : out STD_LOGIC
  );
  end component nand_bd_not_dsg_0_0;
  signal and_dsg_0_y : STD_LOGIC;
begin
and_dsg_0: component nand_bd_and_dsg_0_0
     port map (
      a => a_0,
      b => b_0,
      y => and_dsg_0_y
    );
not_dsg_0: component nand_bd_not_dsg_0_0
     port map (
      a => and_dsg_0_y,
      y => y_0
    );
end STRUCTURE;
