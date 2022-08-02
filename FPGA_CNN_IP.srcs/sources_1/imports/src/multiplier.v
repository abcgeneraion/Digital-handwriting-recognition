`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/19 21:28:54
// Design Name: 
// Module Name: multiplier
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


module multiplier(
			input cnn_clk,     
			
			input [11:0] dina,   //unsigned
			input [11:0] dinb,   //signed
			
			
			output reg [22:0] dout
    );


reg [21:0] dout_reg;

//assign dout_reg = dina[10:0]*dinb[10:0];

always @ ( posedge cnn_clk )
begin
   dout_reg = dina[10:0]*dinb[10:0];
	dout = dinb[11] ? {1'b1,~dout_reg}+1'b1 : dout_reg;

end


endmodule

