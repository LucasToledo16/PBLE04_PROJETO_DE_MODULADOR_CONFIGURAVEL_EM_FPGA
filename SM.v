// 10-State Moore state machine

// A Moore machine's outputs are dependent only on the current state.
// The output is written only when the state changes.  (State
// transitions are synchronous.)

module SM
(
	input	clk,
	input rst,
	output reg [7:0] out
);

	// Declare state register
	reg [3:0] state;

	// Declare states
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6, S7 = 7, S8 = 8, S9 = 9;

	// Output depends only on the state
	always @ (state) begin
		case (state)
			S0:
				out = 8'b0000_0000;
			S1:
				out = 8'b0001_1100;
			S2:
				out = 8'b0011_1000;
			S3:
				out = 8'b0101_0101;
			S4:
				out = 8'b0111_0001;
			S5:
				out = 8'b1000_1101;
			S6:
				out = 8'b1010_1010;
			S7:
				out = 8'b1100_0110;
			S8:
				out = 8'b1110_0010;
			S9:
				out = 8'b1111_1111;
			default:
				out = 8'b0000_0000;
		endcase
	end

	// Determine the next state
	always @ (posedge clk or posedge rst) begin
		if (rst)
			state <= S0;
		else
			case (state)
				S0:
					state <= S1;
				S1:
					state <= S2;
				S2:
					state <= S3;
				S3:
					state <= S4;
				S4:
					state <= S5;
				S5:
					state <= S6;
				S6:
					state <= S7;
				S7:
					state <= S8;
				S8:
					state <= S9;
				S9:
					state <= S0;
				default:
					state <= S0;
			endcase
	end

endmodule
