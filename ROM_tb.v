//`timescale 10ns/1ns // 50MHz (#1 clk =~clk)
`timescale  100us/1ps // 2KHz (#2.5 clk =~clk)
module ROM_tb;

	parameter DATA_WIDTH=8;
	parameter ADDR_WIDTH=11;

	reg clk;
	reg [ADDR_WIDTH-1:0] addr;
	wire [DATA_WIDTH-1:0] q;

	//ROM #(.DATA_MEM(2)) u0( 
	ROM u0( 
		.clk(clk),
		.addr(addr),
		.q(q)
	);
		
	always #5 clk =~clk;		
	initial begin
		clk = 0;
	   addr = 0;
		#6 addr = 4; //247
		#10 addr = 6; // 247
		#10 addr = 11; // 246
		#10 addr = 14; // 245
		
		#15 $stop;
	end

endmodule
	