module IDphase(clk, instr, fetchPc4, opcode, funct);
	input clk;
	input instr[31:0];
	input fetchPc4[31:0]

	output opcode[5:0];
	output funct[5:0];
	
	wire [4:0] regRs, regRt, regRd;
	wire [31:0] pc4;
	wire [31:0] regOut1, regOut2;
	wire [31:0] immValue, branchAddr, pcMuxOut, jumpDest;

	assign regRs[4:0] = instr[25:21];
	assign regRt[4:0] = instr[20:16];
	assign regRd[4:0] = instr[15:11];
	assign immValue[15:0] = instr[15:0]; 
	assign immValue[31:16] = instr[15];
	//assign branchAddr[31:0] = (immValue << 2) + pc4;
	assign jumpDest[31:28] = fetchPc4[31:28];
	assign jumpDest[27:2] = instr[25:0]
	assign jumpDest [1:0] = 0;
	assign opcode[5:0] = instr[31:26];
	assign funct[5:0] = instr[5:0];

endmodule
