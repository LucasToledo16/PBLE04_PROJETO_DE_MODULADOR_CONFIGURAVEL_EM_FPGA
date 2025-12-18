`timescale 10ns/1ns 
module Comparator_tb;

	reg clk;
	reg  [7:0] in1;
	reg  [7:0] in2;
	wire out;
	
	Comparator u0(
		.clk(clk),
		.in1(in1),
		.in2(in2),
		.out(out)
	);
	
	always #1 clk=~clk;
	initial begin
		clk = 0;
		#2 
		in1 = 8'b0110_0110;
	   in2 = 8'b0110_0111;		
		
		#5 
		in1 = 8'b0101_0100;
	   in2 = 8'b0110_0001;
		
		#5
		in1 = 8'b0010_1100;
	   in2 = 8'b0010_1100;
		
		#5 
		in1 = 8'b1001_0100;
	   in2 = 8'b0110_1010;
		
		#5 
		in1 = 8'b0000_0000;
	   in2 = 8'b1111_1111;
		
		#10 $stop;
	end
	
endmodule