module Main
(
	input clk,
	input rst,
	input ADC_read,
	input out_env_detect,
	output out_PWM,
	output clk_ADC,
	output cs_ADC,
	output out_serial,
	output [7:0] out_parallel,
	output out_BASK,
	output out_DEMOD,
	output out_4ASK
);

	wire NEW_BYTE;

	PWM u0(.clk(clk),.rst(rst),.out(out_PWM));
	ADC_manager u1(.clk(clk),.rst(rst),.ADC_read(ADC_read),.NEW_BYTE(NEW_BYTE),.clk_out(clk_ADC),.cs_out(cs_ADC),.out_serial(out_serial),.out_parallel(out_parallel));
	BASK u2(.clk(clk),.rst(rst),.sel(out_serial),.modulated(out_BASK));
	DEMOD u3(.clk(clk),.rst(rst),.NEW_BYTE(NEW_BYTE),.signal(out_env_detect),.out(out_DEMOD));
	
	//4-ASK
	Four_ASK u4(.clk(clk),.rst(rst),.message(out_serial),.modulated(out_4ASK));
	
endmodule