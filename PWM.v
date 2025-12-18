module PWM
(
	input clk,
	input rst,
	output out
);
	//wire [ADDR_WIDTH_signal-1:0] addr_signal;
	//wire [DATA_WIDTH-1:0] data_signal, data_ramp;
	//wire clk_div;
	
	localparam FpgaClk = 50e6;
	localparam SamplingFrequency = 200;
	localparam databits = 8;	
	localparam SawFreq = (SamplingFrequency << databits);
	localparam addr_width = 8;
	
	
	wire slowclock,fastclock;
	wire [(addr_width-1):0] address;
	wire [(databits-1):0] sawtooth;
	wire [(databits-1):0] regsawout;
	wire [(databits-1):0] data_signal;
	
	//Freq_div u0(.clk(clk),.rst(rst),.clk_div(clk_div));
	
		divider #(
		.InputClkFreq(50e6),
		.OutputClkFreq(51200)
		)CLDV3(
		.CLOCK_50(clk),
		.Rst(Rst),
		.ClkDiv(fastclock)
		);
		
		divider #(
		.InputClkFreq(50e6),
		.OutputClkFreq(200)
		)CLDV4(
		.CLOCK_50(clk),
		.Rst(Rst),
		.ClkDiv(slowclock)
		);
		
	//Counter u1(.clk(fastclock),.rst(rst),.count(addr_signal));
	ROM u2(.clk(slowclock),.addr(address),.q(data_signal)); 
	
	count #(
		.WIDTH(databits),
		.MAX_VALUE(1 << databits)
		)CNT2(
		.clk(fastclock),
		.rst(Rst),
		.count(sawtooth)
		);
		
count #(
		.WIDTH(addr_width),
		.MAX_VALUE(199) //199
		)CNT1(
		.clk(slowclock),
		.rst(Rst),
		.count(address)
		);
	
register #(
		.databits(databits)
		)REG1(
		.Clk(fastclock),
		.Rst(Rst),
		.In(sawtooth),
		.Out(regsawout)
		);	
		
Comparator
(
	 .clk(fastclock),
	 .in1(data_signal),
	 .in2(regsawout),
	 .out(out)// in1>=in2 -> 1, in1<in2 -> 0
);
		
	//Counter #(.WIDTH(4),.max_count(10)) u2(.clk(clk_div),.rst(rst),.count(addr_ramp));
	//ROM #(.ADDR_WIDTH(4),.DATA_MEM(2)) u4(.clk(clk_div),.addr(addr_ramp),.q(data_ramp)); // Rampa
	
endmodule


module count #(
    parameter WIDTH = 8,           // Largura do contador em bits
    parameter MAX_VALUE = 201      // Valor mÃ¡ximo de contagem
) (
    input clk,
    input rst,
    output reg [WIDTH-1:0] count
);

    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            count <= 0;
        end
		  else if (count == (MAX_VALUE-1)) count <= 0;
        else begin
            count <= count + 1;
        end
    end
    
endmodule