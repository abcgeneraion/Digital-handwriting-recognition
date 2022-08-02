`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/19 21:53:39
// Design Name: 
// Module Name: conv
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/07 21:19:46
// Design Name: 
// Module Name: Conv2d
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


module Conv2d(
			input cnn_clk,
			
			input [44:0] matrix_row1,
			input [44:0] matrix_row2,
			input [44:0] matrix_row3,
			input [44:0] matrix_row4,
			input [44:0] matrix_row5,
			
			input weight_en,
			input [15:0] weight,
			input [15:0] bias,
			
			//output  reg [8:0] bias_reg,
			output reg [11:0] norm_result
			//output [8:0]weight_0,
			//output [8:0]weight_1,
			//output [8:0]weight_23,
			//output [8:0]weight_24
			
    );


reg [8:0] weight_reg[24:0];    
reg [18:0] bias_reg;

reg [6:0] addr;
//assign weight_0 = weight_reg[0];
//assign weight_1 = weight_reg[1];
//assign weight_23 = weight_reg[23];
//assign weight_24 = weight_reg[24];

always @ ( posedge cnn_clk )           //参数缓存
begin
	if(weight_en) begin
		addr <= addr+1'b1;
		weight_reg[addr-1] <= weight[15:7];
		bias_reg <= bias[15]?{11'b11111111111,~bias[14:7]}+1'b1 : bias[15:7];
		
	end
	else begin
		addr <= 7'd0;
	end
end
/*
reg [8:0] weight0;
reg [8:0] weight1;
reg [8:0] weight2;
reg [8:0] weight3;
reg [8:0] weight4;
reg [8:0] weight5;
reg [8:0] weight6;
reg [8:0] weight7;
reg [8:0] weight8;
reg [8:0] weight9;
reg [8:0] weight10;
reg [8:0] weight11;
reg [8:0] weight12;
reg [8:0] weight13;
reg [8:0] weight14;
reg [8:0] weight15;
reg [8:0] weight16;
reg [8:0] weight17;
reg [8:0] weight18;
reg [8:0] weight19;
reg [8:0] weight20;
reg [8:0] weight21;
reg [8:0] weight22;
reg [8:0] weight23;
reg [8:0] weight24;
always@(posedge cnn_clk)
begin
    weight0<=weight_reg[0];
     weight1<=weight_reg[1];
     weight2<=weight_reg[2];
     weight3<=weight_reg[3];
     weight4<=weight_reg[4];
     weight5<=weight_reg[5];
     weight6<=weight_reg[6];
     weight7<=weight_reg[7];
     weight8<=weight_reg[8];
     weight9<=weight_reg[9];
     weight10<=weight_reg[10];
     weight11<=weight_reg[11];
      weight12<=weight_reg[12];
     weight13<=weight_reg[13];
     weight14<=weight_reg[14];
     weight15<=weight_reg[15];
     weight16<=weight_reg[16];
     weight17<=weight_reg[17];
     weight18<=weight_reg[18];
     weight19<=weight_reg[19];
     weight20<=weight_reg[20];
     weight21<=weight_reg[21];
     weight22<=weight_reg[22];
     weight23<=weight_reg[23];
     weight24<=weight_reg[24];
end
*/
//wire [18:0] bias_amend;
//assign bias_amend = {{2{bias_reg[8]}},(bias_reg<<8)};
wire [18:0] mul_adder_reg1;
wire [18:0] mul_adder_reg2;
wire [18:0] mul_adder_reg3;
wire [18:0] mul_adder_reg4;
wire [18:0] mul_adder_reg5;
wire [18:0] mul_adder_reg6;
wire [18:0] mul_adder_reg7;
wire [18:0] mul_adder_reg8;
wire [18:0] mul_adder_reg9;
wire [18:0] mul_adder_reg10;
wire [18:0] mul_adder_reg11;
wire [18:0] mul_adder_reg12;
wire [18:0] mul_adder_reg13;
wire [18:0] mul_adder_reg14;
wire [18:0] mul_adder_reg15;
wire [18:0] mul_adder_reg16;
wire [18:0] mul_adder_reg17;
wire [18:0] mul_adder_reg18;
wire [18:0] mul_adder_reg19;
wire [18:0] mul_adder_reg20;
wire [18:0] mul_adder_reg21;
wire [18:0] mul_adder_reg22;
wire [18:0] mul_adder_reg23;
wire [18:0] mul_adder_reg24;
wire [18:0] mul_adder_reg25;

//*********************************************************** 流水结构 乘累加  ****************************************//
/*
multiply mul_inst1(.cnn_clk (cnn_clk), .dina (matrix_row1[44:36]), .dinb (weight0), .dout (mul_adder_reg1));
multiply mul_inst2(.cnn_clk (cnn_clk), .dina (matrix_row1[35:27]), .dinb (weight1), .dout (mul_adder_reg2));
multiply mul_inst3(.cnn_clk (cnn_clk), .dina (matrix_row1[26:18]), .dinb (weight2), .dout (mul_adder_reg3));
multiply mul_inst4(.cnn_clk (cnn_clk), .dina (matrix_row1[17:9]), .dinb (weight3), .dout (mul_adder_reg4));
multiply mul_inst5(.cnn_clk (cnn_clk), .dina (matrix_row1[8:0]), .dinb (weight4), .dout (mul_adder_reg5));
multiply mul_inst6(.cnn_clk (cnn_clk), .dina (matrix_row2[44:36]), .dinb (weight5), .dout (mul_adder_reg6));
multiply mul_inst7(.cnn_clk (cnn_clk), .dina (matrix_row2[35:27]), .dinb (weight6), .dout (mul_adder_reg7));
multiply mul_inst8(.cnn_clk (cnn_clk), .dina (matrix_row2[26:18]), .dinb (weight7), .dout (mul_adder_reg8));
multiply mul_inst9(.cnn_clk (cnn_clk), .dina (matrix_row2[17:9]), .dinb (weight8), .dout (mul_adder_reg9));
multiply mul_inst10(.cnn_clk (cnn_clk), .dina (matrix_row2[8:0]), .dinb (weight9), .dout (mul_adder_reg10));
multiply mul_inst11(.cnn_clk (cnn_clk), .dina (matrix_row3[44:36]), .dinb (weight10), .dout (mul_adder_reg11));
multiply mul_inst12(.cnn_clk (cnn_clk), .dina (matrix_row3[35:27]), .dinb (weight11), .dout (mul_adder_reg12));
multiply mul_inst13(.cnn_clk (cnn_clk), .dina (matrix_row3[26:18]), .dinb (weight12), .dout (mul_adder_reg13));
multiply mul_inst14(.cnn_clk (cnn_clk), .dina (matrix_row3[17:9]), .dinb (weight13), .dout (mul_adder_reg14));
multiply mul_inst15(.cnn_clk (cnn_clk), .dina (matrix_row3[8:0]), .dinb (weight14), .dout (mul_adder_reg15));
multiply mul_inst16(.cnn_clk (cnn_clk), .dina (matrix_row4[44:36]), .dinb (weight15), .dout (mul_adder_reg16));
multiply mul_inst17(.cnn_clk (cnn_clk), .dina (matrix_row4[35:27]), .dinb (weight16), .dout (mul_adder_reg17));
multiply mul_inst18(.cnn_clk (cnn_clk), .dina (matrix_row4[26:18]), .dinb (weight17), .dout (mul_adder_reg18));
multiply mul_inst19(.cnn_clk (cnn_clk), .dina (matrix_row4[17:9]), .dinb (weight18), .dout (mul_adder_reg19));
multiply mul_inst20(.cnn_clk (cnn_clk), .dina (matrix_row4[8:0]), .dinb (weight19), .dout (mul_adder_reg20));
multiply mul_inst21(.cnn_clk (cnn_clk), .dina (matrix_row5[44:36]), .dinb (weight20), .dout (mul_adder_reg21));
multiply mul_inst22(.cnn_clk (cnn_clk), .dina (matrix_row5[35:27]), .dinb (weight21), .dout (mul_adder_reg22));
multiply mul_inst23(.cnn_clk (cnn_clk), .dina (matrix_row5[26:18]), .dinb (weight22), .dout (mul_adder_reg23));
multiply mul_inst24(.cnn_clk (cnn_clk), .dina (matrix_row5[17:9]), .dinb (weight23), .dout (mul_adder_reg24));
multiply mul_inst25(.cnn_clk (cnn_clk), .dina (matrix_row5[8:0]), .dinb (weight24), .dout (mul_adder_reg25));
*/

// clk1
multiply mul_inst1(.cnn_clk (cnn_clk), .dina (matrix_row1[44:36]), .dinb (weight_reg[0]), .dout (mul_adder_reg1));
multiply mul_inst2(.cnn_clk (cnn_clk), .dina (matrix_row1[35:27]), .dinb (weight_reg[1]), .dout (mul_adder_reg2));
multiply mul_inst3(.cnn_clk (cnn_clk), .dina (matrix_row1[26:18]), .dinb (weight_reg[2]), .dout (mul_adder_reg3));
multiply mul_inst4(.cnn_clk (cnn_clk), .dina (matrix_row1[17:9]), .dinb (weight_reg[3]), .dout (mul_adder_reg4));
multiply mul_inst5(.cnn_clk (cnn_clk), .dina (matrix_row1[8:0]), .dinb (weight_reg[4]), .dout (mul_adder_reg5));
multiply mul_inst6(.cnn_clk (cnn_clk), .dina (matrix_row2[44:36]), .dinb (weight_reg[5]), .dout (mul_adder_reg6));
multiply mul_inst7(.cnn_clk (cnn_clk), .dina (matrix_row2[35:27]), .dinb (weight_reg[6]), .dout (mul_adder_reg7));
multiply mul_inst8(.cnn_clk (cnn_clk), .dina (matrix_row2[26:18]), .dinb (weight_reg[7]), .dout (mul_adder_reg8));
multiply mul_inst9(.cnn_clk (cnn_clk), .dina (matrix_row2[17:9]), .dinb (weight_reg[8]), .dout (mul_adder_reg9));
multiply mul_inst10(.cnn_clk (cnn_clk), .dina (matrix_row2[8:0]), .dinb (weight_reg[9]), .dout (mul_adder_reg10));
multiply mul_inst11(.cnn_clk (cnn_clk), .dina (matrix_row3[44:36]), .dinb (weight_reg[10]), .dout (mul_adder_reg11));
multiply mul_inst12(.cnn_clk (cnn_clk), .dina (matrix_row3[35:27]), .dinb (weight_reg[11]), .dout (mul_adder_reg12));
multiply mul_inst13(.cnn_clk (cnn_clk), .dina (matrix_row3[26:18]), .dinb (weight_reg[12]), .dout (mul_adder_reg13));
multiply mul_inst14(.cnn_clk (cnn_clk), .dina (matrix_row3[17:9]), .dinb (weight_reg[13]), .dout (mul_adder_reg14));
multiply mul_inst15(.cnn_clk (cnn_clk), .dina (matrix_row3[8:0]), .dinb (weight_reg[14]), .dout (mul_adder_reg15));
multiply mul_inst16(.cnn_clk (cnn_clk), .dina (matrix_row4[44:36]), .dinb (weight_reg[15]), .dout (mul_adder_reg16));
multiply mul_inst17(.cnn_clk (cnn_clk), .dina (matrix_row4[35:27]), .dinb (weight_reg[16]), .dout (mul_adder_reg17));
multiply mul_inst18(.cnn_clk (cnn_clk), .dina (matrix_row4[26:18]), .dinb (weight_reg[17]), .dout (mul_adder_reg18));
multiply mul_inst19(.cnn_clk (cnn_clk), .dina (matrix_row4[17:9]), .dinb (weight_reg[18]), .dout (mul_adder_reg19));
multiply mul_inst20(.cnn_clk (cnn_clk), .dina (matrix_row4[8:0]), .dinb (weight_reg[19]), .dout (mul_adder_reg20));
multiply mul_inst21(.cnn_clk (cnn_clk), .dina (matrix_row5[44:36]), .dinb (weight_reg[20]), .dout (mul_adder_reg21));
multiply mul_inst22(.cnn_clk (cnn_clk), .dina (matrix_row5[35:27]), .dinb (weight_reg[21]), .dout (mul_adder_reg22));
multiply mul_inst23(.cnn_clk (cnn_clk), .dina (matrix_row5[26:18]), .dinb (weight_reg[22]), .dout (mul_adder_reg23));
multiply mul_inst24(.cnn_clk (cnn_clk), .dina (matrix_row5[17:9]), .dinb (weight_reg[23]), .dout (mul_adder_reg24));
multiply mul_inst25(.cnn_clk (cnn_clk), .dina (matrix_row5[8:0]), .dinb (weight_reg[24]), .dout (mul_adder_reg25));


reg [18:0] add0_0,add0_1,add0_2,add0_3,add0_4,add0_5,add0_6,add0_7,add0_8,add0_9,add0_10,add0_11,add0_12;

/*assign add0_0 = mul_adder_reg1+mul_adder_reg2;
assign	add0_1 = mul_adder_reg3+mul_adder_reg4;
assign	add0_2 = mul_adder_reg5+mul_adder_reg6;
assign	add0_3 = mul_adder_reg7+mul_adder_reg8;
assign	add0_4 = mul_adder_reg9+mul_adder_reg10;
assign	add0_5 = mul_adder_reg11+mul_adder_reg12;
assign	add0_6 = mul_adder_reg13+mul_adder_reg14;
assign	add0_7 = mul_adder_reg15+mul_adder_reg16;
assign	add0_8 = mul_adder_reg17+mul_adder_reg18;
assign	add0_9 = mul_adder_reg19+mul_adder_reg20;
assign	add0_10 = mul_adder_reg21+mul_adder_reg22;
assign	add0_11 = mul_adder_reg23+mul_adder_reg24;
assign	add0_12 = mul_adder_reg25+bias_reg;
assign  add1_0 = add0_0+add0_1;
assign	add1_1 = add0_2+add0_3;
assign	add1_2 = add0_4+add0_5;
assign	add1_3 = add0_6+add0_7;
assign	add1_4 = add0_8+add0_9;
assign	add1_5 = add0_10+add0_11;
assign	add1_6 = add0_12;
assign	add2_0 = add1_0+add1_1;
assign	add2_1 = add1_2+add1_3;
assign	add2_2 = add1_4+add1_5;
assign	add2_3 = add1_6;
assign	add3_0 = add2_0+add2_1;
assign	add3_1 = add2_2+add2_3;
assign	add4_0 = add3_0+add3_1;
	*/
//clk2
//always @ ( posedge cnn_clk )
/*
always@(mul_adder_reg1 or mul_adder_reg2 or mul_adder_reg3 or mul_adder_reg4 or mul_adder_reg5 or mul_adder_reg6 or mul_adder_reg7
 or mul_adder_reg8 or mul_adder_reg9 or mul_adder_reg10 or mul_adder_reg11 or mul_adder_reg12 or mul_adder_reg13 or mul_adder_reg14
 or mul_adder_reg15 or mul_adder_reg16 or mul_adder_reg17 or mul_adder_reg18 or mul_adder_reg19 or mul_adder_reg20 or mul_adder_reg21
 or mul_adder_reg22 or mul_adder_reg23 or mul_adder_reg24 or mul_adder_reg25 or add0_0 or add0_1 or add0_2 or add0_3 or add0_4 or 
 add0_5 or add0_6 or add0_7 or add0_8 or add0_9 or add0_10 or add0_11 or add0_12 or add1_0 or add1_1 or add1_2 or add1_3 or add1_4 or 
 add1_5 or add1_6 or add2_0 or add2_1 or add2_2 or add2_3 or add3_0 or add3_1 or add4_0)
//clk2*/
always @ ( posedge cnn_clk )
begin

	add0_0 <= mul_adder_reg1+mul_adder_reg2;
	add0_1 <= mul_adder_reg3+mul_adder_reg4;
	add0_2 <= mul_adder_reg5+mul_adder_reg6;
	add0_3 <= mul_adder_reg7+mul_adder_reg8;
	add0_4 <= mul_adder_reg9+mul_adder_reg10;
	add0_5 <= mul_adder_reg11+mul_adder_reg12;
	add0_6 <= mul_adder_reg13+mul_adder_reg14;
	add0_7 <= mul_adder_reg15+mul_adder_reg16;
	add0_8 <= mul_adder_reg17+mul_adder_reg18;
	add0_9 <= mul_adder_reg19+mul_adder_reg20;
	add0_10 <= mul_adder_reg21+mul_adder_reg22;
	add0_11 <= mul_adder_reg23+mul_adder_reg24;
	add0_12 <= mul_adder_reg25+bias_reg;
	/*
	add1_0 <= add0_0+add0_1;
	add1_1 <= add0_2+add0_3;
	add1_2 <= add0_4+add0_5;
	add1_3 <= add0_6+add0_7;
	add1_4 <= add0_8+add0_9;
	add1_5 <= add0_10+add0_11;
	add1_6 <= add0_12;
	add2_0 <= add1_0+add1_1;
	add2_1 <= add1_2+add1_3;
	add2_2 <= add1_4+add1_5;
	add2_3 <= add1_6;
	add3_0 <= add2_0+add2_1;
	add3_1 <= add2_2+add2_3;
	add4_0 <= add3_0+add3_1;
	*/
end
reg [18:0] add1_0,add1_1,add1_2,add1_3,add1_4,add1_5,add1_6;


//clk3	

always @ ( posedge cnn_clk )
begin

	add1_0 <= add0_0+add0_1;
	add1_1 <= add0_2+add0_3;
	add1_2 <= add0_4+add0_5;
	add1_3 <= add0_6+add0_7;
	add1_4 <= add0_8+add0_9;
	add1_5 <= add0_10+add0_11;
	add1_6 <= add0_12;
	
	
end

reg [18:0] add2_0,add2_1,add2_2,add2_3;


//clk4
always @ ( posedge cnn_clk )
begin

	add2_0 <= add1_0+add1_1;
	add2_1 <= add1_2+add1_3;
	add2_2 <= add1_4+add1_5;
	add2_3 <= add1_6;

end

reg [18:0] add3_0,add3_1;


//clk5

always @ ( posedge cnn_clk )
begin

	add3_0 <= add2_0+add2_1;
	add3_1 <= add2_2+add2_3;

end

reg [18:0] add4_0;

//clk6

always @ ( posedge cnn_clk )
begin

	add4_0 <= add3_0+add3_1;

end

//clk7
always @ ( posedge cnn_clk )
begin

	//norm_result <= add4_0[18] ? 12'd0 : add4_0[18:7];
	norm_result <= add4_0[18:7];        //数据规整，不做relu

end


endmodule

