module if_phase (clk, rst, branch_address, branch_ctrl, jump_address, jump_ctrl, instr, pc);
	input  rst, clk, branch_ctrl, jump_ctrl; //declaring inputs, outputs, and wires (to handle information exchange between modules)
	input [31:0] branch_address, jump_address;
	output [31:0] instr, pc;

	reg [31:0] instr;
	wire signed [31:0] newpc;
	wire [31:0] instrout;
	wire [31:0] muxin;
	wire [31:0] branchOrNext;
	wire [31:0] nextPCAddress;
	wire branch_ctrl, jump_ctrl;
	reg [31:0] branch;
	wire signed [31:0] pc;

	// increment the PC whenver the pc changes
	incrementCounter PCadd(pc, muxin);
	// muxes - one for the branch
	mux #(32) mux_branch(muxin, branch_address, branch_ctrl, branchOrNext);
	// and the other for the specific jump
	mux #(32) mux_jump(branchOrNext, jump_address, jump_ctrl, nextPCAddress);

	// get the next instruction
	ProgramCounter PC(clk, nextPCAddress, pc, rst);
	InstrMemory IMEM(pc, instrout);
	
	always @(*) //output assignment
		instr = instrout;
endmodule