module incrementCounter (pcprev, newpc); //increments value from PC counter to next instruction
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

module InstrMemory(addr, out);
	input [31:0] addr;
	output [31:0] out;
	reg [31:0] out;
	reg[31:0] mem [0:1000]; //hard coded to 1000 elements, just for simplicity's sake

	initial $readmemb("prog2.bin",mem); //reading in memory

	always @(*) //output the memory at the desired address
		out = mem[addr];
endmodule

	
