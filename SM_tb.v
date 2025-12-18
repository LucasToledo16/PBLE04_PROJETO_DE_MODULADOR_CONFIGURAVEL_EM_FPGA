`timescale  100us/1ps // 2KHz (#5)
module SM_tb;

	reg	clk;
	reg rst;
	wire [7:0] out;
	
	SM u0(
		.clk(clk),
		.rst(rst),
		.out(out)
	);
	
	always #5 clk =~clk;		
	initial begin
		clk <= 0;
		rst <= 1;
		#10 rst <= 0;
	
		#110 $stop;
	end
endmodule