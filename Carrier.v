// Frequency divisor (50MHz -> 100KHz) - Carrier BASK

module Carrier
(
	input clk,
	input rst,
	output reg clk_div
);
	
	wire [7:0] clk_count;
	wire Is_Val_Reached; // count ? 250 1:0
	
	Counter #(.WIDTH(8),.max_count(250)) u0 (.clk(clk),.rst(rst),.count(clk_count)); // (50M/250)/2 = 100000
	
	assign Is_Val_Reached = clk_count[7] & clk_count[6] & clk_count[5] &
								   clk_count[4] & clk_count[3] & ~clk_count[2] & ~clk_count[1] & clk_count[0];
								   // 249 = 8'b1111_1001
	
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