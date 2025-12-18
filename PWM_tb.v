`timescale 10ns/1ns // 50MHz (#1 clk =~clk)
module PWM_tb;
	
	parameter DATA_WIDTH=8;
	parameter ADDR_WIDTH_signal=11;
	parameter ADDR_WIDTH_ramp=8;
	
	reg clk;
	reg rst;
	wire out;
	
	PWM u0(
			.clk(clk),
			.rst(rst),
			.out(out)
	);
	
	always #1 clk =~clk;		
	initial begin
		clk = 0;
		rst = 1;
		#5 rst = 0;
		#10_000_000 $stop;
	end

endmodule
