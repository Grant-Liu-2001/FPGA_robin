
`timescale 1ns/1ps

module testbench_top();
	
////////////////////////////////////////////////////////////
//参数定义

`define CLK_PERIORD		10		//时钟周期设置为10ns（100MHz）	

////////////////////////////////////////////////////////////
//接口申明
parameter NUM_REQ = 4;
reg clk;
reg rst;
reg [NUM_REQ-1:0] req;
wire[NUM_REQ-1:0] gnt;

////////////////////////////////////////////////////////////	
//对被测试的设计进行例化
	
	
fixed_pri_arb		Fixed_pri_arb(
	.clk(clk),
	.rst(rst),
	.req(req),
	.gnt(gnt)
	
    );	
////////////////////////////////////////////////////////////
//复位和时钟产生

	//时钟和复位初始化、复位产生
initial begin
	clk <= 0;
	rst <= 0;
	
	req <= 'd0;
	
	
	#1000;
	rst <= 1;
	
	
end
	
	//时钟产生
always #(`CLK_PERIORD/2) clk = ~clk;	

////////////////////////////////////////////////////////////
//测试激励产生

initial begin
	
	@(posedge rst);	//等待复位完成
	
	@(posedge clk);
	
	req <= 4'b1111;
	
	repeat(15) begin
		@(posedge clk);
	end
	
	#1_000;
	$stop;
end


endmodule






