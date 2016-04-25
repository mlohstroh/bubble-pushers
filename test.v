module testingIF (clk, rst, ctrl, instr);
	input  rst, clk, ctrl ; //declaring inputs, outputs, and wires (to handle information exchange between modules)
	output [31:0] instr ;
	reg [31:0] instr;
	wire [31:0] newpc;
	wire [31:0] currentpc;
	wire [31:0] instrout;
	wire [31:0] muxin;
	reg [31:0] branch;
	
	initial branch = 32'b00000000000000000000000000000000; //stand in for branch


	addfour PCadd(currentpc, muxin); //all components, wired together
	Multiplexor mux(muxin, branch, ctrl, newpc);
	ProgramCounter PC(clk, newpc, currentpc, rst);
	InstrMemory IMEM(currentpc, instrout);
	
	
	always @(*) //output assignment
		instr = instrout;
endmodule