module InstrDecod(clk, instr, PC_4, opcode, funct, regWrite);
	input clk;
	input instr[31:0];  	//from Instruction Fetch
	input PC_4[31:0];	//from Instruction Fetch
	input regWrite;		//from Control
	

	output opcode[5:0];	//sent to Control
	output funct[5:0];	//sent to ALU Control
	output regOut1[31:0];	//sent to Exe(Read data 1)
	output regOut2[31:0];	//sent to Exe(Read data 2)
	output regRt[4:0];	//sent to Exe Mux(RegDst = 0)
	output regRd[4:0];	//sent to Exe Mux(RegDst = 1)
	output jumpDest[31:0];	//sent for Jump address

	wire [4:0] regRs, regRt, regRd;
	wire [31:0] pc4;
	wire [31:0] regOut1, regOut2;
	wire [31:0] immValue, branchAddr, jumpDest;
	
	assign opcode[5:0] = instr[31:26];
	assign funct[5:0] = instr[5:0];
	assign regRs[4:0] = instr[25:21];
	assign regRt[4:0] = instr[20:16];
	assign regRd[4:0] = instr[15:11];
	assign immValue[15:0] = instr[15:0]; 
	assign immValue[31:16] = instr[15];
	assign jumpDest[31:28] = PC_4[31:28];
	assign jumpDest[27:2] = instr[25:0]
	assign jumpDest [1:0] = 0;
	assign regOut1[4:0] = regRs[4:0];
	assign regOut1[31:5] = regRs[4];
	assign regOut2[4:0] = regRd[4:0];
	assign regOut2[31:5] = regRd[4];

	
endmodule
