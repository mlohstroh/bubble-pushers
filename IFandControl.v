
module testingIFandControl (clk, rst, mem_to_reg, mem_write, branch, alu_ctrl, alu_src, reg_dst, reg_write);
	input  rst, clk; //declaring inputs, outputs, and wires (to handle information exchange between modules)
	wire [31:0] newpc;
	wire [31:0] currentpc;
	wire [31:0] instrout;
	wire [31:0] muxin;
 	output [0:0] mem_to_reg, mem_write, branch, alu_src, reg_dst, reg_write;
 	output [2:0] alu_ctrl;

  	reg [0:0] mem_to_regr, mem_writer, branchr, alu_srcr, reg_dstr, reg_writer;
  	reg [2:0] alu_ctrlr;
	reg [31:0] brch;
	
	initial brch = 32'b00000000000000000000000000000000; //stand in for branch


	addfour PCadd(currentpc, muxin); //all components, wired together
	Multiplexor mux(muxin, brch, branch, newpc);
	ProgramCounter PC(clk, newpc, currentpc, rst);
	InstrMemory IMEM(currentpc, instrout);
	control AssumingDirect(instrout[31:26], instrout[5:0], mem_to_reg, mem_write, branch, alu_ctrl, alu_src, reg_dst, reg_write);
	

endmodule