`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/19 21:27:03
// Design Name: 
// Module Name: maxpooling2
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


module maxpooling2(
			
			input cnn_clk,
			
			input wr_en,
			input conv1_done,
			input [11:0] norm_result1,
			input [11:0] norm_result2,
            input [11:0] norm_result3,
			input [11:0] norm_result4,
			input [11:0] norm_result5,
			input [11:0] norm_result6,
			input [3:0] feature_map_counter,
			output reg buffer_en,
			output reg [11:0] max
			//output reg relu_en,
			//output reg [2:0] adder_counter,
			//output reg [6:0] addra=7'd0
			
    );


wire [15:0] bias [15:0];

assign bias[0] = 16'h0399;
assign bias[1] = 16'h021a;
assign bias[2] = 16'h813d;
assign bias[3] = 16'h0256;
assign bias[4] = 16'h80e6;
assign bias[5] = 16'h82d7;
assign bias[6] = 16'h0206;
assign bias[7] = 16'h826e;
assign bias[8] = 16'h023b;
assign bias[9] = 16'h80c6;
assign bias[10] = 16'h0334;
assign bias[11] = 16'h8476;
assign bias[12] = 16'h01a7;
assign bias[13] = 16'h83f9;
assign bias[14] = 16'h8110;
assign bias[15] = 16'h0030;

wire [11:0] bias_amend;
//bias[feature_map_counter]的第15位是不是等于1（是不是为负）如果为负，取补码，否则，等于原码
assign bias_amend = bias[feature_map_counter][15] ? {4'b1111,~bias[feature_map_counter][14:7]}+1'b1 : bias[feature_map_counter][15:7];

reg relu_en=1'b0;

reg [6:0] addra=7'd0;
reg [1:0] adder_counter=2'd0;



reg [11:0] buffer_8x12 [95:0];

reg [6:0] relu_row=7'd0;     //0-40
reg [3:0] relu_column=4'd0;

 //0-5

always @ ( posedge cnn_clk )
begin
	if(wr_en && conv1_done) begin
		addra <= addra+1'b1;
		//cc=norm_result1+norm_result2;
		//dd=norm_result3+norm_result4;
		//ee=norm_result6+bias_amend;
		//ff= cc+dd;
		//buffer_8x12[addra] = ff+ee;	
		buffer_8x12[addra] <= norm_result1+norm_result2+norm_result3+norm_result4+norm_result5+norm_result6+bias_amend;		
		end
		if(addra == 7'd95) begin
			addra <= 7'd0;
			relu_en <= 1'b1;
			
		end
	
	else if(relu_en) begin	
			if(relu_column < 4'd6) begin
				relu_column <= relu_column+2;
			end
			else begin
				relu_column <= 4'd0;
				if(relu_row < 7'd72) begin
					relu_row <= relu_row+24;
				end
				else begin
					relu_en <= 1'b0;
					relu_row <= 7'd0;
				end
			end
	end
end




reg [11:0] matrix1_1,matrix1_2;
reg [11:0] matrix2_1,matrix2_2;



//clk1
always @ ( posedge cnn_clk )
begin
	if(relu_en) begin
		matrix1_1 <= buffer_8x12[relu_column+relu_row];
		matrix1_2 <= buffer_8x12[relu_column+relu_row+1];
		matrix2_1 <= buffer_8x12[relu_column+relu_row+12];
		matrix2_2 <= buffer_8x12[relu_column+relu_row+13];
	end	
end


reg [11:0] max0,max1;


//clk2
always @ ( posedge cnn_clk )
begin
	if(matrix1_1[11] && matrix1_2[11]) begin
		max0 <= (matrix1_1 > matrix1_2) ? matrix1_2 : matrix1_1;
	end
	else if(!matrix1_1[11] && matrix1_2[11]) begin
		max0 <= matrix1_1;
	end
	else if(matrix1_1[11] && !matrix1_2[11]) begin
		max0 <= matrix1_2;
	end
	else if(!matrix1_1[11] && !matrix1_2[11]) begin
		max0 <= (matrix1_1 > matrix1_2) ? matrix1_1 : matrix1_2;
	end
end

always @ ( posedge cnn_clk )
begin
	if(matrix2_1[11] && matrix2_2[11]) begin
		max1 <= (matrix2_1 > matrix2_2) ? matrix2_2 : matrix2_1;
	end
	else if(!matrix2_1[11] && matrix2_2[11]) begin
		max1 <= matrix2_1;
	end
	else if(matrix2_1[11] && !matrix2_2[11]) begin
		max1 <= matrix2_2;
	end
	else if(!matrix2_1[11] && !matrix2_2[11]) begin
		max1 <= (matrix2_1 > matrix2_2) ? matrix2_1 : matrix2_2;
	end
end


//clk3
always @ ( posedge cnn_clk )
begin
	if(max0[11] && max1[11]) begin
		max <= (max0 > max1) ? max1 : max0;
	end
	else if(!max0[11] && max1[11]) begin
		max <= max0;
	end
	else if(max0[11] && !max1[11]) begin
		max <= max1;
	end
	else if(!max0[11] && !max1[11]) begin
		max <= (max0 > max1) ? max0 : max1;
	end
end

reg relu_en1,relu_en2;

always @ ( posedge cnn_clk )     //relu????
begin
	relu_en1 <= relu_en;
	relu_en2 <= relu_en1;
	buffer_en <= relu_en2;
end



endmodule

