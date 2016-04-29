
//----------------------------------------------------------------------
module adder(in1, in2, adder_out);
	input [31:0] in1, in2; 
	output [31:0] adder_out;

	assign adder_out = in1 + in2;
endmodule

//----------------------------------------------------------------------

module alu(out_address, out_branch, a, b, ALUctrl); // selector seems to be "EX" from "ID/EX" pipeline register
input [31:0] a,b;
input [1:0] ALUctrl;
output out_branch;
output [31:0] out_address; 
reg [31:0] out_address;
reg out_branch; 

always@(*)
	begin
		case(ALUctrl)
		2'b00: begin
			if(a == b) begin
				out_branch = 1;
				out_address = 0;
			end
		end

		2'b01: begin
		 out_address = a+b ;
		 out_branch = 0;
		end

		2'b10: begin
		out_address = a-b;
		out_branch = 0;
		end 

		endcase
	end
endmodule

//----------------------------------------------------------------------
module Mux1(a0, a1, RegDst, b);
	input [4:0] a0, a1; // inputs
	input RegDst; //select
	output [4:0] b;
	reg [4:0] b;


	always @(*)
		begin
			case(RegDst)
				1'b0: b=a0;
				1'b1: b=a1;
			endcase
		end
endmodule

//----------------------------------------------------------------------
module Mux2(b0, b1, ALUSrc, a);
	input [31:0] b0, b1; // inputs
	input ALUSrc; //select
	output [31:0] a;
	reg [31:0] a;

	always @(*)
		begin
			case(ALUSrc)
				1'b0: a=b0;
				1'b1: a=b1;
			endcase
		end
endmodule

//----------------------------------------------------------------------
module shiftLeftTwo(in, shiftedNUM);
input [31:0] in;
output [31:0] shiftedNUM;
reg [31:0] shiftedNUM;

always @(*)
	begin
		shiftedNUM = in <<< 2;
	end
endmodule

//----------------------------------------------------------------------