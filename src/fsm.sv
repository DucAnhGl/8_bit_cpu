module fsm (
	input logic clk,
	input logic [8:0] IR,
	input logic run, reset,
	output logic IRin, Gout, Bout, DINout, Ain, AddSub, incdec, sel, Gin, Bin, Cin, Fin, Fout,
	output logic [7:0] Rout,
	output logic [7:0] Rin,
	output logic Done
);

	reg [4:0] state, next_state;
	
	reg [7:0] Ry;
	reg [7:0] Rx;

	decoder decoder1 (
		.A_in (IR[5:3]),
		.A_out (Rx)
	);

	decoder decoder2 (
		.A_in (IR[2:0]),
		.A_out (Ry)
	);

	parameter	s0 = 5'b00000,
				s1 = 5'b00001,
				s2 = 5'b00010,
				s3 = 5'b00011,
				s4 = 5'b00100,
				s5 = 5'b00101,
				s6 = 5'b00110,
				s7 = 5'b00111,
				s8 = 5'b01000,
				s9 = 5'b01001,
				s10= 5'b01010,
				s11= 5'b01011,
				s12= 5'b01100,
				s13= 5'b01101,
				s14= 5'b01110,
				s15= 5'b01111,
				s16= 5'b10000,
				s17= 5'b10001,
				s18= 5'b10010,
				s19= 5'b10011,
				s20= 5'b10100;

//Current state register
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= s0;
		else 
			state <= next_state;
	end

