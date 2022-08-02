`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/28 19:05:27
// Design Name: 
// Module Name: result
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


module result(
    input cnn_clk,
    input [19:0] result1,
    input [19:0] result2,
    input [19:0] result3,
    input [19:0] result4,
    input [19:0] result5,
    input [19:0] result6,
    input [19:0] result7,
    input [19:0] result8,
    input [19:0] result9,
    input [19:0] result10,
    input [19:0]max10,
    output reg [3:0] output1
    );
   always@(posedge cnn_clk)begin
    case(max10)
            result1:output1<=4'h0;
            result2:output1<=4'h1;
            result3:output1<=4'h2;
            result4:output1<=4'h3;
            result5:output1<=4'h4;
            result6:output1<=4'h5;
            result7:output1<=4'h6;
            result8:output1<=4'h7;
            result9:output1<=4'h8;
            result10:output1<=4'h9;
            
            default:;
            
    endcase
end
endmodule

