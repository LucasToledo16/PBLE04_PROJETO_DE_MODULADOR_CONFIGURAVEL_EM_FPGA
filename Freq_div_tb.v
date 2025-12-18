`timescale 10ns/1ns
module Freq_div_tb;
	
	reg clk;
	reg rst;
	wire rst_div;
	wire clk_div;
	
	Freq_div u0(
		.clk(clk),
		.rst(rst),
		.rst_div(rst_div),
		.clk_div(clk_div)
	);
	
	always #1 clk=~clk;
	initial begin
		clk = 0;
		rst = 1;
		#3 rst = 0;
		#60000 $stop;
	end
	
endmodule 