// DEMOD from sequencial bit stream to pseudo-PWM
// freq = 50MHz, counter maximum value expected = 200.000 => true freq = 250Hz

module DEMOD
(
	input clk,
	input rst,
	input NEW_BYTE,
	input signal,
	output reg out
);	

	wire NB_aux;
	reg [14:0] NB_aux_count; // "NEW_BYTE" signal is 25000 counts wide (2^15 > 25000)
	reg [17:0] count;
	reg [7:0] temp;

	// Auxiliary control signal generation (a full "clk" width, posedge "NEW_BYTE" driven signal, synchronous)
	always @ (posedge rst or posedge clk) begin
		if (rst) begin
			NB_aux_count <= 0;
		end else begin
			if (NEW_BYTE) begin
				NB_aux_count <= NB_aux_count + 1;
			end else begin
				NB_aux_count <= 0;
			end
		end
	end
	assign NB_aux = (NB_aux_count == 1);
	
	// Counter 18bits (0 to 262143) - Asynchronous reset
	always @ (posedge rst or posedge NB_aux or posedge clk) begin
		if (rst | NB_aux) begin 
			count <= 17'b0_0000_0000_0000_0000;	
		end else begin 
			count <= count + 17'b0_0000_0000_0000_0001;	
		end
	end	
	
	// Creation of buffer for sample Byte (subtract two to compensate delayed count start)
	always @ (posedge clk) begin // 200.000/8 = 25.000
		if (count < 25000-2) begin // 0*25000 <= count < 1*25000 => bit7 (MSB)
			temp[7] <= signal;
		end else begin
			if (count < 50000-2) begin // 1*25000 <= count < 2*25000 => bit6
				temp[6] <= signal;
			end else begin
				if (count < 75000-2) begin // 2*25000 <= count < 3*25000 => bit5
					temp[5] <= signal;
				end else begin
					if (count < 100000-2) begin // 3*25000 <= count < 4*25000 => bit4
						temp[4] <= signal;
					end else begin
						if (count < 125000-2) begin // 4*25000 <= count < 5*25000 => bit3
							temp[3] <= signal;
						end else begin 
							if (count < 150000-2) begin // 5*25000 <= count < 6*25000 => bit2
								temp[2] <= signal;
							end else begin
								if (count < 175000-2) begin // 6*25000 <= count < 7*25000 => bit1
									temp[1] <= signal;
								end else begin	
									if (count < 200000-2) begin // 7*25000 <= count < 8*25000 => bit0 (LSB)
										temp[0] <= signal;
									end else begin // default off-bound: holds it value
										temp <= temp;
									end
								end
							end
						end
					end
				end
			end
		end
	end
	
	// Pseud0-PWM generation (subtract two to compensate delayed count start)
	// Approximation errors: between 4 - 6.1 %
	always @ (posedge clk) begin // x*(1/2 + 1/4 + ... + 1/256) = 200000 => x = 200784
		if (count < 100392-2) begin // 0 <= count < x/2 => out <- bit7
			out <= temp[7];
		end else begin
			if (count < 150588-2) begin // x/2 <= count < 3*x/4 => out <- bit6
				out <= temp[6];
			end else begin
				if (count < 175686-2) begin // 3*x/4 <= count < 7*x/8 => out <- bit5
					out <= temp[5];
				end else begin
					if (count < 188235-2) begin // 7*x/8 <= count < 15*x/16 => out <- bit4
						out <= temp[4];
					end else begin
						if (count < 194509-2) begin // 15*x/16 <= count < 31*x/32 => out <- bit3
							out <= temp[3];
						end else begin
							if (count < 197647-2) begin // 31*x/32 <= count < 63*x/64 => out <- bit2
								out <= temp[2];
							end else begin
								if (count < 199215-2) begin // 63*x/64 <= count < 127*x/128 => out <- bit1
									out <= temp[1];
								end else begin
									if (count < 200000-2) begin // 127*x/128 <= count < 255*x/256 => out <- bit0
										out <= temp[0];
									end else begin // default off-bound: sends 0
										out <= 0;
									end
								end
							end
						end
					end
				end
			end
		end
	end


endmodule

	// Counter 18bits (0 to 262143) - Synchronous reset
	//always @ (posedge rst or posedge NEW_BYTE or posedge clk) begin
	//	if (clk) begin  // Accumulation 
	//		count <= count + 17'b0_0000_0000_0000_0001;	
	//	end else begin // Counter reset condition: Main reset or New byte income
	//		count <= 0;
	//	end
	//end	