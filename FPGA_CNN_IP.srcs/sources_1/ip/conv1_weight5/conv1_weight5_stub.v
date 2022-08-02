// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Tue Dec 28 20:51:12 2021
// Host        : DESKTOP-E85MPAB running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/Epoch/Desktop/FPGA_CNN_IP/FPGA_CNN_IP/FPGA_CNN_IP.srcs/sources_1/ip/conv1_weight5/conv1_weight5_stub.v
// Design      : conv1_weight5
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_2,Vivado 2018.3" *)
module conv1_weight5(clka, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,addra[4:0],douta[15:0]" */;
  input clka;
  input [4:0]addra;
  output [15:0]douta;
endmodule
