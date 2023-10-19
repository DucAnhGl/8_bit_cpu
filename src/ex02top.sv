module ex02top (
	input logic clk1,
	input logic clk2,
	input logic rstcounter,
	input logic reset,
	input logic run,
	output logic [8:0] data,
	output logic [8:0] bus,
	output logic [8:0] R7, R6, R5, R4, R3, R2, R1, R0,
	output logic Done
);

	reg [8:0] wire1;
	assign data = wire1; 

	ex01top ex01_1 (
		.clk (clk1),
		.reset (reset),
		.run (run),
		.DIN (wire1),
		.bus1 (bus),
		.R7 (R7),
		.R6 (R6),
		.R5 (R5),
		.R4 (R4),
		.R3 (R3),
		.R2 (R2),
		.R1 (R1),
		.R0 (R0),
		.Done (Done)
	);

	ROM_top ROM_top1 (
		.clk (clk2),
		.rst (rstcounter),
		.q (wire1)
	);

endmodule : ex02top
