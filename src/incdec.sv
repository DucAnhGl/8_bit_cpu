module incdec(
	input logic [8:0] A,
	input logic sel,
	output logic [8:0] out
);

	always @(*) begin
		case (sel)
			1'b0: out = A + 9'b000000001;
			1'b1: out = A - 9'b000000001;
			default: out = A + 9'b000000001; 
		endcase
	end
	
endmodule : incdec
