module ADC_manager(
	input clk, // freq = 50MHz
	input rst,
	input ADC_read,
	output reg NEW_BYTE,
	output reg clk_out,
	output reg cs_out,
	output reg out_serial,
	output reg [7:0] out_parallel
);

	wire clk_div;
	wire clk_div2;
	wire [4:0] count;
	wire [2:0] count2;
	reg DoneRead;
	reg [7:0] out_temp;
	
	Freq_div_ADC u0(.clk(clk),.rst(rst),.clk_div(clk_div)); // 6.25kHz
	Counter #(.WIDTH(5),.max_count(25)) u1(.clk(clk_div),.rst(rst),.count(count)); // 25 steps per cs cycles (6.25k/25 = 250Sa/s)
	
	//Synchronization of output
	Freq_div2 u2(.clk(clk),.rst(rst),.clk_div(clk_div2)); // 2kHz
	Counter #(.WIDTH(3),.max_count(8)) u3(.clk(clk_div2),.rst(rst),.count(count2)); 
	
	always @ (posedge clk_div or posedge rst) begin
		if (rst) begin // Reset signals
			cs_out <= 0;
			clk_out <= 0;
			out_parallel <= 0;
			DoneRead <= 0;
		end else begin
			case (count)
				5'd0: begin
					cs_out <= 1;
					clk_out <= 0;
				end
				5'd1: begin
					cs_out <= 0;
					clk_out <= 0;
				end
				5'd2: begin
					cs_out <= 0;
					clk_out <= 1;
				end
				5'd3: begin
					cs_out <= 0;
					clk_out <= 0;
				end
				5'd4: begin
					cs_out <= 0;
					clk_out <= 1;
				end
				5'd5: begin
					cs_out <= 0;
					clk_out <= 0;
				end
				5'd6: begin
					cs_out <= 0;
					clk_out <= 1;
				end
				5'd7: begin
					cs_out <= 0;
					clk_out <= 0;
				end
				5'd8: begin
					cs_out <= 0;
					clk_out <= 1;
					out_parallel[7] <= ADC_read;
				end
				5'd9: begin
					cs_out <= 0;
					clk_out <= 0;
				end
				5'd10: begin
					cs_out <= 0;
					clk_out <= 1;
					out_parallel[6] <= ADC_read;
				end
				5'd11: begin
					cs_out <= 0;
					clk_out <= 0;
				end
				5'd12: begin
					cs_out <= 0;
					clk_out <= 1;
					out_parallel[5] <= ADC_read;
				end
				5'd13: begin
					cs_out <= 0;
					clk_out <= 0;
				end
				5'd14: begin
					cs_out <= 0;
					clk_out <= 1;
					out_parallel[4] <= ADC_read;
				end
				5'd15: begin
					cs_out <= 0;
					clk_out <= 0;
				end
				5'd16: begin
					cs_out <= 0;
					clk_out <= 1;
					out_parallel[3] <= ADC_read;
				end
				5'd17: begin
					cs_out <= 0;
					clk_out <= 0;
				end
				5'd18: begin
					cs_out <= 0;
					clk_out <= 1;
					out_parallel[2] <= ADC_read;
				end
				5'd19: begin
					cs_out <= 0;
					clk_out <= 0;
				end
				5'd20: begin
					cs_out <= 0;
					clk_out <= 1;
					out_parallel[1] <= ADC_read;
				end
				5'd21: begin
					cs_out <= 0;
					clk_out <= 0;
				end
				5'd22: begin
					cs_out <= 0;
					clk_out <= 1;
					out_parallel[0] <= ADC_read;
				end
				5'd23: begin
					cs_out <= 0;
					clk_out <= 0;
					DoneRead <= 1; // Done reading from ADC
				end
				5'd24: begin
					cs_out <= 1;
					clk_out <= 0;
					DoneRead <= 0; // Restarts ADC read
				end
				default: begin
					cs_out <= 0;
					clk_out <= 0;
					out_parallel <= 0;
					DoneRead <= 0;
				end
			endcase
		end
	end
	
	always @(posedge DoneRead or posedge rst) begin
		if (rst) begin
			out_temp <= 0;
		end else begin
			// Loads data to temp when finishes reading from ADC
			if (DoneRead) begin
				out_temp <= out_parallel;
			end else begin
				out_temp <= out_temp;
			end
		end
	end
	
	always @(posedge clk_div2 or posedge rst) begin
		if (rst) begin
			NEW_BYTE <= 0;
		end else begin
			// Outputs it at proper time (freq = 250Hz*8bits = 2kHz)
			case (count2)
				3'b000: begin
					out_serial <= out_temp[7];
					NEW_BYTE <= 1;
					end
				3'b001: begin
					out_serial <= out_temp[6];
					NEW_BYTE <= 0;
					end
				3'b010:
					out_serial <= out_temp[5];
				3'b011:
					out_serial <= out_temp[4];
				3'b100:
					out_serial <= out_temp[3];
				3'b101:
					out_serial <= out_temp[2];
				3'b110:
					out_serial <= out_temp[1];
				3'b111:
					out_serial <= out_temp[0];
				default:
					out_serial <= 0;
			endcase
		end
	end
	
endmodule
