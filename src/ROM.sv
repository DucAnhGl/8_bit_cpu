module ROM
#(parameter data_width=9, parameter addr_width=5)
(
	input [(addr_width-1):0] addr,
	input clk, 
	output reg [(data_width-1):0] q
);
	reg [data_width-1:0] rom[2**addr_width-1:0];

	initial // Read the memory contents in the file 
	begin
		$readmemb("intfile.txt", rom);
	end

	always@(posedge clk)
	begin
		q <= rom[addr];
	end
endmodule