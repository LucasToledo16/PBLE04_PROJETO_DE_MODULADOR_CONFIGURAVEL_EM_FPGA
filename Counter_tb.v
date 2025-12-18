`timescale 10ps/1ps
module Counter_tb;

	parameter WIDTH=8;
	
	reg clk;
	reg rst;
	wire [WIDTH-1:0] count;
	
	Counter #(.max_count(20))u0(
		.clk(clk),
		.rst(rst),
		.count(count)
	);

	always #5 clk =~clk;
	initial begin
	clk <= 0;
	rst <= 1;
	#6 rst <= 0;
	#5000 $finish;
	end
	
endmodule