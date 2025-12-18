// Frequency divisor (50MHz -> 2KHz)

module Freq_div_Acq_hold
(
	input clk,
	input rst,
	output reg clk_div
);
	
	wire [13:0] clk_count;
	wire Is_Val_Reached; // count ? 25000 1:0
	
	Counter #(.WIDTH(14),.max_count(12500)) u0 (.clk(clk),.rst(rst),.count(clk_count)); // (50M/2K)/2 = 12500
	
	assign Is_Val_Reached = clk_count[13] & clk_count[12] & ~clk_count[11] & ~clk_count[10] &
								   ~clk_count[9] & ~clk_count[8] & clk_count[7] & clk_count[6] & ~clk_count[5] &
								   clk_count[4] & ~clk_count[3] & ~clk_count[2] & clk_count[1] & clk_count[0];
								   // 12499 = 14'b11_0000_1101_0011
	
	always @(posedge clk) begin
		if (rst) begin
			clk_div <= 0;
		end else begin
			if (Is_Val_Reached) begin
				clk_div <= ~clk_div;
			end else begin
				clk_div <= clk_div;
			end
		end
	end

endmodule 