`timescale 10ns/1ns // 50MHz (#1 clk =~clk)
module Main_tb;
	
	reg clk;
	reg rst;
	reg ADC_read;
	reg out_env_detect;
	wire out_PWM;
	wire clk_ADC;
	wire cs_ADC;
	wire out_serial;
	wire [7:0] out_parallel;
	wire out_BASK;
	wire out_DEMOD;
	wire out_4ASK;
	
	Main u0(
			.clk(clk),
			.rst(rst),
			.ADC_read(ADC_read),
			.out_env_detect(out_env_detect),
			.out_PWM(out_PWM),
			.clk_ADC(clk_ADC),
			.cs_ADC(cs_ADC),
			.out_serial(out_serial),
			.out_parallel(out_parallel),
			.out_BASK(out_BASK),
			.out_DEMOD(out_DEMOD),
			.out_4ASK(out_4ASK)
	);
	
	reg vector [127:0];
	reg clk2; // freq = 2kHz
	
	always #1 clk =~clk;		
	initial begin
		$readmemb("testbench_ADC.txt",vector);
		clk <= 0;
		clk2 <= 0;
		rst <= 0;
		#3 rst <= 1;
		#3 rst <= 0;
		#100_000_000 $stop;
	end
	
	integer i = 0;
	always @ (negedge clk_ADC) begin
		ADC_read <= vector[i];
		i = i + 1;
	end

	always #25000 clk2 =~clk2;
	always @ (posedge clk2) begin
		#610 // Delay to force posedge clk2 matching with first carrier BASK pulse (BASK envelope emulation)
		if (out_BASK) begin
			out_env_detect <= 1;
		end else begin
			out_env_detect <= 0;
		end
	end
	
endmodule
