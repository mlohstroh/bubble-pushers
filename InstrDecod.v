module InstrDecod(instr, PC_4, regWrite, opcode, funct, regOut1, regOut2, regRt, regRd, jumpDest);
  input [31:0] instr;    //from Instruction Fetch
  input [31:0] PC_4; //from Instruction Fetch
  input regWrite;   //from Control
  

  output [5:0] opcode; //sent to Control
  output [5:0] funct;  //sent to ALU Control
  output [31:0] regOut1; //sent to Exe(Read data 1)
  output [31:0] regOut2; //sent to Exe(Read data 2)
  output [4:0] regRt;  //sent to Exe Mux(RegDst = 0)
  output [4:0] regRd;  //sent to Exe Mux(RegDst = 1)
  output [31:0] jumpDest;  //sent for Jump address

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
  assign jumpDest[27:2] = instr[25:0];
  assign jumpDest [1:0] = 0;
  assign regOut1[4:0] = regRs[4:0];
  assign regOut1[31:5] = regRs[4];
  assign regOut2[4:0] = regRd[4:0];
  assign regOut2[31:5] = regRd[4];

  
endmodule
