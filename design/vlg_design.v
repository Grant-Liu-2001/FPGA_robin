
`timescale 1ns/1ps


module fixed_pri_arb(
			input clk,
			input rst,
			input [3:0] req,
			output [3:0] gnt
			);
			
	parameter NUM_REQ = 4;
	parameter N = NUM_REQ - 1'b1;
	reg [N:0] hist_q,hist_d; 
	wire [2*N:0] double_req; 
	wire [2*N:0] double_gnt;
	
	always@(posedge clk)begin
		if(!rst)begin
			hist_q <= 'b0 + 1'b1;
		end
		else if(|req)begin
			hist_q<= {gnt[N-1:0],gnt[N]};
		end
	end
	
	
	
	assign double_req = {req,req};
	assign double_gnt = double_req&~(double_req-hist_q);
	assign gnt = double_gnt[N:0] | double_gnt[2*N:N+1];
				
	
	
		
endmodule