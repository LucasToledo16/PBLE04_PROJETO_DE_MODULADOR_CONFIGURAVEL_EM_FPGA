// Multiplexer - BASK Modulator

module MUX_BASK
(
	input carrier1, // Square wave 100kHz
	input carrier2, // Zero signal
	input sel, // Modulating signal (ADC read)
	output out // Modulated signal OOK (BASK before Band Pass filtering), out ? sel carrier1 : carrier2
);

	assign out = sel ? carrier1 : carrier2;
	
endmodule