module Four_ASK
(
	input clk,
	input rst,
	input message,
	output reg modulated
);

	wire [1:0] sel;
	wire carrier1, carrier2, carrier3, carrier4, out;

	Acq_hold u0 (.clk(clk),.rst(rst),.in(message),.out(sel));
	MUX_4ASK u1 (.carrier1(carrier1),.carrier2(carrier2),.carrier3(carrier3),.carrier4(carrier4),.sel(sel),.out(out));
	Carrier_gen #(.DC(22)) u2 (.clk(clk),.rst(rst),.out(carrier1)); // DutyCycle = 4.3%
	Carrier_gen #(.DC(47)) u3 (.clk(clk),.rst(rst),.out(carrier2)); // DutyCycle = 9.4%
	Carrier_gen #(.DC(82)) u4 (.clk(clk),.rst(rst),.out(carrier3)); // DutyCycle = 16.4%
	Carrier_gen #(.DC(115)) u5 (.clk(clk),.rst(rst),.out(carrier4)); // DutyCycle = 23%

	always @ (posedge clk or posedge rst) begin
		if (rst) begin
			modulated <= 0;
		end else begin
			modulated <= out;
		end
	end

endmodule