`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/19 21:13:52
// Design Name: 
// Module Name: cnn_struct
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



module cnn_struct(
        input cnn_clk,
		input [7:0]taps_4,
	    output [7:0] taps_3,
		output reg [3:0] dout,
	    input wr_done,
	    output reg [9:0] image_addr=10'd0
		//output reg [19:0] result1,
		//output reg [19:0] result2,
		//output reg [19:0] result3,
		//output reg [19:0] result4,
		//output reg [19:0] result5,
		//output reg [19:0] result6,	
		//output reg [19:0] result7,
		//output reg [19:0] result8,
		//output reg [19:0] result9,
		//output reg [19:0] result10
		


    );



//******************************************  产生5x5图像阵列 & 参数缓存  ***************************************************//
//*******************************************   数据准备     ************************************************//


reg [8:0] matrix1_1_1,matrix1_1_2,matrix1_1_3,matrix1_1_4,matrix1_1_5;
reg [8:0] matrix1_2_1,matrix1_2_2,matrix1_2_3,matrix1_2_4,matrix1_2_5;
reg [8:0] matrix1_3_1,matrix1_3_2,matrix1_3_3,matrix1_3_4,matrix1_3_5;
reg [8:0] matrix1_4_1,matrix1_4_2,matrix1_4_3,matrix1_4_4,matrix1_4_5;
reg [8:0] matrix1_5_1,matrix1_5_2,matrix1_5_3,matrix1_5_4,matrix1_5_5;

reg [8:0] matrix2_1_1,matrix2_1_2,matrix2_1_3,matrix2_1_4,matrix2_1_5;
reg [8:0] matrix2_2_1,matrix2_2_2,matrix2_2_3,matrix2_2_4,matrix2_2_5;
reg [8:0] matrix2_3_1,matrix2_3_2,matrix2_3_3,matrix2_3_4,matrix2_3_5;
reg [8:0] matrix2_4_1,matrix2_4_2,matrix2_4_3,matrix2_4_4,matrix2_4_5;
reg [8:0] matrix2_5_1,matrix2_5_2,matrix2_5_3,matrix2_5_4,matrix2_5_5;

reg [8:0] matrix3_1_1,matrix3_1_2,matrix3_1_3,matrix3_1_4,matrix3_1_5;
reg [8:0] matrix3_2_1,matrix3_2_2,matrix3_2_3,matrix3_2_4,matrix3_2_5;
reg [8:0] matrix3_3_1,matrix3_3_2,matrix3_3_3,matrix3_3_4,matrix3_3_5;
reg [8:0] matrix3_4_1,matrix3_4_2,matrix3_4_3,matrix3_4_4,matrix3_4_5;
reg [8:0] matrix3_5_1,matrix3_5_2,matrix3_5_3,matrix3_5_4,matrix3_5_5;

reg [8:0] matrix4_1_1,matrix4_1_2,matrix4_1_3,matrix4_1_4,matrix4_1_5;
reg [8:0] matrix4_2_1,matrix4_2_2,matrix4_2_3,matrix4_2_4,matrix4_2_5;
reg [8:0] matrix4_3_1,matrix4_3_2,matrix4_3_3,matrix4_3_4,matrix4_3_5;
reg [8:0] matrix4_4_1,matrix4_4_2,matrix4_4_3,matrix4_4_4,matrix4_4_5;
reg [8:0] matrix4_5_1,matrix4_5_2,matrix4_5_3,matrix4_5_4,matrix4_5_5;

reg [8:0] matrix5_1_1,matrix5_1_2,matrix5_1_3,matrix5_1_4,matrix5_1_5;
reg [8:0] matrix5_2_1,matrix5_2_2,matrix5_2_3,matrix5_2_4,matrix5_2_5;
reg [8:0] matrix5_3_1,matrix5_3_2,matrix5_3_3,matrix5_3_4,matrix5_3_5;
reg [8:0] matrix5_4_1,matrix5_4_2,matrix5_4_3,matrix5_4_4,matrix5_4_5;
reg [8:0] matrix5_5_1,matrix5_5_2,matrix5_5_3,matrix5_5_4,matrix5_5_5;

reg [8:0] matrix6_1_1,matrix6_1_2,matrix6_1_3,matrix6_1_4,matrix6_1_5;
reg [8:0] matrix6_2_1,matrix6_2_2,matrix6_2_3,matrix6_2_4,matrix6_2_5;
reg [8:0] matrix6_3_1,matrix6_3_2,matrix6_3_3,matrix6_3_4,matrix6_3_5;
reg [8:0] matrix6_4_1,matrix6_4_2,matrix6_4_3,matrix6_4_4,matrix6_4_5;
reg [8:0] matrix6_5_1,matrix6_5_2,matrix6_5_3,matrix6_5_4,matrix6_5_5;

reg [9:0] image_addr=10'd0;              //图片地址


reg [1:0] bias_addr=2'b0;               //参数地址
reg [4:0] weight_addr=5'd0;
reg [3:0] bias_addr2=4'b0;
reg [8:0] weight_addr2=9'd0;

wire [15:0] bias1_1,bias1_2,bias1_3,bias1_4,bias1_5,bias1_6;           //参数输出
wire [15:0] weight1_1,weight1_2,weight1_3,weight1_4,weight1_5,weight1_6;
//wire [15:0] bias3;
wire [15:0] weight2_1,weight2_2,weight2_3,weight2_4,weight2_5,weight2_6;
//reg c = 0;
//always #2.5 c <= ~c;
//assign cnn_clk = c;
conv1_weight1 weight1_inst(.clka (cnn_clk), .addra (weight_addr), .douta (weight1_1));           //第一层参数
conv1_weight2 weight2_inst(.clka (cnn_clk), .addra (weight_addr), .douta (weight1_2));
conv1_weight3 weight3_inst(.clka (cnn_clk), .addra (weight_addr), .douta (weight1_3));           //第一层参数
conv1_weight4 weight4_inst(.clka (cnn_clk), .addra (weight_addr), .douta (weight1_4));
conv1_weight5 weight5_inst(.clka (cnn_clk), .addra (weight_addr), .douta (weight1_5));           //第一层参数
conv1_weight6 weight6_inst(.clka (cnn_clk), .addra (weight_addr), .douta (weight1_6));
conv1_bias1 bias1_inst(.clka (cnn_clk), .addra (bias_addr), .douta (bias1_1));
conv1_bias2 bias2_inst(.clka (cnn_clk), .addra (bias_addr), .douta (bias1_2));
conv1_bias3 bias3_inst(.clka (cnn_clk), .addra (bias_addr), .douta (bias1_3));
conv1_bias4 bias4_inst(.clka (cnn_clk), .addra (bias_addr), .douta (bias1_4));
conv1_bias5 bias5_inst(.clka (cnn_clk), .addra (bias_addr), .douta (bias1_5));
conv1_bias6 bias6_inst(.clka (cnn_clk), .addra (bias_addr), .douta (bias1_6));


conv2_weight1 weight2_1_inst(.clka (cnn_clk), .addra (weight_addr2), .douta (weight2_1));      //第二层参数
conv2_weight2 weight2_2_inst(.clka (cnn_clk), .addra (weight_addr2), .douta (weight2_2));
conv2_weight3 weight2_3_inst(.clka (cnn_clk), .addra (weight_addr2), .douta (weight2_3));      //第二层参数
conv2_weight4 weight2_4_inst(.clka (cnn_clk), .addra (weight_addr2), .douta (weight2_4));
conv2_weight5 weight2_5_inst(.clka (cnn_clk), .addra (weight_addr2), .douta (weight2_5));      //第二层参数
conv2_weight6 weight2_6_inst(.clka (cnn_clk), .addra (weight_addr2), .douta (weight2_6));


wire [15:0] bias_switch1,bias_switch2,bias_switch3,bias_switch4,bias_switch5,bias_switch6;
wire [15:0] weight_switch1,weight_switch2,weight_switch3,weight_switch4,weight_switch5,weight_switch6;
assign bias_switch1 = conv1_done ? 16'd0 : bias1_1;
assign bias_switch2 = conv1_done ? 16'd0 : bias1_2;
assign bias_switch3 = conv1_done ? 16'd0 : bias1_3;
assign bias_switch4 = conv1_done ? 16'd0 : bias1_4;
assign bias_switch5 = conv1_done ? 16'd0 : bias1_5;
assign bias_switch6 = conv1_done ? 16'd0 : bias1_6;
assign weight_switch1 = conv1_done ? weight2_1 : weight1_1;
assign weight_switch2 = conv1_done ? weight2_2 : weight1_2;
assign weight_switch3 = conv1_done ? weight2_3 : weight1_3;
assign weight_switch4 = conv1_done ? weight2_4 : weight1_4;
assign weight_switch5 = conv1_done ? weight2_5 : weight1_5;
assign weight_switch6 = conv1_done ? weight2_6 : weight1_6;
     

wire [8:0] taps_0,taps_1,taps_2,taps_3,taps_4;     //阵列缓存
wire [8:0] taps1_5,taps1_6,taps1_7,taps1_8,taps1_9;
wire [8:0] taps2_5,taps2_6,taps2_7,taps2_8,taps2_9;
wire [8:0] taps3_5,taps3_6,taps3_7,taps3_8,taps3_9;
wire [8:0] taps4_5,taps4_6,taps4_7,taps4_8,taps4_9;
wire [8:0] taps5_5,taps5_6,taps5_7,taps5_8,taps5_9;
wire [8:0] taps6_5,taps6_6,taps6_7,taps6_8,taps6_9;


//image28  image_inst(.clka (cnn_clk), .addra (image_addr), .douta (taps_4)); 


reg weight_en1=1'b0;



always @ ( posedge cnn_clk ) 
begin         //循环三次                   卷积层1
		if(image_addr < 10'd835&& wr_done) begin
			image_addr <= image_addr+1'b1;               //图片地址（ROM)
			weight_en1 <= 1'b1;
		end
		
		if(weight_en1) begin                             //参数地址（ROM)
				if(weight_addr < 7'd25) begin               
					weight_addr <= weight_addr+1'b1;
					bias_addr <= 2'd0;
				end
				else begin
					weight_en1 <= 1'b0;
				end
		
	end
end

reg [8:0] conv1_layer_addr=9'd0;  //0-143
reg [8:0] conv1_layer_reg1=9'd0,conv1_layer_reg2=9'd0,conv1_layer_reg3=9'd0,conv1_layer_reg4=9'd0,conv1_layer_reg5=9'd0,conv1_layer_reg6=9'd0;
reg [1:0] counter1=2'b0;        //0-2
reg [5:0] counter2=6'd0;        //0-35

reg weight_en2=1'b0;

wire weight_en;
reg weight_en1_1,weight_en2_1;
always @ ( posedge cnn_clk )
begin
    weight_en1_1<=weight_en1;
    //weight_en1_2<=weight_en1_1;
    weight_en2_1<=weight_en2;
    //weight_en2_1<=weight_en2_1;
    end
assign weight_en = weight_en1_1 || weight_en2_1;
//assign weight_en = weight_en1 || weight_en2;

always @ ( posedge cnn_clk )
begin
	if(conv1_done) begin
		if(counter2 < 6'd16) begin                                                  //卷积层2
			if(conv1_layer_addr < 8'd160) begin
				conv1_layer_addr <= conv1_layer_addr+1'b1;
				weight_en2 <= 1'b1;
			end
			else begin
				conv1_layer_addr <= 7'd0;
				counter2 <= counter2+1'b1;
				
			end
			if(weight_en2) begin			
				if(counter2 == 6'd0) begin
					if(weight_addr2 < 10'd25) begin
						weight_addr2 <= weight_addr2+1'b1;
					end
					else begin
						weight_en2 <= 1'b0;
					end
				end
				else if(counter2 == 6'd1) begin
					if(weight_addr2 >= 10'd25 && weight_addr2 < 10'd50) begin
						weight_addr2 <= weight_addr2+1'b1;
					end
					else begin
						weight_en2 <= 1'b0;
					end
				end
				else if(counter2 == 6'd2) begin
					if(weight_addr2 >= 10'd50 && weight_addr2 < 10'd75) begin
						weight_addr2 <= weight_addr2+1'b1;
					end
					else begin
						weight_en2 <= 1'b0;
					end
				end
				else if(counter2 == 6'd3) begin
					if(weight_addr2 >= 10'd75 && weight_addr2 < 10'd100) begin
						weight_addr2 <= weight_addr2+1'b1;
					end
					else begin
						weight_en2 <= 1'b0;
					end
				end
				else if(counter2 == 6'd4) begin
					if(weight_addr2 >= 10'd100 && weight_addr2 < 10'd125) begin
						weight_addr2 <= weight_addr2+1'b1;
					end
					else begin
						weight_en2 <= 1'b0;
					end
				end
				else if(counter2 == 6'd5) begin
					if(weight_addr2 >= 10'd125 && weight_addr2 < 10'd150) begin
						weight_addr2 <= weight_addr2+1'b1;
					end
					else begin
						weight_en2 <= 1'b0;
					end
				end
				else if(counter2 == 6'd6) begin
					if(weight_addr2 >= 10'd150 && weight_addr2 < 10'd175) begin
						weight_addr2 <= weight_addr2+1'b1;
					end
					else begin
						weight_en2 <= 1'b0;
					end
				end
				else if(counter2 == 6'd7) begin
					if(weight_addr2 >= 10'd175 && weight_addr2 < 10'd200) begin
						weight_addr2 <= weight_addr2+1'b1;
					end
					else begin
						weight_en2 <= 1'b0;
					end
				end
				else if(counter2 == 6'd8) begin
					if(weight_addr2 >= 10'd200 && weight_addr2 < 10'd225) begin
						weight_addr2 <= weight_addr2+1'b1;
					end
					else begin
						weight_en2 <= 1'b0;
					end
				end
				else if(counter2 == 6'd9) begin
					if(weight_addr2 >= 10'd225 && weight_addr2 < 10'd250) begin
						weight_addr2 <= weight_addr2+1'b1;
					end
					else begin
						weight_en2 <= 1'b0;
					end
				end
				else if(counter2 == 6'd10) begin
					if(weight_addr2 >= 10'd250 && weight_addr2 < 10'd275) begin
						weight_addr2 <= weight_addr2+1'b1;
					end
					else begin
						weight_en2 <= 1'b0;
					end
				end
				else if(counter2 == 6'd11) begin
					if(weight_addr2 >= 10'd275 && weight_addr2 < 10'd300) begin
						weight_addr2 <= weight_addr2+1'b1;
					end
					else begin
						weight_en2 <= 1'b0;
					end
				end
				else if(counter2 == 6'd12) begin
					if(weight_addr2 >= 10'd300 && weight_addr2 < 10'd325) begin
						weight_addr2 <= weight_addr2+1'b1;
					end
					else begin
						weight_en2 <= 1'b0;
					end
				end
				else if(counter2 == 6'd13) begin
					if(weight_addr2 >= 10'd325 && weight_addr2 < 10'd350) begin
						weight_addr2 <= weight_addr2+1'b1;
					end
					else begin
						weight_en2 <= 1'b0;
					end
				end
				else if(counter2 == 6'd14) begin
					if(weight_addr2 >= 10'd350 && weight_addr2 < 10'd375) begin
						weight_addr2 <= weight_addr2+1'b1;
					end
					else begin
						weight_en2 <= 1'b0;
					end
				end
				else if(counter2 == 6'd15) begin
					if(weight_addr2 >= 10'd375 && weight_addr2 < 10'd400) begin
						weight_addr2 <= weight_addr2+1'b1;
					end
					else begin
						weight_en2 <= 1'b0;
					end
				end
			end
		end
	end
end



always @ ( posedge cnn_clk )
begin
	if(conv1_done) begin
		
			conv1_layer_reg1 <= buffer1_12x12[conv1_layer_addr];
			conv1_layer_reg2 <= buffer2_12x12[conv1_layer_addr];
		
			conv1_layer_reg3 <= buffer3_12x12[conv1_layer_addr];
			conv1_layer_reg4 <= buffer4_12x12[conv1_layer_addr];
		
			conv1_layer_reg5 <= buffer5_12x12[conv1_layer_addr];
			conv1_layer_reg6 <= buffer6_12x12[conv1_layer_addr];
		
	end
end



reg wr_en=1'b0;

always @ (posedge cnn_clk )               
begin
	if(!conv1_done) begin                      //第一层有效数据
		if(image_addr == 10'd125) begin        //第一个数从108开始	
			wr_en <= 1'b1;
		end
		else if(image_addr == 10'd797) begin
			wr_en <= 1'b0;
		end
	end
	else begin                                //第二层有效数据
		if(conv1_layer_addr == 7'd60) begin
			wr_en <= 1'b1;
		end
		else if(conv1_layer_addr == 8'd156) begin
			wr_en <= 1'b0;
		end
	end
end 


  

shift_ram_28 taps0x(.CLK (cnn_clk), .D (taps_4), .Q (taps_3));      //卷积核为5x5，产生5x5的阵列
shift_ram_28 taps1x(.CLK (cnn_clk), .D (taps_3), .Q (taps_2));
shift_ram_28 taps2x(.CLK (cnn_clk), .D (taps_2), .Q (taps_1));
shift_ram_28 taps3x(.CLK (cnn_clk), .D (taps_1), .Q (taps_0));

assign taps1_9 = conv1_layer_reg1;
assign taps2_9 = conv1_layer_reg2;
assign taps3_9 = conv1_layer_reg3;
assign taps4_9 = conv1_layer_reg4;
assign taps5_9 = conv1_layer_reg5;
assign taps6_9 = conv1_layer_reg6;

shift_ram_12 taps1_0y(.CLK (cnn_clk), .D (taps1_9), .Q (taps1_8));  //卷积核为5x5，产生5x5的阵列
shift_ram_12 taps1_1y(.CLK (cnn_clk), .D (taps1_8), .Q (taps1_7));
shift_ram_12 taps1_2y(.CLK (cnn_clk), .D (taps1_7), .Q (taps1_6));
shift_ram_12 taps1_3y(.CLK (cnn_clk), .D (taps1_6), .Q (taps1_5));

shift_ram_12 taps2_0y(.CLK (cnn_clk), .D (taps2_9), .Q (taps2_8));  //卷积核为5x5，产生5x5的阵列
shift_ram_12 taps2_1y(.CLK (cnn_clk), .D (taps2_8), .Q (taps2_7));
shift_ram_12 taps2_2y(.CLK (cnn_clk), .D (taps2_7), .Q (taps2_6));
shift_ram_12 taps2_3y(.CLK (cnn_clk), .D (taps2_6), .Q (taps2_5));

shift_ram_12 taps3_0y(.CLK (cnn_clk), .D (taps3_9), .Q (taps3_8));  //卷积核为5x5，产生5x5的阵列
shift_ram_12 taps3_1y(.CLK (cnn_clk), .D (taps3_8), .Q (taps3_7));
shift_ram_12 taps3_2y(.CLK (cnn_clk), .D (taps3_7), .Q (taps3_6));
shift_ram_12 taps3_3y(.CLK (cnn_clk), .D (taps3_6), .Q (taps3_5));

shift_ram_12 taps4_0y(.CLK (cnn_clk), .D (taps4_9), .Q (taps4_8));  //卷积核为5x5，产生5x5的阵列
shift_ram_12 taps4_1y(.CLK (cnn_clk), .D (taps4_8), .Q (taps4_7));
shift_ram_12 taps4_2y(.CLK (cnn_clk), .D (taps4_7), .Q (taps4_6));
shift_ram_12 taps4_3y(.CLK (cnn_clk), .D (taps4_6), .Q (taps4_5));

shift_ram_12 taps5_0y(.CLK (cnn_clk), .D (taps5_9), .Q (taps5_8));  //卷积核为5x5，产生5x5的阵列
shift_ram_12 taps5_1y(.CLK (cnn_clk), .D (taps5_8), .Q (taps5_7));
shift_ram_12 taps5_2y(.CLK (cnn_clk), .D (taps5_7), .Q (taps5_6));
shift_ram_12 taps5_3y(.CLK (cnn_clk), .D (taps5_6), .Q (taps5_5));

shift_ram_12 taps6_0y(.CLK (cnn_clk), .D (taps6_9), .Q (taps6_8));  //卷积核为5x5，产生5x5的阵列
shift_ram_12 taps6_1y(.CLK (cnn_clk), .D (taps6_8), .Q (taps6_7));
shift_ram_12 taps6_2y(.CLK (cnn_clk), .D (taps6_7), .Q (taps6_6));
shift_ram_12 taps6_3y(.CLK (cnn_clk), .D (taps6_6), .Q (taps6_5));


wire [44:0] matrix1_row1 = {matrix1_1_1,matrix1_1_2,matrix1_1_3,matrix1_1_4,matrix1_1_5};
wire [44:0] matrix1_row2 = {matrix1_2_1,matrix1_2_2,matrix1_2_3,matrix1_2_4,matrix1_2_5};
wire [44:0] matrix1_row3 = {matrix1_3_1,matrix1_3_2,matrix1_3_3,matrix1_3_4,matrix1_3_5};
wire [44:0] matrix1_row4 = {matrix1_4_1,matrix1_4_2,matrix1_4_3,matrix1_4_4,matrix1_4_5};
wire [44:0] matrix1_row5 = {matrix1_5_1,matrix1_5_2,matrix1_5_3,matrix1_5_4,matrix1_5_5};

wire [44:0] matrix2_row1 = {matrix2_1_1,matrix2_1_2,matrix2_1_3,matrix2_1_4,matrix2_1_5};
wire [44:0] matrix2_row2 = {matrix2_2_1,matrix2_2_2,matrix2_2_3,matrix2_2_4,matrix2_2_5};
wire [44:0] matrix2_row3 = {matrix2_3_1,matrix2_3_2,matrix2_3_3,matrix2_3_4,matrix2_3_5};
wire [44:0] matrix2_row4 = {matrix2_4_1,matrix2_4_2,matrix2_4_3,matrix2_4_4,matrix2_4_5};
wire [44:0] matrix2_row5 = {matrix2_5_1,matrix2_5_2,matrix2_5_3,matrix2_5_4,matrix2_5_5};

wire [44:0] matrix3_row1 = {matrix3_1_1,matrix3_1_2,matrix3_1_3,matrix3_1_4,matrix3_1_5};
wire [44:0] matrix3_row2 = {matrix3_2_1,matrix3_2_2,matrix3_2_3,matrix3_2_4,matrix3_2_5};
wire [44:0] matrix3_row3 = {matrix3_3_1,matrix3_3_2,matrix3_3_3,matrix3_3_4,matrix3_3_5};
wire [44:0] matrix3_row4 = {matrix3_4_1,matrix3_4_2,matrix3_4_3,matrix3_4_4,matrix3_4_5};
wire [44:0] matrix3_row5 = {matrix3_5_1,matrix3_5_2,matrix3_5_3,matrix3_5_4,matrix3_5_5};

wire [44:0] matrix4_row1 = {matrix4_1_1,matrix4_1_2,matrix4_1_3,matrix4_1_4,matrix4_1_5};
wire [44:0] matrix4_row2 = {matrix4_2_1,matrix4_2_2,matrix4_2_3,matrix4_2_4,matrix4_2_5};
wire [44:0] matrix4_row3 = {matrix4_3_1,matrix4_3_2,matrix4_3_3,matrix4_3_4,matrix4_3_5};
wire [44:0] matrix4_row4 = {matrix4_4_1,matrix4_4_2,matrix4_4_3,matrix4_4_4,matrix4_4_5};
wire [44:0] matrix4_row5 = {matrix4_5_1,matrix4_5_2,matrix4_5_3,matrix4_5_4,matrix4_5_5};

wire [44:0] matrix5_row1 = {matrix5_1_1,matrix5_1_2,matrix5_1_3,matrix5_1_4,matrix5_1_5};
wire [44:0] matrix5_row2 = {matrix5_2_1,matrix5_2_2,matrix5_2_3,matrix5_2_4,matrix5_2_5};
wire [44:0] matrix5_row3 = {matrix5_3_1,matrix5_3_2,matrix5_3_3,matrix5_3_4,matrix5_3_5};
wire [44:0] matrix5_row4 = {matrix5_4_1,matrix5_4_2,matrix5_4_3,matrix5_4_4,matrix5_4_5};
wire [44:0] matrix5_row5 = {matrix5_5_1,matrix5_5_2,matrix5_5_3,matrix5_5_4,matrix5_5_5};

wire [44:0] matrix6_row1 = {matrix6_1_1,matrix6_1_2,matrix6_1_3,matrix6_1_4,matrix6_1_5};
wire [44:0] matrix6_row2 = {matrix6_2_1,matrix6_2_2,matrix6_2_3,matrix6_2_4,matrix6_2_5};
wire [44:0] matrix6_row3 = {matrix6_3_1,matrix6_3_2,matrix6_3_3,matrix6_3_4,matrix6_3_5};
wire [44:0] matrix6_row4 = {matrix6_4_1,matrix6_4_2,matrix6_4_3,matrix6_4_4,matrix6_4_5};
wire [44:0] matrix6_row5 = {matrix6_5_1,matrix6_5_2,matrix6_5_3,matrix6_5_4,matrix6_5_5};



always @ ( posedge cnn_clk ) 
begin
	if(!conv1_done) begin
		{matrix1_1_1,matrix1_1_2,matrix1_1_3,matrix1_1_4,matrix1_1_5} <= {matrix1_1_2,matrix1_1_3,matrix1_1_4,matrix1_1_5,taps_0};
		{matrix1_2_1,matrix1_2_2,matrix1_2_3,matrix1_2_4,matrix1_2_5} <= {matrix1_2_2,matrix1_2_3,matrix1_2_4,matrix1_2_5,taps_1};
		{matrix1_3_1,matrix1_3_2,matrix1_3_3,matrix1_3_4,matrix1_3_5} <= {matrix1_3_2,matrix1_3_3,matrix1_3_4,matrix1_3_5,taps_2};
		{matrix1_4_1,matrix1_4_2,matrix1_4_3,matrix1_4_4,matrix1_4_5} <= {matrix1_4_2,matrix1_4_3,matrix1_4_4,matrix1_4_5,taps_3};
		{matrix1_5_1,matrix1_5_2,matrix1_5_3,matrix1_5_4,matrix1_5_5} <= {matrix1_5_2,matrix1_5_3,matrix1_5_4,matrix1_5_5,taps_4};	
		
		{matrix2_1_1,matrix2_1_2,matrix2_1_3,matrix2_1_4,matrix2_1_5} <= {matrix2_1_2,matrix2_1_3,matrix2_1_4,matrix2_1_5,taps_0};
		{matrix2_2_1,matrix2_2_2,matrix2_2_3,matrix2_2_4,matrix2_2_5} <= {matrix2_2_2,matrix2_2_3,matrix2_2_4,matrix2_2_5,taps_1};
		{matrix2_3_1,matrix2_3_2,matrix2_3_3,matrix2_3_4,matrix2_3_5} <= {matrix2_3_2,matrix2_3_3,matrix2_3_4,matrix2_3_5,taps_2};
		{matrix2_4_1,matrix2_4_2,matrix2_4_3,matrix2_4_4,matrix2_4_5} <= {matrix2_4_2,matrix2_4_3,matrix2_4_4,matrix2_4_5,taps_3};
		{matrix2_5_1,matrix2_5_2,matrix2_5_3,matrix2_5_4,matrix2_5_5} <= {matrix2_5_2,matrix2_5_3,matrix2_5_4,matrix2_5_5,taps_4};	
		
		{matrix3_1_1,matrix3_1_2,matrix3_1_3,matrix3_1_4,matrix3_1_5} <= {matrix3_1_2,matrix3_1_3,matrix3_1_4,matrix3_1_5,taps_0};
		{matrix3_2_1,matrix3_2_2,matrix3_2_3,matrix3_2_4,matrix3_2_5} <= {matrix3_2_2,matrix3_2_3,matrix3_2_4,matrix3_2_5,taps_1};
		{matrix3_3_1,matrix3_3_2,matrix3_3_3,matrix3_3_4,matrix3_3_5} <= {matrix3_3_2,matrix3_3_3,matrix3_3_4,matrix3_3_5,taps_2};
		{matrix3_4_1,matrix3_4_2,matrix3_4_3,matrix3_4_4,matrix3_4_5} <= {matrix3_4_2,matrix3_4_3,matrix3_4_4,matrix3_4_5,taps_3};
		{matrix3_5_1,matrix3_5_2,matrix3_5_3,matrix3_5_4,matrix3_5_5} <= {matrix3_5_2,matrix3_5_3,matrix3_5_4,matrix3_5_5,taps_4};	
		
		{matrix4_1_1,matrix4_1_2,matrix4_1_3,matrix4_1_4,matrix4_1_5} <= {matrix4_1_2,matrix4_1_3,matrix4_1_4,matrix4_1_5,taps_0};
		{matrix4_2_1,matrix4_2_2,matrix4_2_3,matrix4_2_4,matrix4_2_5} <= {matrix4_2_2,matrix4_2_3,matrix4_2_4,matrix4_2_5,taps_1};
		{matrix4_3_1,matrix4_3_2,matrix4_3_3,matrix4_3_4,matrix4_3_5} <= {matrix4_3_2,matrix4_3_3,matrix4_3_4,matrix4_3_5,taps_2};
		{matrix4_4_1,matrix4_4_2,matrix4_4_3,matrix4_4_4,matrix4_4_5} <= {matrix4_4_2,matrix4_4_3,matrix4_4_4,matrix4_4_5,taps_3};
		{matrix4_5_1,matrix4_5_2,matrix4_5_3,matrix4_5_4,matrix4_5_5} <= {matrix4_5_2,matrix4_5_3,matrix4_5_4,matrix4_5_5,taps_4};		
		
		{matrix5_1_1,matrix5_1_2,matrix5_1_3,matrix5_1_4,matrix5_1_5} <= {matrix5_1_2,matrix5_1_3,matrix5_1_4,matrix5_1_5,taps_0};
		{matrix5_2_1,matrix5_2_2,matrix5_2_3,matrix5_2_4,matrix5_2_5} <= {matrix5_2_2,matrix5_2_3,matrix5_2_4,matrix5_2_5,taps_1};
		{matrix5_3_1,matrix5_3_2,matrix5_3_3,matrix5_3_4,matrix5_3_5} <= {matrix5_3_2,matrix5_3_3,matrix5_3_4,matrix5_3_5,taps_2};
		{matrix5_4_1,matrix5_4_2,matrix5_4_3,matrix5_4_4,matrix5_4_5} <= {matrix5_4_2,matrix5_4_3,matrix5_4_4,matrix5_4_5,taps_3};
		{matrix5_5_1,matrix5_5_2,matrix5_5_3,matrix5_5_4,matrix5_5_5} <= {matrix5_5_2,matrix5_5_3,matrix5_5_4,matrix5_5_5,taps_4};	
		
		{matrix6_1_1,matrix6_1_2,matrix6_1_3,matrix6_1_4,matrix6_1_5} <= {matrix6_1_2,matrix6_1_3,matrix6_1_4,matrix6_1_5,taps_0};
		{matrix6_2_1,matrix6_2_2,matrix6_2_3,matrix6_2_4,matrix6_2_5} <= {matrix6_2_2,matrix6_2_3,matrix6_2_4,matrix6_2_5,taps_1};
		{matrix6_3_1,matrix6_3_2,matrix6_3_3,matrix6_3_4,matrix6_3_5} <= {matrix6_3_2,matrix6_3_3,matrix6_3_4,matrix6_3_5,taps_2};
		{matrix6_4_1,matrix6_4_2,matrix6_4_3,matrix6_4_4,matrix6_4_5} <= {matrix6_4_2,matrix6_4_3,matrix6_4_4,matrix6_4_5,taps_3};
		{matrix6_5_1,matrix6_5_2,matrix6_5_3,matrix6_5_4,matrix6_5_5} <= {matrix6_5_2,matrix6_5_3,matrix6_5_4,matrix6_5_5,taps_4};				
	end
	else begin
		{matrix1_1_1,matrix1_1_2,matrix1_1_3,matrix1_1_4,matrix1_1_5} <= {matrix1_1_2,matrix1_1_3,matrix1_1_4,matrix1_1_5,taps1_5};
		{matrix1_2_1,matrix1_2_2,matrix1_2_3,matrix1_2_4,matrix1_2_5} <= {matrix1_2_2,matrix1_2_3,matrix1_2_4,matrix1_2_5,taps1_6};
		{matrix1_3_1,matrix1_3_2,matrix1_3_3,matrix1_3_4,matrix1_3_5} <= {matrix1_3_2,matrix1_3_3,matrix1_3_4,matrix1_3_5,taps1_7};
		{matrix1_4_1,matrix1_4_2,matrix1_4_3,matrix1_4_4,matrix1_4_5} <= {matrix1_4_2,matrix1_4_3,matrix1_4_4,matrix1_4_5,taps1_8};
		{matrix1_5_1,matrix1_5_2,matrix1_5_3,matrix1_5_4,matrix1_5_5} <= {matrix1_5_2,matrix1_5_3,matrix1_5_4,matrix1_5_5,taps1_9};

		{matrix2_1_1,matrix2_1_2,matrix2_1_3,matrix2_1_4,matrix2_1_5} <= {matrix2_1_2,matrix2_1_3,matrix2_1_4,matrix2_1_5,taps2_5};
		{matrix2_2_1,matrix2_2_2,matrix2_2_3,matrix2_2_4,matrix2_2_5} <= {matrix2_2_2,matrix2_2_3,matrix2_2_4,matrix2_2_5,taps2_6};
		{matrix2_3_1,matrix2_3_2,matrix2_3_3,matrix2_3_4,matrix2_3_5} <= {matrix2_3_2,matrix2_3_3,matrix2_3_4,matrix2_3_5,taps2_7};
		{matrix2_4_1,matrix2_4_2,matrix2_4_3,matrix2_4_4,matrix2_4_5} <= {matrix2_4_2,matrix2_4_3,matrix2_4_4,matrix2_4_5,taps2_8};
		{matrix2_5_1,matrix2_5_2,matrix2_5_3,matrix2_5_4,matrix2_5_5} <= {matrix2_5_2,matrix2_5_3,matrix2_5_4,matrix2_5_5,taps2_9};		
		
		{matrix3_1_1,matrix3_1_2,matrix3_1_3,matrix3_1_4,matrix3_1_5} <= {matrix3_1_2,matrix3_1_3,matrix3_1_4,matrix3_1_5,taps3_5};
		{matrix3_2_1,matrix3_2_2,matrix3_2_3,matrix3_2_4,matrix3_2_5} <= {matrix3_2_2,matrix3_2_3,matrix3_2_4,matrix3_2_5,taps3_6};
		{matrix3_3_1,matrix3_3_2,matrix3_3_3,matrix3_3_4,matrix3_3_5} <= {matrix3_3_2,matrix3_3_3,matrix3_3_4,matrix3_3_5,taps3_7};
		{matrix3_4_1,matrix3_4_2,matrix3_4_3,matrix3_4_4,matrix3_4_5} <= {matrix3_4_2,matrix3_4_3,matrix3_4_4,matrix3_4_5,taps3_8};
		{matrix3_5_1,matrix3_5_2,matrix3_5_3,matrix3_5_4,matrix3_5_5} <= {matrix3_5_2,matrix3_5_3,matrix3_5_4,matrix3_5_5,taps3_9};	
		
		{matrix4_1_1,matrix4_1_2,matrix4_1_3,matrix4_1_4,matrix4_1_5} <= {matrix4_1_2,matrix4_1_3,matrix4_1_4,matrix4_1_5,taps4_5};
		{matrix4_2_1,matrix4_2_2,matrix4_2_3,matrix4_2_4,matrix4_2_5} <= {matrix4_2_2,matrix4_2_3,matrix4_2_4,matrix4_2_5,taps4_6};
		{matrix4_3_1,matrix4_3_2,matrix4_3_3,matrix4_3_4,matrix4_3_5} <= {matrix4_3_2,matrix4_3_3,matrix4_3_4,matrix4_3_5,taps4_7};
		{matrix4_4_1,matrix4_4_2,matrix4_4_3,matrix4_4_4,matrix4_4_5} <= {matrix4_4_2,matrix4_4_3,matrix4_4_4,matrix4_4_5,taps4_8};
		{matrix4_5_1,matrix4_5_2,matrix4_5_3,matrix4_5_4,matrix4_5_5} <= {matrix4_5_2,matrix4_5_3,matrix4_5_4,matrix4_5_5,taps4_9};		
		
		{matrix5_1_1,matrix5_1_2,matrix5_1_3,matrix5_1_4,matrix5_1_5} <= {matrix5_1_2,matrix5_1_3,matrix5_1_4,matrix5_1_5,taps5_5};
		{matrix5_2_1,matrix5_2_2,matrix5_2_3,matrix5_2_4,matrix5_2_5} <= {matrix5_2_2,matrix5_2_3,matrix5_2_4,matrix5_2_5,taps5_6};
		{matrix5_3_1,matrix5_3_2,matrix5_3_3,matrix5_3_4,matrix5_3_5} <= {matrix5_3_2,matrix5_3_3,matrix5_3_4,matrix5_3_5,taps5_7};
		{matrix5_4_1,matrix5_4_2,matrix5_4_3,matrix5_4_4,matrix5_4_5} <= {matrix5_4_2,matrix5_4_3,matrix5_4_4,matrix5_4_5,taps5_8};
		{matrix5_5_1,matrix5_5_2,matrix5_5_3,matrix5_5_4,matrix5_5_5} <= {matrix5_5_2,matrix5_5_3,matrix5_5_4,matrix5_5_5,taps5_9};	
		
		{matrix6_1_1,matrix6_1_2,matrix6_1_3,matrix6_1_4,matrix6_1_5} <= {matrix6_1_2,matrix6_1_3,matrix6_1_4,matrix6_1_5,taps6_5};
		{matrix6_2_1,matrix6_2_2,matrix6_2_3,matrix6_2_4,matrix6_2_5} <= {matrix6_2_2,matrix6_2_3,matrix6_2_4,matrix6_2_5,taps6_6};
		{matrix6_3_1,matrix6_3_2,matrix6_3_3,matrix6_3_4,matrix6_3_5} <= {matrix6_3_2,matrix6_3_3,matrix6_3_4,matrix6_3_5,taps6_7};
		{matrix6_4_1,matrix6_4_2,matrix6_4_3,matrix6_4_4,matrix6_4_5} <= {matrix6_4_2,matrix6_4_3,matrix6_4_4,matrix6_4_5,taps6_8};
		{matrix6_5_1,matrix6_5_2,matrix6_5_3,matrix6_5_4,matrix6_5_5} <= {matrix6_5_2,matrix6_5_3,matrix6_5_4,matrix6_5_5,taps6_9};				
	end
end




//****************************************** 卷积层1,2共用卷积操作 ***************************************************//



reg [5:0] feature_map_counter=6'd0;   //卷积层计数 0-2是conv layer1 3-38是conv layer2




wire [11:0] norm_result1;
wire [11:0] norm_result2;
wire [11:0] norm_result3;
wire [11:0] norm_result4;
wire [11:0] norm_result5;
wire [11:0] norm_result6;
wire [8:0] weight_0,weight_1,weight_23,weight_24;

//wire [8:0] bias_reg1;
Conv2d feature_map_inst1(
	.cnn_clk             (cnn_clk),
	
	.matrix_row1         (matrix1_row1),
	.matrix_row2         (matrix1_row2),
	.matrix_row3         (matrix1_row3),
	.matrix_row4         (matrix1_row4),
	.matrix_row5         (matrix1_row5),
	
	.weight_en           (weight_en),
	.weight              (weight_switch1),
	.bias                (bias_switch1),
	
	.norm_result         (norm_result1)
  //  .weight_0            (weight_0),
   // .weight_1            (weight_1),
   // .weight_23            (weight_23),
   // .weight_24            (weight_24)
   
);

wire buffer_en1;
wire [11:0] max1_1, max1_2,max1_3,max1_4,max1_5,max1_6;
wire [11:0] pool_input1,pool_input2,pool_input3,pool_input4;
maxpooling subsampling1_inst1(
	.cnn_clk             (cnn_clk),
	
	.wr_en               (wr_en),
	.norm_result         (norm_result1),
	.matrix1_1         (pool_input1),
	.matrix1_2         (pool_input2),
	.matrix2_1         (pool_input3),
	.matrix2_2         (pool_input4),
	.buffer_en           (buffer_en1),
	.max                 (max1_1)


);



Conv2d feature_map_inst2(
	.cnn_clk             (cnn_clk),
	
	.matrix_row1         (matrix2_row1),
	.matrix_row2         (matrix2_row2),
	.matrix_row3         (matrix2_row3),
	.matrix_row4         (matrix2_row4),
	.matrix_row5         (matrix2_row5),
	
	.weight_en           (weight_en),
	.weight              (weight_switch2),
	.bias                (bias_switch2),
	
	.norm_result         (norm_result2)


);


maxpooling subsampling1_inst2(
	.cnn_clk             (cnn_clk),
	
	.wr_en               (wr_en),
	.norm_result         (norm_result2),
	
	.max                 (max1_2)

);
Conv2d feature_map_inst3(
	.cnn_clk             (cnn_clk),
	
	.matrix_row1         (matrix3_row1),
	.matrix_row2         (matrix3_row2),
	.matrix_row3         (matrix3_row3),
	.matrix_row4         (matrix3_row4),
	.matrix_row5         (matrix3_row5),
	
	.weight_en           (weight_en),
	.weight              (weight_switch3),
	.bias                (bias_switch3),
	
	.norm_result         (norm_result3)
  
   
);
maxpooling subsampling1_inst3(
	.cnn_clk             (cnn_clk),
	
	.wr_en               (wr_en),
	.norm_result         (norm_result3),
	.max                 (max1_3)


);
Conv2d feature_map_inst4(
	.cnn_clk             (cnn_clk),
	
	.matrix_row1         (matrix4_row1),
	.matrix_row2         (matrix4_row2),
	.matrix_row3         (matrix4_row3),
	.matrix_row4         (matrix4_row4),
	.matrix_row5         (matrix4_row5),
	
	.weight_en           (weight_en),
	.weight              (weight_switch4),
	.bias                (bias_switch4),
	
	.norm_result         (norm_result4)

   
);
maxpooling subsampling1_inst4(
	.cnn_clk             (cnn_clk),
	
	.wr_en               (wr_en),
	.norm_result         (norm_result4),
	.max                 (max1_4)


);
Conv2d feature_map_inst5(
	.cnn_clk             (cnn_clk),
	
	.matrix_row1         (matrix5_row1),
	.matrix_row2         (matrix5_row2),
	.matrix_row3         (matrix5_row3),
	.matrix_row4         (matrix5_row4),
	.matrix_row5         (matrix5_row5),
	
	.weight_en           (weight_en),
	.weight              (weight_switch5),
	.bias                (bias_switch5),
	
	.norm_result         (norm_result5)
   
);
maxpooling subsampling1_inst5(
	.cnn_clk             (cnn_clk),
	
	.wr_en               (wr_en),
	.norm_result         (norm_result5),
	.max                 (max1_5)


);
Conv2d feature_map_inst6(
	.cnn_clk             (cnn_clk),
	
	.matrix_row1         (matrix6_row1),
	.matrix_row2         (matrix6_row2),
	.matrix_row3         (matrix6_row3),
	.matrix_row4         (matrix6_row4),
	.matrix_row5         (matrix6_row5),
	
	.weight_en           (weight_en),
	.weight              (weight_switch6),
	.bias                (bias_switch6),
	
	.norm_result         (norm_result6)
   
);
maxpooling subsampling1_inst6(
	.cnn_clk             (cnn_clk),
	
	.wr_en               (wr_en),
	.norm_result         (norm_result6),
	.max                 (max1_6)


);

wire [8:0] relu_result1_1,relu_result1_2,relu_result1_3,relu_result1_4,relu_result1_5,relu_result1_6;

assign relu_result1_1 = max1_1[11] ? 9'd0 : max1_1[9:1];
assign relu_result1_2 = max1_2[11] ? 9'd0 : max1_2[9:1];
assign relu_result1_3 = max1_3[11] ? 9'd0 : max1_3[9:1];
assign relu_result1_4 = max1_4[11] ? 9'd0 : max1_4[9:1];
assign relu_result1_5 = max1_5[11] ? 9'd0 : max1_5[9:1];
assign relu_result1_6 = max1_6[11] ? 9'd0 : max1_6[9:1];


reg [7:0] buffer_addr1=8'd0;   //0-99
reg conv1_done = 1'b0;          //卷积层1结束

always @ ( posedge cnn_clk )
begin
	if(buffer_en1 && !conv1_done) begin
		buffer_addr1 <= buffer_addr1+1'b1;
		
			buffer1_12x12[buffer_addr1] <= relu_result1_1;
			buffer2_12x12[buffer_addr1] <= relu_result1_2;

			buffer3_12x12[buffer_addr1] <= relu_result1_3;
			buffer4_12x12[buffer_addr1] <= relu_result1_4;
		
			buffer5_12x12[buffer_addr1] <= relu_result1_5;
			buffer6_12x12[buffer_addr1] <= relu_result1_6;
		end
		if(buffer_addr1 == 8'd144) begin
			buffer_addr1 <= 8'd0;
		    conv1_done <= 1'b1;
			
		
	end
end






//always @ ( posedge cnn_clk )
//begin
//	if(conv1_done) begin
//		result1 <= buffer1_10x10[54];    //maxpooling1测试 第6行第5个
//		result2 <= buffer2_10x10[54];
//		result3 <= buffer3_10x10[54];
//		result4 <= buffer4_10x10[54];
//		result5 <= buffer5_10x10[54];
//		result6 <= buffer6_10x10[54];
//	end
//end



reg [8:0] buffer1_12x12 [143:0];    //conv1 layer feature_map 1
reg [8:0] buffer2_12x12 [143:0];    //conv1 layer feature_map 2
reg [8:0] buffer3_12x12 [143:0];    //conv1 layer feature_map 3
reg [8:0] buffer4_12x12 [143:0];    //conv1 layer feature_map 4
reg [8:0] buffer5_12x12 [143:0];    //conv1 layer feature_map 5
reg [8:0] buffer6_12x12 [143:0];    //conv1 layer feature_map 6



wire [11:0] max2;
reg conv2_done = 1'b0;          //卷积层2结束
wire buffer_en2;
reg [5:0] counter=6'd0;
wire relu_en;
wire [2:0] adder_counter;
wire [6:0] addr;
maxpooling2 subsampling2_inst(
	.cnn_clk             (cnn_clk),
	
	.wr_en               (wr_en),
	.conv1_done          (conv1_done),
	.norm_result1        (norm_result1),
	.norm_result2        (norm_result2),
	.norm_result3        (norm_result3),
	.norm_result4        (norm_result4),
	.norm_result5        (norm_result5),
	.norm_result6        (norm_result6),

	.feature_map_counter (counter),
	.buffer_en           (buffer_en2),
	.max                 (max2)
	//.relu_en             (relu_en),
	//.adder_counter       (adder_counter),
	//.addra                (addr)

);


wire [8:0] relu_result2;

assign relu_result2 = max2[11] ? 12'd0 : max2;



reg [5:0] buffer_addr2=6'd0;   //0-8


always @ ( posedge cnn_clk )
begin
	if(buffer_en2) begin
		buffer_addr2 <= buffer_addr2+1'b1;		
		if(buffer_addr2 == 6'd15) begin
			if(counter == 6'd15) begin
				conv2_done <= 1'b1;
			end
			buffer_addr2 <= 4'd0;
			counter <= counter+1'b1;
		end
	end
end

always @ ( posedge cnn_clk )
begin
	if(buffer_en2) begin
		if(counter == 4'd0) begin
			buffer1_4x4[buffer_addr2] <= relu_result2;
		end
		else if(counter == 4'd1) begin
			buffer2_4x4[buffer_addr2] <= relu_result2;
		end
		else if(counter == 4'd2) begin
			buffer3_4x4[buffer_addr2] <= relu_result2;
		end
		else if(counter == 4'd3) begin
			buffer4_4x4[buffer_addr2] <= relu_result2;
		end
		else if(counter == 4'd4) begin
			buffer5_4x4[buffer_addr2] <= relu_result2;
		end
		else if(counter == 4'd5) begin
			buffer6_4x4[buffer_addr2] <= relu_result2;
		end
		else if(counter == 4'd6) begin
			buffer7_4x4[buffer_addr2] <= relu_result2;
		end
		else if(counter == 4'd7) begin
			buffer8_4x4[buffer_addr2] <= relu_result2;
		end
		else if(counter == 4'd8) begin
			buffer9_4x4[buffer_addr2] <= relu_result2;
		end
		else if(counter == 4'd9) begin
			buffer10_4x4[buffer_addr2] <= relu_result2;
		end
		else if(counter == 4'd10) begin
			buffer11_4x4[buffer_addr2] <= relu_result2;
		end
		else if(counter == 4'd11) begin
			buffer12_4x4[buffer_addr2] <= relu_result2;
		end
		else if(counter == 4'd12) begin
			buffer13_4x4[buffer_addr2] <= relu_result2;
			end
		else if(counter == 4'd13) begin
			buffer14_4x4[buffer_addr2] <= relu_result2;
			end
		else if(counter == 4'd14) begin
			buffer15_4x4[buffer_addr2] <= relu_result2;
			end
		else if(counter == 4'd15) begin
			buffer16_4x4[buffer_addr2] <= relu_result2;
			
		  end
	end
end



//always @ ( posedge cnn_clk )
//begin
//	if(conv2_done) begin
//		result1 <= buffer1_3x3[8];			//maxpooling2测试 第1行第1个
//		result2 <= buffer2_3x3[8];
//		result3 <= buffer3_3x3[8];
//		result4 <= buffer4_3x3[8];
//		result5 <= buffer5_3x3[8];
//		result6 <= buffer6_3x3[8];
//		result7 <= buffer7_3x3[8];    
//		result8 <= buffer8_3x3[8];
//		result9 <= buffer9_3x3[8];
//		result10 <= buffer10_3x3[8];
//		result11 <= buffer11_3x3[8];
//		result12 <= buffer12_3x3[8];
//	end
//end


reg [11:0] buffer1_4x4 [15:0];     //conv2 layer feature_map 1
reg [11:0] buffer2_4x4 [15:0];     //conv2 layer feature_map 2
reg [11:0] buffer3_4x4 [15:0];     //conv2 layer feature_map 3
reg [11:0] buffer4_4x4 [15:0];     //conv2 layer feature_map 4
reg [11:0] buffer5_4x4 [15:0];     //conv2 layer feature_map 5
reg [11:0] buffer6_4x4 [15:0];     //conv2 layer feature_map 6
reg [11:0] buffer7_4x4 [15:0];     //conv2 layer feature_map 7
reg [11:0] buffer8_4x4 [15:0];     //conv2 layer feature_map 8
reg [11:0] buffer9_4x4 [15:0];     //conv2 layer feature_map 9
reg [11:0] buffer10_4x4 [15:0];    //conv2 layer feature_map 10
reg [11:0] buffer11_4x4 [15:0];    //conv2 layer feature_map 11
reg [11:0] buffer12_4x4 [15:0];    //conv2 layer feature_map 12
reg [11:0] buffer13_4x4 [15:0];     //conv2 layer feature_map 13
reg [11:0] buffer14_4x4 [15:0];     //conv2 layer feature_map 14
reg [11:0] buffer15_4x4 [15:0];     //conv2 layer feature_map 15
reg [11:0] buffer16_4x4 [15:0];     //conv2 layer feature_map 16





//******************************************** 全连接层计算 ***************************************************//

reg [11:0] buffer_fl [255:0];      //fc layer
reg [8:0] flat_addr=9'd0;
reg flat_done = 1'b0;
reg cnn_done = 1'b0;       //数据拉长结束
reg [3:0] flat_counter1=4'd0;          //0-11
reg [3:0] flat_counter2=4'd0;          //0-8
wire [3:0] flat_counter3 [15:0];    //0-8 查表法

assign flat_counter3[0] = 4'd0;
assign flat_counter3[1] = 4'd4;
assign flat_counter3[2] = 4'd8;
assign flat_counter3[3] = 4'd12;
assign flat_counter3[4] = 4'd1;
assign flat_counter3[5] = 4'd5;
assign flat_counter3[6] = 4'd9;
assign flat_counter3[7] = 4'd13;
assign flat_counter3[8] = 4'd2;
assign flat_counter3[9] = 4'd6;
assign flat_counter3[10] = 4'd10;
assign flat_counter3[11] = 4'd14;
assign flat_counter3[12] = 4'd3;
assign flat_counter3[13] = 4'd7;
assign flat_counter3[14] = 4'd11;
assign flat_counter3[15] = 4'd15;


always @ ( posedge cnn_clk )     //数据拉长(flat)
begin
	if(conv2_done) begin
		if(flat_addr < 9'd255) begin 
			flat_addr <= flat_addr+1'b1;
		end
		else begin
			flat_done <= 1'b1;
		end
		if(flat_counter1 < 4'd15) begin 
			flat_counter1 <= flat_counter1+1'b1;
		end
		else begin
			flat_counter1 <= 4'd0;
			if(flat_counter2 < 4'd15) begin
				flat_counter2 <= flat_counter2+1'b1;
			end
		end
	end
end


always @ ( posedge cnn_clk )
begin
	if(flat_counter1 == 4'd0) begin
			buffer_fl[flat_addr] <= buffer1_4x4[flat_counter2];
		end
		else if(flat_counter1 == 4'd1) begin
			buffer_fl[flat_addr] <= buffer2_4x4[flat_counter2];
		end
		else if(flat_counter1 == 4'd2) begin
			buffer_fl[flat_addr] <= buffer3_4x4[flat_counter2];
		end
		else if(flat_counter1 == 4'd3) begin
			buffer_fl[flat_addr] <= buffer4_4x4[flat_counter2];
		end
		else if(flat_counter1 == 4'd4) begin
			buffer_fl[flat_addr] <= buffer5_4x4[flat_counter2];
		end
		else if(flat_counter1 == 4'd5) begin
			buffer_fl[flat_addr] <= buffer6_4x4[flat_counter2];
		end
		else if(flat_counter1 == 4'd6) begin
			buffer_fl[flat_addr] <= buffer7_4x4[flat_counter2];
		end
		else if(flat_counter1 == 4'd7) begin
			buffer_fl[flat_addr] <= buffer8_4x4[flat_counter2];
		end
		else if(flat_counter1 == 4'd8) begin
			buffer_fl[flat_addr] <= buffer9_4x4[flat_counter2];
		end
		else if(flat_counter1 == 4'd9) begin
			buffer_fl[flat_addr] <= buffer10_4x4[flat_counter2];
		end
		else if(flat_counter1 == 4'd10) begin
			buffer_fl[flat_addr] <= buffer11_4x4[flat_counter2];
		end
		else if(flat_counter1 == 4'd11) begin
			buffer_fl[flat_addr] <= buffer12_4x4[flat_counter2];
		end
		else if(flat_counter1 == 4'd12) begin
			buffer_fl[flat_addr] <= buffer13_4x4[flat_counter2];
		end
		else if(flat_counter1 == 4'd13) begin
			buffer_fl[flat_addr] <= buffer14_4x4[flat_counter2];
		end
		else if(flat_counter1 == 4'd14) begin
			buffer_fl[flat_addr] <= buffer15_4x4[flat_counter2];
		end
		else if(flat_counter1 == 4'd15) begin
			buffer_fl[flat_addr] <= buffer16_4x4[flat_counter2];
		end
	
end


//always @ ( posedge cnn_clk )
//begin
	//if(flat_done) begin
		//result1 <= buffer_fl[16];              //flat测试
		///result2 <= buffer_fl[17];
		//result3 <= buffer_fl[18];
		//result4 <= buffer_fl[19];
		//result5 <= buffer_fl[20];
		//result6 <= buffer_fl[21];
		//result7 <= buffer_fl[22];
		//result8 <= buffer_fl[23];
		//result9 <= buffer_fl[24];
		//result10 <= buffer_fl[25];
		//result11 <= buffer_fl[234];
		//result12 <= buffer_fl[235];
		//result13 <= buffer_fl[236];
		//result14 <= buffer_fl[237];
		//result15 <= buffer_fl[238];
		//result16 <= buffer_fl[239];
	//end
//end

//****************************************************fc1****************************************************************************//

 
wire [15:0] bias_10 [9:0];
wire [22:0] bias_10_1[9:0];
assign bias_10[0] = 16'h01c4;
assign bias_10[1] = 16'h02d0;
assign bias_10[2] = 16'h8229;
assign bias_10[3] = 16'h83d7;
assign bias_10[4] = 16'h80d4;
assign bias_10[5] = 16'h0166;
assign bias_10[6] = 16'h0137;
assign bias_10[7] = 16'h81f5;
assign bias_10[8] = 16'h029a;
assign bias_10[9] = 16'h8020;

assign bias_10_1[0] = bias_10[0][15]?{8'hff,~bias_10[0][14:0]}+1'b1:bias_10[0];
assign bias_10_1[1] = bias_10[1][15]?{8'hff,~bias_10[1][14:0]}+1'b1:bias_10[1];
assign bias_10_1[2] = bias_10[2][15]?{8'hff,~bias_10[2][14:0]}+1'b1:bias_10[2];
assign bias_10_1[3] = bias_10[3][15]?{8'hff,~bias_10[3][14:0]}+1'b1:bias_10[3];
assign bias_10_1[4] = bias_10[4][15]?{8'hff,~bias_10[4][14:0]}+1'b1:bias_10[4];
assign bias_10_1[5] = bias_10[5][15]?{8'hff,~bias_10[5][14:0]}+1'b1:bias_10[5];
assign bias_10_1[6] = bias_10[6][15]?{8'hff,~bias_10[6][14:0]}+1'b1:bias_10[6];
assign bias_10_1[7] = bias_10[7][15]?{8'hff,~bias_10[7][14:0]}+1'b1:bias_10[7];
assign bias_10_1[8] = bias_10[8][15]?{8'hff,~bias_10[8][14:0]}+1'b1:bias_10[8];
assign bias_10_1[9] = bias_10[9][15]?{8'hff,~bias_10[9][14:0]}+1'b1:bias_10[9];

reg [12:0] weight_fc_addr=13'd0;
reg [8:0] fc_addr=9'd0;
wire [15:0] weight_fc;
reg [22:0] result1_reg = 23'd0;
reg [22:0] result2_reg = 23'd0;
reg [22:0] result3_reg = 23'd0;
reg [22:0] result4_reg = 23'd0;
reg [22:0] result5_reg = 23'd0;
reg [22:0] result6_reg = 23'd0;
reg [22:0] result7_reg = 23'd0;
reg [22:0] result8_reg = 23'd0;
reg [22:0] result9_reg = 23'd0;
reg [22:0] result10_reg = 23'd0;
weight_fc  weight_inst(.clka (cnn_clk), .addra (weight_fc_addr), .douta (weight_fc)); 




reg [11:0] dina_fc;
wire [22:0] dout_fc;
multiplier mul_inst(.cnn_clk (cnn_clk), .dina (dina_fc), .dinb (weight_fc[15:4]), .dout (dout_fc));

//reg [11:0] result_10;



wire [22:0] dout_amend2;

assign dout_amend2 = {{3{dout_fc[22]}},dout_fc[22:3]};

always @ ( posedge cnn_clk )
begin
	if(flat_done) begin
		if(weight_fc_addr < 11'd3) begin                      //别忘了延迟2个周期
			weight_fc_addr <= weight_fc_addr+1'b1;
		end
		else if(weight_fc_addr >= 11'd3 && weight_fc_addr < 11'd259) begin
			weight_fc_addr <= weight_fc_addr+1'b1;
			result1_reg <= result1_reg+dout_amend2;
		end
		else if(weight_fc_addr >= 11'd259 && weight_fc_addr < 11'd515) begin
			weight_fc_addr <= weight_fc_addr+1'b1;		
			result2_reg <= result2_reg+dout_amend2;
		end
		else if(weight_fc_addr >= 11'd515 && weight_fc_addr < 11'd771) begin
			weight_fc_addr <= weight_fc_addr+1'b1;
			result3_reg <= result3_reg+dout_amend2;
		end
		else if(weight_fc_addr >= 11'd771 && weight_fc_addr < 11'd1027) begin
			weight_fc_addr <= weight_fc_addr+1'b1;
			result4_reg <= result4_reg+dout_amend2;
		end
		else if(weight_fc_addr >= 11'd1027 && weight_fc_addr < 11'd1283) begin
			weight_fc_addr <= weight_fc_addr+1'b1;
			result5_reg <= result5_reg+dout_amend2;
		end
		else if(weight_fc_addr >= 11'd1283 && weight_fc_addr < 11'd1539) begin
			weight_fc_addr <= weight_fc_addr+1'b1;
			result6_reg <= result6_reg+dout_amend2;
		end
		else if(weight_fc_addr >= 11'd1539 && weight_fc_addr < 11'd1795) begin
			weight_fc_addr <= weight_fc_addr+1'b1;
			result7_reg <= result7_reg+dout_amend2;
		end
		else if(weight_fc_addr >= 11'd1795 && weight_fc_addr < 12'd2051) begin
			weight_fc_addr <= weight_fc_addr+1'b1;
			result8_reg <= result8_reg+dout_amend2;
		end
		else if(weight_fc_addr >= 12'd2051 && weight_fc_addr < 12'd2307) begin
			weight_fc_addr <= weight_fc_addr+1'b1;
			result9_reg <= result9_reg+dout_amend2;
		end
		else if(weight_fc_addr >= 12'd2307 && weight_fc_addr < 12'd2563) begin
			weight_fc_addr <= weight_fc_addr+1'b1;
			result10_reg <= result10_reg+dout_amend2;
		end
		else begin
			cnn_done <= 1'b1;
			result1 <= result1_reg+bias_10_1[0];
			result2 <= result2_reg+bias_10_1[1];
			result3 <= result3_reg+bias_10_1[2];
			result4 <= result4_reg+bias_10_1[3];
			result5 <= result5_reg+bias_10_1[4];
			result6 <= result6_reg+bias_10_1[5];
			result7 <= result7_reg+bias_10_1[6];
			result8 <= result8_reg+bias_10_1[7];
			result9 <= result9_reg+bias_10_1[8];
			result10 <= result10_reg+bias_10_1[9];
		end
	end
end

reg [19:0] result1,result2,result3,result4,result5,result6,result7,result8,result9,result10;
reg [19:0] max1,max3,max4,max5,max6,max7,max8,max9,max10;

always@(posedge cnn_clk)begin
if(result1[19] && result2[19]) begin
		max1 <= (result1 > result2) ? result2 : result1;
	end
	else if(!result1[19] && result2[19]) begin
		max1 <= result1;
	end
	else if(result1[19] && !result2[19]) begin
		max1 <= result2;
	end
	else if(!result1[19] && !result2[19]) begin
		max1 <= (result1 > result2) ? result1 : result2;
	end
end
always@(posedge cnn_clk)begin
if(result3[19] && result4[19]) begin
		max3 <= (result3 > result4) ? result4 : result3;
	end
	else if(!result3[19] && result4[19]) begin
		max3 <= result3;
	end
	else if(result3[19] && !result4[19]) begin
		max3 <= result4;
	end
	else if(!result3[19] && !result4[19]) begin
		max3 <= (result3 > result4) ? result3 : result4;
	end
end
always@(posedge cnn_clk)begin
if(result5[19] && result6[19]) begin
		max4 <= (result5 > result6) ? result6 : result5;
	end
	else if(!result5[19] && result6[19]) begin
		max4 <= result5;
	end
	else if(result5[19] && !result6[19]) begin
		max4 <= result6;
	end
	else if(!result5[19] && !result6[19]) begin
		max4 <= (result5 > result6) ? result5 : result6;
	end
end
always@(posedge cnn_clk)begin
if(result7[19] && result8[19]) begin
		max5 <= (result7 > result8) ? result8 : result7;
	end
	else if(!result7[19] && result8[19]) begin
		max5 <= result7;
	end
	else if(result7[19] && !result8[19]) begin
		max5 <= result8;
	end
	else if(!result7[19] && !result8[19]) begin
		max5 <= (result7 > result8) ? result7 : result8;
	end
end
always@(posedge cnn_clk)begin
if(result9[19] && result10[19]) begin
		max6 <= (result9 > result10) ? result10 : result9;
	end
	else if(!result9[19] && result10[19]) begin
		max6 <= result9;
	end
	else if(result9[19] && !result10[19]) begin
		max6 <= result10;
	end
	else if(!result9[19] && !result10[19]) begin
		max6 <= (result9 > result10) ? result9 : result10;
	end
end
always @ ( posedge cnn_clk )
begin
	if(max1[19] && max3[19]) begin
		max7 <= (max1 > max3) ? max3 : max1;
	end
	else if(!max1[19] && max3[19]) begin
		max7 <= max1;
	end
	else if(max1[19] && !max3[19]) begin
		max7 <= max3;
	end
	else if(!max1[19] && !max3[19]) begin
		max7 <= (max1 > max3) ? max1 : max3;
	end
end
always @ ( posedge cnn_clk )
begin
	if(max4[19] && max5[19]) begin
		max8 <= (max4 > max5) ? max5 : max4;
	end
	else if(!max4[19] && max5[19]) begin
		max8 <= max4;
	end
	else if(max4[19] && !max5[19]) begin
		max8 <= max5;
	end
	else if(!max4[19] && !max5[19]) begin
		max8 <= (max4 > max5) ? max4 : max5;
	end
end
always @ ( posedge cnn_clk )
begin
	if(max6[19] && max7[19]) begin
		max9 <= (max6 > max7) ? max7 : max6;
	end
	else if(!max6[19] && max7[19]) begin
		max9 <= max6;
	end
	else if(max6[19] && !max7[19]) begin
		max9 <= max7;
	end
	else if(!max6[19] && !max7[19]) begin
		max9 <= (max6 > max7) ? max6 : max7;
	end
end

always @ ( posedge cnn_clk )
begin
	if(max8[19] && max9[19]) begin
		max10 <= (max8 > max9) ? max9 : max8;
	end
	else if(!max8[19] && max9[19]) begin
		max10 <= max8;
	end
	else if(max8[19] && !max9[19]) begin
		max10 <= max9;
	end
	else if(!max8[19] && !max9[19]) begin
		max10 <= (max8 > max9) ? max8 : max9;
	end
end
wire [3:0] out1;
result results(
    .cnn_clk        (cnn_clk),
    .result1        (result1),
    .result2        (result2),
    .result3        (result3),
    .result4        (result4),
    .result5        (result5),
    .result6        (result6),
    .result7        (result7),
    .result8        (result8),
    .result9        (result9),
    .result10       (result10),
    .max10          (max10),
    .output1        (out1)
    
    );
  always@(posedge cnn_clk) begin
  dout<= out1;
  end
reg flat_done1;
always @ ( posedge cnn_clk )
begin
	flat_done1<=flat_done;
		end
always @ ( posedge cnn_clk )
begin
	if(flat_done1) begin
		if(fc_addr < 9'd255) begin
			fc_addr <= fc_addr+1'b1;
		end
		else begin
			fc_addr <= 9'd0;
		end	
		dina_fc <= buffer_fl[fc_addr];
	end
end

endmodule


