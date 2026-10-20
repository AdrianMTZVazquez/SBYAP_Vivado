-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2026.1 (lin64) Build 6511674 Tue Jun 16 11:01:26 MDT 2026
-- Date        : Thu Oct  8 16:09:11 2026
-- Host        : labperception-ciiccte running 64-bit Ubuntu 24.04.5 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /home/labperception/compuertas_vvd/compuertas_vvd.gen/sources_1/bd/nand_bd/nand_bd_sim_netlist.vhdl
-- Design      : nand_bd
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a200tfbg676-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity nand_bd_and_dsg_0_0 is
  port (
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    y : out STD_LOGIC
  );
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of nand_bd_and_dsg_0_0 : entity is "nand_bd_and_dsg_0_0,and_dsg,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of nand_bd_and_dsg_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of nand_bd_and_dsg_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of nand_bd_and_dsg_0_0 : entity is "and_dsg,Vivado 2026.1";
end nand_bd_and_dsg_0_0;

architecture STRUCTURE of nand_bd_and_dsg_0_0 is
begin
y_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => a,
      I1 => b,
      O => y
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity nand_bd_not_dsg_0_0 is
  port (
    a : in STD_LOGIC;
    y : out STD_LOGIC
  );
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of nand_bd_not_dsg_0_0 : entity is "nand_bd_not_dsg_0_0,not_dsg,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of nand_bd_not_dsg_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of nand_bd_not_dsg_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of nand_bd_not_dsg_0_0 : entity is "not_dsg,Vivado 2026.1";
end nand_bd_not_dsg_0_0;

architecture STRUCTURE of nand_bd_not_dsg_0_0 is
begin
y_INST_0: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => a,
      O => y
    );
end STRUCTURE;
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
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of nand_bd : entity is true;
  attribute hw_handoff : string;
  attribute hw_handoff of nand_bd : entity is "nand_bd.hwdef";
end nand_bd;

architecture STRUCTURE of nand_bd is
  signal and_dsg_0_y : STD_LOGIC;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of and_dsg_0 : label is "nand_bd_and_dsg_0_0,and_dsg,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of and_dsg_0 : label is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of and_dsg_0 : label is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of and_dsg_0 : label is "and_dsg,Vivado 2026.1";
  attribute CHECK_LICENSE_TYPE of not_dsg_0 : label is "nand_bd_not_dsg_0_0,not_dsg,{}";
  attribute downgradeipidentifiedwarnings of not_dsg_0 : label is "yes";
  attribute ip_definition_source of not_dsg_0 : label is "module_ref";
  attribute x_core_info of not_dsg_0 : label is "not_dsg,Vivado 2026.1";
begin
and_dsg_0: entity work.nand_bd_and_dsg_0_0
     port map (
      a => a_0,
      b => b_0,
      y => and_dsg_0_y
    );
not_dsg_0: entity work.nand_bd_not_dsg_0_0
     port map (
      a => and_dsg_0_y,
      y => y_0
    );
end STRUCTURE;
