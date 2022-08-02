`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/19 21:22:39
// Design Name: 
// Module Name: multiply
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module multiply(
			input cnn_clk,     
			
			input [8:0] dina,   //unsigned
			input [8:0] dinb,   //signed
			
			
			output reg [18:0] dout
    );


(* use_dsp = "yes" *)wire [16:0] dout_reg;

//mul1 mul1_inst1(.CLK(cnn_clk), .A(dina), .B(dinb), .P(dout_reg));
//assign dout_reg = dina[7:0]*dinb[7:0];
assign dout_reg = (dinb==9'b0) ? 0 :dina[7:0]*dinb[7:0];
//assign dout = dinb[8] ? {2'b11,~dout_reg}+1'b1 : dout_reg;
always @ ( posedge cnn_clk )
begin
     //dout_reg = (dinb==9'b0) ? 0 :dina[7:0]*dinb[7:0];
	 dout = dinb[8] ? {3'b11,~dout_reg}+1'b1 : dout_reg;

end

endmodule
