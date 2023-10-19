module mux (
	input logic [7:0] Rout,
	input logic Gout,
	input logic DINout,
	input logic Bout,
	input logic Fout, 
	input logic [8:0] R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in,	
	input logic [8:0] DIN,
	input logic [8:0] G,
	input logic [8:0] B,
	input logic [8:0] F,
	output logic [8:0] mux_out
);

	parameter	r7 = 8'b10000000,
				r6 = 8'b01000000,
				r5 = 8'b00100000,
				r4 = 8'b00010000,
				r3 = 8'b00001000,
				r2 = 8'b00000100,
				r1 = 8'b00000010,
				r0 = 8'b00000001;
	logic [11:0] sel;
	assign sel = {Rout, Gout, DINout, Bout, Fout};

	always @(*) begin
		case (sel)
			{r7,1'b0, 1'b0, 1'b0, 1'b0}: mux_out = R7in;
			{r6,1'b0, 1'b0, 1'b0, 1'b0}: mux_out = R6in;
			{r5,1'b0, 1'b0, 1'b0, 1'b0}: mux_out = R5in;
			{r4,1'b0, 1'b0, 1'b0, 1'b0}: mux_out = R4in;
			{r3,1'b0, 1'b0, 1'b0, 1'b0}: mux_out = R3in;
			{r2,1'b0, 1'b0, 1'b0, 1'b0}: mux_out = R2in;
			{r1,1'b0, 1'b0, 1'b0, 1'b0}: mux_out = R1in;
			{r0,1'b0, 1'b0, 1'b0, 1'b0}: mux_out = R0in;
			12'b000000001000: mux_out = G;
			12'b000000000100: mux_out = DIN;
			12'b000000000010: mux_out = B;
			12'b000000000001: mux_out = F;
			default: mux_out = R0in;			
		endcase
	end						  

endmodule : mux
