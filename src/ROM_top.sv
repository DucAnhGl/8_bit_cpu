module ROM_top (
	input logic clk,
	input logic rst,
	output logic [8:0] q
);

	wire [4:0] wire1;
	
	counter counter1 (
		.clk (clk),
		.rst (rst),
		.out (wire1)
	);

	ROM ROM1 (
		.addr (wire1),
		.clk (clk),
		.q (q)
	);

endmodule : ROM_top
