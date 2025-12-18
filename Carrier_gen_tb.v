`timescale 10ns/1ns // 50MHz (#1 clk =~clk)
module Carrier_gen_tb;

	reg clk;
	reg rst;
	wire out;

	Carrier_gen u0(
		.clk(clk),
		.rst(rst),
		.out(out)
	);
	
	always #1 clk =~clk;		
	initial begin
		clk <= 0;
		rst <= 0;
		#3 rst <= 1;
		#3 rst <= 0;
		#100_000_000 $stop;
	end
	
endmodule