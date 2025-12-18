`timescale 10ns/1ns // 50MHz (#1 clk =~clk)
module Four_ASK_tb;

	reg clk;
	reg rst;
	reg message;
	wire modulated;
	
	Four_ASK u0(
		.clk(clk),
		.rst(rst),
		.message(message),
		.modulated(modulated)
	);
	
	reg vector [127:0];
	reg clk2; // freq = 2kHz
	
	always #1 clk =~clk;	
	always #25000 clk2 =~clk2;	
	initial begin
		$readmemb("testbench_Acq_hold.txt",vector);
		clk <= 0;
		clk2 <= 0;
		rst <= 0;
		#3 rst <= 1;
		#3 rst <= 0;
		#100_000_000 $stop;
	end
	
	integer i = 0;
	always @ (posedge clk2) begin
		#10000
		message <= vector[i];
		i = i + 1;
	end
	
endmodule