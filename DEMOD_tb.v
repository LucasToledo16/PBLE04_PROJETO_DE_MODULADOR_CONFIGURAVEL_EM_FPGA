`timescale 10ns/1ns // 50MHz (#1 clk =~clk)
module DEMOD_tb;

	reg clk;
	reg rst;
	reg NEW_BYTE;
	reg signal;
	wire out;

	DEMOD u0(
		.clk(clk),
		.rst(rst),
		.NEW_BYTE(NEW_BYTE),
		.signal(signal),
		.out(out)
	);	

	reg clk2; 
	reg vector [127:0];
	
	always #1 clk =~clk; // freq = 50MHz
	always #25000 clk2 =~clk2;	// freq = 2kHz
	initial begin
		$readmemb("testbench_DEMOD.txt",vector);
		clk <= 0;
		clk2 <= 0;
		rst <= 0;
		#3 rst <= 1;
		#3 rst <= 0;
		#5_000_000 $stop;
	end
	
	integer i = 0;
	always @ (posedge clk2) begin
		signal <= vector[i];
		if (!(i % 8)) begin
			NEW_BYTE <= 1;
		end else begin
			NEW_BYTE <= 0;
		end
		i = i + 1; // Update
	end
	
endmodule