`timescale 10ns/1ns
module ADC_manager_tb;

	reg clk;
	reg rst;
	reg ADC_read;
	wire NEW_BYTE;
	wire clk_out;
	wire cs_out;
	wire out_serial;
	wire [7:0] out_parallel;

	ADC_manager u0(
		.clk(clk),
		.rst(rst),
		.ADC_read(ADC_read),
		.NEW_BYTE(NEW_BYTE),
		.clk_out(clk_out),
		.cs_out(cs_out),
		.out_serial(out_serial),
		.out_parallel(out_parallel)
	);
	
	reg vector [127:0];
	
	always #1 clk=~clk;
	initial begin
	$readmemb("testbench_ADC.txt",vector);
	
	clk <= 0;
	rst <= 0;
	#3 rst <= 1;
	#3 rst <= 0;
	#1_250_000 $stop;
	end
	
	integer i = 0;
	always @ (negedge clk_out) begin
		ADC_read <= vector[i];
		i = i + 1;
	end
	
endmodule