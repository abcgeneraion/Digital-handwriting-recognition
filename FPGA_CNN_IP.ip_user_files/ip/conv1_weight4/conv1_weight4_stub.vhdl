-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Tue Dec 28 20:49:28 2021
-- Host        : DESKTOP-E85MPAB running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/Epoch/Desktop/FPGA_CNN_IP/FPGA_CNN_IP/FPGA_CNN_IP.srcs/sources_1/ip/conv1_weight4/conv1_weight4_stub.vhdl
-- Design      : conv1_weight4
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity conv1_weight4 is
  Port ( 
    clka : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 4 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );

end conv1_weight4;

architecture stub of conv1_weight4 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clka,addra[4:0],douta[15:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "blk_mem_gen_v8_4_2,Vivado 2018.3";
begin
end;
