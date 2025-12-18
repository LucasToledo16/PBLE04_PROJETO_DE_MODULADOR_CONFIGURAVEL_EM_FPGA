`timescale 10ns/1ns // 50MHz (#1 clk =~clk)
module MUX_4ASK_tb;

	reg carrier1;
	reg carrier2;
	reg carrier3;
	reg carrier4;
	reg [1:0] sel;
	wire out;

	MUX_4ASK u0(
		.carrier1(carrier1),
		.carrier2(carrier2),
		.carrier3(carrier3),
		.carrier4(carrier4),
		.sel(sel),
		.out(out)
	);
	
	always #1 carrier1=~carrier1;
	always #2 carrier2=~carrier2;
	always #4 carrier3=~carrier3;
	always #8 carrier4=~carrier4;
	always #16 sel[0]=~sel[0];
	always #32 sel[1]=~sel[1];
	
	initial begin
		carrier1 <= 0;
		carrier2 <= 0;
		carrier3 <= 0;
		carrier4 <= 0;
		sel <= 0;
		#100 $stop;
	end

endmodule