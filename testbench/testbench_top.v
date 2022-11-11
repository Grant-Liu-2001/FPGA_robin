
`timescale 1ns/1ps

module testbench_top();
	
////////////////////////////////////////////////////////////
//��������

`define CLK_PERIORD		10		//ʱ����������Ϊ10ns��100MHz��	

////////////////////////////////////////////////////////////
//�ӿ�����
parameter NUM_REQ = 4;
reg clk;
reg rst;
reg [NUM_REQ-1:0] req;
wire[NUM_REQ-1:0] gnt;

////////////////////////////////////////////////////////////	
//�Ա����Ե���ƽ�������
	
	
fixed_pri_arb		Fixed_pri_arb(
	.clk(clk),
	.rst(rst),
	.req(req),
	.gnt(gnt)
	
    );	
////////////////////////////////////////////////////////////
//��λ��ʱ�Ӳ���

	//ʱ�Ӻ͸�λ��ʼ������λ����
initial begin
	clk <= 0;
	rst <= 0;
	
	req <= 'd0;
	
	
	#1000;
	rst <= 1;
	
	
end
	
	//ʱ�Ӳ���
always #(`CLK_PERIORD/2) clk = ~clk;	

////////////////////////////////////////////////////////////
//���Լ�������

initial begin
	
	@(posedge rst);	//�ȴ���λ���
	
	@(posedge clk);
	
	req <= 4'b1111;
	
	repeat(15) begin
		@(posedge clk);
	end
	
	#1_000;
	$stop;
end


endmodule






