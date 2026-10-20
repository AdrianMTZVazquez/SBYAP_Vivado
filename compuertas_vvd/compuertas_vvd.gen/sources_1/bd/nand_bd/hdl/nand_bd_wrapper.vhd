--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2026.1 (lin64) Build 6511674 Tue Jun 16 11:01:26 MDT 2026
--Date        : Thu Oct  8 16:08:36 2026
--Host        : labperception-ciiccte running 64-bit Ubuntu 24.04.5 LTS
--Command     : generate_target nand_bd_wrapper.bd
--Design      : nand_bd_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity nand_bd_wrapper is
  port (
    a_0 : in STD_LOGIC;
    b_0 : in STD_LOGIC;
    y_0 : out STD_LOGIC
  );
end nand_bd_wrapper;

architecture STRUCTURE of nand_bd_wrapper is
  component nand_bd is
  port (
    a_0 : in STD_LOGIC;
    b_0 : in STD_LOGIC;
    y_0 : out STD_LOGIC
  );
  end component nand_bd;
begin
nand_bd_i: component nand_bd
     port map (
      a_0 => a_0,
      b_0 => b_0,
      y_0 => y_0
    );
end STRUCTURE;
