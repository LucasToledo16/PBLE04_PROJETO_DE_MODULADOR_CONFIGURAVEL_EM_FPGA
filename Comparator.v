// Comparator asynchronous 8 bits

module Comparator
(
	input clk,
	input  [7:0] in1,
	input  [7:0] in2,
	output reg out // in1>=in2 -> 1, in1<in2 -> 0
);
	/*
	wire [7:0] diff;
	
	assign diff = in1 - in2;
	assign out = ~diff[7];
	*/
	
	always @ (posedge clk) begin
		if(in1 >= in2) begin
			out <= 1'b1;
		end else begin
			out <= 1'b0;
		end
	end

endmodule