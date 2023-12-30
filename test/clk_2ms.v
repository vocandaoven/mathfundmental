`timescale 1ns / 1ps

module clk_2ms( 
	input clk, 
	output reg clk_2ms
);
	 
	reg [31:0] cnt;

	initial begin
		cnt = 32'b0;
	end

	wire[31:0] cnt_next;
	assign cnt_next = cnt + 1'b1;

	always @(posedge clk) begin
		if(cnt<10_000_0)begin
			cnt <= cnt_next;
		end
		else begin
			cnt <= 0;
			clk_2ms <= ~clk_2ms;
		end
	end

endmodule
