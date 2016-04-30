module alu(out_address, out_branch, a, b, ALUctrl); // selector seems to be "EX" from "ID/EX" pipeline register
input [31:0] a,b; //a is read data 1, b is output a from Mux2
input [1:0] ALUctrl;
output out_branch;
output [31:0] out_address; 
wire signed [31:0] a,b;
reg signed [31:0] out_address;
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