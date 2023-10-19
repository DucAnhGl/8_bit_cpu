module decoder (
	input logic [2:0] A_in,
	output logic [7:0] A_out
);

	always @(*) begin
		case (A_in)
			3'b000: A_out = 8'b00000001;
			3'b001: A_out = 8'b00000010;
			3'b010: A_out = 8'b00000100;
			3'b011: A_out = 8'b00001000;
			3'b100: A_out = 8'b00010000;
			3'b101: A_out = 8'b00100000;
			3'b110: A_out = 8'b01000000;
			3'b111: A_out = 8'b10000000;		
		endcase
	end

endmodule : decoder
