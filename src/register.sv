module register (
	input logic clk,
	input logic [8:0] D,
	input logic load,
	output reg [8:0] Q
);

	always @(posedge clk) begin
		if (load)
			Q <= D;
	end

endmodule : register
