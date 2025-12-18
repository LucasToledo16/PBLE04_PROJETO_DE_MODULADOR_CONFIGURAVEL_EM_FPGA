// Binary cyclic counter

module Counter
#(parameter WIDTH=8, max_count=200)
(
	input clk, 
	input rst,
	output reg [WIDTH-1:0] count
);

	always @ (posedge clk or posedge rst) begin
		if (rst) begin
			count <= 0;
		end else begin
			if (count >= max_count-1) begin
				count <= 0;
			end else begin
				count <= count + 1'b1;
			end
		end
	end 

endmodule
