`timescale 10ns/1ns // 50MHz (#1 clk =~clk)
module BASK_tb;

	reg clk;
	reg rst;
	reg sel;
	wire modulated;
	
	BASK u0 (
		.clk(clk),
		.rst(rst),
		.sel(sel),
		.modulated(modulated)
	);
	
	always #1 clk=~clk;
	always #50_000 sel=~sel;
	initial begin
	sel = 0;
	clk = 0;
	rst = 0;
	#3 rst = 1;
	#3 rst = 0;
	#200_000 $stop;
	end

endmodule