//Next state combinational logic
	always @(state or IR or run) begin
		case (state)
			s0 : if (run)
					next_state = s1;
				else next_state = s0; 
			s1 : next_state = s2;
			s2 :
				if (IR[8:6] == 3'b000)
					next_state = s3;
				else if (IR[8:6] == 3'b001)
					next_state = s4;
				else if (IR[8:6] == 3'b010)
					next_state = s5;
				else if (IR[8:6] == 3'b011)
					next_state = s8;
				else if (IR[8:6] == 3'b100)
					next_state = s11;
				else if (IR[8:6] == 3'b101)
					next_state = s13;
				else if (IR[8:6] == 3'b110)
					next_state = s15;
				else if (IR[8:6] == 3'b111)
					next_state = s18;
				else 
					next_state = s0;
			s3: next_state = s0;
			s4: next_state = s0;
			s5: next_state = s6;
			s6: next_state = s7;
			s7: next_state = s0;
			s8: next_state = s9;
			s9: next_state = s10;
			s10: next_state = s0;
			s11: next_state = s12;
			s12: next_state = s0;
			s13: next_state = s14;
			s14: next_state = s0;
			s15: next_state = s16;
			s16: next_state = s17;
			s17: next_state = s0;
			s18: next_state = s19;
			s19: next_state = s20;
			s20: next_state = s0;
			default: next_state = s0;
		endcase
	end 

//Output combinational logic 
	always @(state) begin
		case (state)
			s0: begin
					IRin=1'b0; Rout=8'b00000000; Gout=1'b0; DINout=1'b0; Rin=8'b00000000;
					Ain=1'b0; AddSub=1'b0; Gin=1'b0; Done=1'b1; Bout=1'b0; Bin=1'b0; incdec=1'b0;
					Cin=1'b0; Fin=1'b0; Fout=1'b0; sel=1'b0;
				end

			s1: begin
					IRin=1'b1; Rout=8'b00000000; Gout=1'b0; DINout=1'b0; Rin=8'b00000000;
					Ain=1'b0; AddSub=1'b0; Gin=1'b0; Done=1'b0; Bout=1'b0; Bin=1'b0; incdec=1'b0;
					Cin=1'b0; Fin=1'b0; Fout=1'b0; sel=1'b0;
				end
				
			s2: begin
					IRin=1'b0; Rout=8'b00000000; Gout=1'b0; DINout=1'b0; Rin=8'b00000000;
					Ain=1'b0; AddSub=1'b0; Gin=1'b0; Done=1'b0; Bout=1'b0; Bin=1'b0; incdec=1'b0;
					Cin=1'b0; Fin=1'b0; Fout=1'b0; sel=1'b0;
				end

			s3: begin
					IRin=1'b1; Rout=Ry; Gout=1'b0; DINout=1'b0; Rin=Rx;
					Ain=1'b0; AddSub=1'b0; Gin=1'b0; Done=1'b0; Bout=1'b0; Bin=1'b0; incdec=1'b0;
					Cin=1'b0; Fin=1'b0; Fout=1'b0; sel=1'b0;
				end
				
			s4: begin
					IRin=1'b0; Rout=8'b00000000; Gout=1'b0; DINout=1'b1; Rin=Rx;
					Ain=1'b0; AddSub=1'b0; Gin=1'b0; Done=1'b0; Bout=1'b0; Bin=1'b0; incdec=1'b0;
					Cin=1'b0; Fin=1'b0; Fout=1'b0; sel=1'b0;
				end

			s5: begin
					IRin=1'b0; Rout=Rx; Gout=1'b0; DINout=1'b0; Rin=8'b00000000;
					Ain=1'b1; AddSub=1'b0; Gin=1'b0; Done=1'b0; Bout=1'b0; Bin=1'b0; incdec=1'b0;
					Cin=1'b0; Fin=1'b0; Fout=1'b0; sel=1'b0;
				end

			s6: begin 
					IRin=1'b0; Rout=Ry; Gout=1'b0; DINout=1'b0; Rin=8'b00000000;
					Ain=1'b0; AddSub=1'b0; Gin=1'b1; Done=1'b0;Bout=1'b0; Bin=1'b0; incdec=1'b0;
					Cin=1'b0; Fin=1'b0; Fout=1'b0; sel=1'b0;
				end

			s7: begin
					IRin=1'b0; Rout=8'b00000000; Gout=1'b1; DINout=1'b0; Rin=Rx;
					Ain=1'b0; AddSub=1'b0; Gin=1'b0; Done=1'b0; Bout=1'b0; Bin=1'b0; incdec=1'b0;
					Cin=1'b0; Fin=1'b0; Fout=1'b0; sel=1'b0;			
				end

			s8: begin
					IRin=1'b0; Rout=Rx; Gout=1'b0; DINout=1'b0; Rin=8'b00000000;
					Ain=1'b1; AddSub=1'b0; Gin=1'b0; Done=1'b0; Bout=1'b0; Bin=1'b0; incdec=1'b0;
					Cin=1'b0; Fin=1'b0; Fout=1'b0; sel=1'b0;
				end

			s9: begin
					IRin=1'b0; Rout=Ry; Gout=1'b0; DINout=1'b0; Rin=8'b00000000;
					Ain=1'b0; AddSub=1'b1; Gin=1'b1; Done=1'b0; Bout=1'b0; Bin=1'b0; incdec=1'b0;
					Cin=1'b0; Fin=1'b0; Fout=1'b0; sel=1'b0;
				end

			s10: begin
					IRin=1'b0; Rout=8'b00000000; Gout=1'b1; DINout=1'b0; Rin=Rx;
					Ain=1'b0; AddSub=1'b0; Gin=1'b0; Done=1'b0; Bout=1'b0; Bin=1'b0; incdec=1'b0;
					Cin=1'b0; Fin=1'b0; Fout=1'b0; sel=1'b0;
				end

			s11: begin
					IRin=1'b0; Rout=Rx; Gout=1'b0; DINout=1'b0; Rin=8'b00000000;
					Ain=1'b0; AddSub=1'b0; Gin=1'b0; Done=1'b0; Bout=1'b0; Bin=1'b1; incdec=1'b0;
					Cin=1'b0; Fin=1'b0; Fout=1'b0; sel=1'b0;
				end

			s12: begin
					IRin=1'b0; Rout=8'b00000000; Gout=1'b0; DINout=1'b0; Rin=Rx;
					Ain=1'b0; AddSub=1'b0; Gin=1'b0; Done=1'b0; Bout=1'b1; Bin=1'b0; incdec=1'b0;
					Cin=1'b0; Fin=1'b0; Fout=1'b0; sel=1'b0;
				end

			s13: begin
					IRin=1'b0; Rout=Rx; Gout=1'b0; DINout=1'b0; Rin=8'b00000000;
					Ain=1'b0; AddSub=1'b0; Gin=1'b0; Done=1'b0; Bout=1'b0; Bin=1'b1; incdec=1'b1;
					Cin=1'b0; Fin=1'b0; Fout=1'b0; sel=1'b0;
				end

			s14: begin
					IRin=1'b0; Rout=8'b00000000; Gout=1'b0; DINout=1'b0; Rin=Rx;
					Ain=1'b0; AddSub=1'b0; Gin=1'b0; Done=1'b0; Bout=1'b1; Bin=1'b0; incdec=1'b0;
					Cin=1'b0; Fin=1'b0; Fout=1'b0; sel=1'b0;
				end

			s15: begin
					IRin=1'b0; Rout=Rx; Gout=1'b0; DINout=1'b0; Rin=8'b00000000;
					Ain=1'b0; AddSub=1'b0; Gin=1'b0; Done=1'b0; Bout=1'b0; Bin=1'b0; incdec=1'b0;
					Cin=1'b1; Fin=1'b0; Fout=1'b0; sel=1'b0;
				end

			s16: begin
					IRin=1'b0; Rout=Ry; Gout=1'b0; DINout=1'b0; Rin=8'b00000000;
					Ain=1'b0; AddSub=1'b0; Gin=1'b0; Done=1'b0; Bout=1'b0; Bin=1'b0; incdec=1'b0;
					Cin=1'b0; Fin=1'b1; Fout=1'b0; sel=1'b0;
				end
				
			s17: begin
					IRin=1'b0; Rout=8'b00000000; Gout=1'b0; DINout=1'b0; Rin=Rx;
					Ain=1'b0; AddSub=1'b0; Gin=1'b0; Done=1'b0; Bout=1'b0; Bin=1'b0; incdec=1'b0;
					Cin=1'b0; Fin=1'b0; Fout=1'b1; sel=1'b0;
				end

			s18: begin
					IRin=1'b0; Rout=Rx; Gout=1'b0; DINout=1'b0; Rin=8'b00000000;
					Ain=1'b0; AddSub=1'b0; Gin=1'b0; Done=1'b0; Bout=1'b0; Bin=1'b0; incdec=1'b0;
					Cin=1'b1; Fin=1'b0; Fout=1'b0; sel=1'b0;
				end

			s19: begin
					IRin=1'b0; Rout=Ry; Gout=1'b0; DINout=1'b0; Rin=8'b00000000;
					Ain=1'b0; AddSub=1'b0; Gin=1'b0; Done=1'b0; Bout=1'b0; Bin=1'b0; incdec=1'b0;
					Cin=1'b0; Fin=1'b1; Fout=1'b0; sel=1'b1;
				end

			s20: begin
					IRin=1'b0; Rout=8'b00000000; Gout=1'b0; DINout=1'b0; Rin=Rx;
					Ain=1'b0; AddSub=1'b0; Gin=1'b0; Done=1'b0; Bout=1'b0; Bin=1'b0; incdec=1'b0;
					Cin=1'b0; Fin=1'b0; Fout=1'b1; sel=1'b0;
				end

			default: begin
					IRin=1'b0; Rout=8'b00000000; Gout=1'b0; DINout=1'b0; Rin=8'b00000000;
					Ain=1'b0; AddSub=1'b0; Gin=1'b0; Done=1'b0; Bout=1'b0; Bin=1'b0; incdec=1'b0;
					Cin=1'b0; Fin=1'b0; Fout=1'b0; sel=1'b0;
				end
		endcase
	end

endmodule : fsm
