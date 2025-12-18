// Frequency divisor (50MHz -> 6.25KHz)

module Freq_div_ADC
(
	input clk,
	input rst,
	output reg clk_div
);
	
	wire [11:0] clk_count;
	wire Is_Val_Reached; // count ? 4000 1:0
	
	Counter #(.WIDTH(12),.max_count(4000)) u0 (.clk(clk),.rst(rst),.count(clk_count)); // (50M/250)/(2*25) = 4000 (25 steps per cycle)
	
	assign Is_Val_Reached = clk_count[11] & clk_count[10] &
									clk_count[9] & clk_count[8] & clk_count[7] & ~clk_count[6] & ~clk_count[5] &
								   clk_count[4] & clk_count[3] & clk_count[2] & clk_count[1] & clk_count[0];
								   // 3999 = 12'b1111_1001_1111
	
	always @(posedge clk or posedge rst) begin
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