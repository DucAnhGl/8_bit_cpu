module AU (
	input logic [8:0] A_in,
	input logic [8:0] B_in,
	input logic AddSub,
	output logic [8:0] result
);

	always @(*) begin
		case (AddSub)
			1'b0: result = A_in + B_in;
			1'b1: result = A_in - B_in;
			default: result = A_in + B_in;
		endcase
	end

endmodule : AU
