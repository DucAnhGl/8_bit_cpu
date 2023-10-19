module counter (
	input logic clk,
	input logic rst,
	output logic [4:0] out
);

	always@(posedge clk or posedge rst)
	begin
		if (rst)
			out = 5'b00000;
		else if (out == 5'b11111)
			out = 5'b00000;
		else out++;
	end

endmodule: counter
