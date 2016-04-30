module addfour (pcprev, newpc); //increments value from PC counter by 4
	input [31:0] pcprev; //setting up inputs and outputs
	reg [31:0] newpcreg;
	output [31:0] newpc;

	always@ (pcprev) begin //whenever pcprev changes, do the following
		assign newpcreg = pcprev + 1; //add 1 to pcprev and assign that value as the output, as memory is an array of 32 bit elements
	end

	assign newpc = newpcreg; //assigning actual output
 
endmodule

module ProgramCounter(clk, in, out, rst); //keeps track of the current address in I-mem
	input clk; //clock as input
	input rst; //reset value
	input [31:0] in; //in as input
	output [31:0] out; //out as output
	reg signed [31:0] out;//out register

	always @(posedge clk)//run when at clock positive edge
		out = rst ? 32'b00000000000000000000000000000000 : in ; // reset state	
endmodule

module Multiplexor(in0, in1, select, out);
	input [31:0] in0, in1; //assigning inputs and outputs
	input select;
	output [31:0] out;
	reg [31:0] out;

	always@(*) //always output the choice from select
		out = select ? in1 : in0 ;
endmodule

module InstrMemory(addr, out);
	input [31:0] addr;
	output [31:0] out;
	reg [31:0] out;
	reg[31:0] mem [0:1000]; //hard coded to 1000 elements, just for simplicity's sake

	initial $readmemb("prog2.bin",mem); //reading in memory

	always @(*) //output the memory at the desired address
		out = mem[addr];
endmodule

	
