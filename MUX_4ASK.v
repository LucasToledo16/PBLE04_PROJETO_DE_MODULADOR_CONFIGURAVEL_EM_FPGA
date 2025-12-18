module MUX_4ASK
(
	input carrier1,
	input carrier2,
	input carrier3,
	input carrier4,
	input [1:0] sel,
	output out
);
	// Selection chart:
	//		00 -> carrier 1
	//		01 -> carrier 2
	//		10 -> carrier 3
	//		11 -> carrier 4
	assign out = sel[1] ? (sel[0] ? carrier4 : carrier3):(sel[0] ? carrier2 : carrier1);
	
endmodule