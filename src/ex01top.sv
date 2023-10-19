module ex01top (
	input logic clk,
	input logic reset, run,
	input logic [8:0] DIN,
	output logic [8:0] bus1,
	output logic [8:0] R7, R6, R5, R4, R3, R2, R1, R0,
	output logic Done
);

	wire [8:0] r02mux, r12mux, r22mux, r32mux, r42mux, r52mux, r62mux, r72mux;
	wire [7:0] Rout;
	wire [8:0] bus, A2addsub, addsub2G, G2mux, IRout, incdec2B, C2faddsub, B2mux, F2mux, faddsub2F;
	wire [7:0] rin;
	wire Ain, Gout, Gin, IRin, DINout, AddSub, Bin, Bout, incdec, Fout, Fin, sel, Cin;

	register register0(
		.clk (clk),
		.D (bus),
		.load (rin[0]),
		.Q (r02mux)	
	);

	register register1(
		.clk (clk),
		.D (bus),
		.load (rin[1]),
		.Q (r12mux)
	);

	register register2(
		.clk (clk),
		.D (bus),
		.load (rin[2]),
		.Q (r22mux)
	);

	register register3(
		.clk (clk),
		.D (bus),
		.load (rin[3]),
		.Q (r32mux)
	);

	register register4(
		.clk (clk),
		.D (bus),
		.load (rin[4]),
		.Q (r42mux)
	);

	register register5(
		.clk (clk),
		.D (bus),
		.load (rin[5]),
		.Q (r52mux)
	);

	register register6(
		.clk (clk),
		.D (bus),
		.load (rin[6]),
		.Q (r62mux)
	);

	register register7(
		.clk (clk),
		.D (bus),
		.load (rin[7]),
		.Q (r72mux)
	);

	register regA (
		.clk (clk),
		.D (bus),
		.load (Ain),
		.Q (A2addsub)
	);

	register regG (
		.clk (clk),
		.D (addsub2G),
		.load (Gin),
		.Q (G2mux)
	);

	register regB (
		.clk (clk),
		.D (incdec2B),
		.load (Bin),
		.Q (B2mux)
	);

	register regC (
		.clk (clk),
		.D (bus),
		.load (Cin),
		.Q (C2faddsub)
	);

	register regF (
		.clk (clk),
		.D (faddsub2F),
		.load (Fin),
		.Q (F2mux)
	);

	register IR (
		.clk (clk),
		.D (DIN),
		.load (IRin),
		.Q (IRout)
	);

	mux mux1 (
		.DINout (DINout),
		.Gout (Gout),
		.G (G2mux),
		
		.Rout (Rout),
		.DIN (DIN),
		.B (B2mux),
		.Bout (Bout),
		.F (F2mux),
		.Fout (Fout),
		.R0in (r02mux),
		.R1in (r12mux),
		.R2in (r22mux),
		.R3in (r32mux),
		.R4in (r42mux),
		.R5in (r52mux),
		.R6in (r62mux),
		.R7in (r72mux),
		.mux_out (bus)	
	);

	AU AU1 (
		.A_in (A2addsub),
		.B_in (bus),
		.AddSub (AddSub),
		.result (addsub2G)
	);

	incdec incdec1 (
		.A (bus),
		.sel (incdec),
		.out (incdec2B)
	);

	faddsub faddsub1 (
		.a_9 (C2faddsub),
		.b_9 (bus),
		.sel (sel),
		.result_9 (faddsub2F)
	);

	fsm fsm1 (
		.clk (clk),
		.IR (IRout),
		.run (run),
		.reset (reset),
		.Rout (Rout),
		.Rin (rin),
		.IRin (IRin),
		.DINout (DINout),
		.Ain (Ain),
		.AddSub (AddSub),
		.Gout (Gout),
		.Gin (Gin),
		.incdec (incdec),
		.Bin (Bin),
		.Bout (Bout),
		.Fout (Fout),
		.sel (sel),
		.Cin (Cin),
		.Fin (Fin),
		.Done (Done)
	);

	assign bus1 = bus;
	assign R0 = r02mux;
	assign R1 = r12mux;
	assign R2 = r22mux;
	assign R3 = r32mux;
	assign R4 = r42mux;
	assign R5 = r52mux;
	assign R6 = r62mux;
	assign R7 = r72mux;
		

endmodule : ex01top
