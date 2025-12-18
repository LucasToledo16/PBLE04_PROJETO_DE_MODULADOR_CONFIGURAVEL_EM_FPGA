module Carrier_gen
#(parameter DC = 375) // DutyCycle = (DC/500)*100%
(
	input clk,
	input rst,
	output reg out
);

	reg [8:0] count; // freq = 100kHz (50MHz/(100kHz) = 500 < 512 = 2^9)
	
	always @ (posedge clk or posedge rst) begin
		if (rst) begin // Reset signal
			out <= 0;
			count <= 0;
		end else begin
			if (count >= 499) begin // Maximum value counted (guarantees 100kHz frequence)
				count <= 0;
			end else begin
				count <= count + 9'b1; // Increment
				if (count < DC) begin // Checks counter for DutyCycle implementation
					out <= 1;
				end else begin
					out <= 0;
				end
			end
		end
	end 

endmodule