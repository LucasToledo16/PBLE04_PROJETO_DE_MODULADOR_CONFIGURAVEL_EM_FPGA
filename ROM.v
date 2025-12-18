// Single Port ROM

module ROM
#(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=8, parameter DATA_MEM=1)
(
	input clk, 
	input [(ADDR_WIDTH-1):0] addr,
	output reg [(DATA_WIDTH-1):0] q
);

	// Declare the ROM variable
	reg [DATA_WIDTH-1:0] mem[2**ADDR_WIDTH-1:0];

	// Initialize the ROM with $readmemb.  Put the memory contents
	// in the file single_port_rom_init.txt.  Without this file,
	// this design will not compile.

	// See Verilog LRM 1364-2001 Section 17.2.8 for details on the
	// format of this file, or see the "Using $readmemb and $readmemh"
	// template later in this section.

	initial
	begin
		// synthesis translate_off
		//$readmemb($sformatf("mem%0d.txt",DATA_MEM), mem);
		// synthesis translate_on
		$readmemb("mem1.txt", mem);
	end

	always @ (posedge clk)
	begin
		q <= mem[addr];
	end

endmodule
