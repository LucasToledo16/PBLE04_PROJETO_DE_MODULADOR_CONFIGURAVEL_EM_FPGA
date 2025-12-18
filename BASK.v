// BASK Modulator - synchronous

module BASK
(
	input clk,
	input rst,
	input sel,
	output reg modulated
);

	wire carrier;
	wire out;

	Carrier u0 (.clk(clk),.rst(rst),.clk_div(carrier));
	MUX_BASK u1 (.carrier1(carrier),.carrier2(1'b0),.sel(sel),.out(out));
	
	always @ (posedge clk or posedge rst) begin
		if (rst) begin
			modulated <= 0;
		end else begin
			modulated <= out;
		end
	end
	
endmodule