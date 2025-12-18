module Acq_hold
(
	input clk,
	input rst,
	input in,
	output reg [1:0] out
);

	wire clk2;
	reg count;
	reg [1:0] temp;

	Freq_div_Acq_hold u0 (.clk(clk),.rst(rst),.clk_div(clk2)); // freq = 2kHz
	
	always @ (posedge clk2 or posedge rst) begin
		if (rst) begin // Resets all three registers
			out <= 0;
			temp <= 0;
			count <= 0;
		end else begin // Charges temporary register at every clk2 positive edge
			if (!count) begin
				temp[0] <= in;
			end else begin
				temp[1] <= in;
				out <= temp; // At the end, loads the final output with the content of the temporary buffer
			end
			count <= ~count; // Intercalates first and second position in temporary buffer for charging
		end
	end

endmodule