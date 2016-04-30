module InstrDecod(instr, pc, regWrite, writeData, writeRegister, opcode, funct, regOut1, regOut2, regRt, regRd, immValue, jumpDest, branchDest);
  input [31:0] instr;    //from Instruction Fetch
  input [31:0] pc; //from Instruction Fetch
  input [31:0] writeData;
  input [4:0] writeRegister;
  input regWrite;   //from Control

  output [5:0] opcode; //sent to Control
  output [5:0] funct;  //sent to ALU Control
  output [31:0] regOut1; //sent to Exe(Read data 1)
  output [31:0] regOut2; //sent to Exe(Read data 2)
  output [4:0] regRt;  //sent to Exe Mux(RegDst = 0)
  output [4:0] regRd;  //sent to Exe Mux(RegDst = 1)
  output [31:0] jumpDest;  //sent for Jump address
  output [31:0] immValue;
  output [31:0] branchDest;

  reg signed [31:0] registerMem [0:31];

  wire signed [31:0] writeData;
  wire signed [31:0] pc;
  reg [5:0] opcode, funct;
  reg [4:0] regRs, regRt, regRd;
  reg signed [31:0] regOut1, regOut2;
  reg signed [31:0] immValue, jumpDest, branchDest;
  reg signed [31:0] signedBranch;

  integer k;
  initial
    begin
    for (k = 0; k < 32; k = k + 1)
      begin
        registerMem[k] = 0;
      end
  end

  always @(*) begin
    if (regWrite == 1)
      registerMem[writeRegister] = writeData;
  end

  always @(instr) begin
    opcode = instr[31:26];
     funct = instr[5:0];

    // registers
    regRs = instr[25:21];
    regRt = instr[20:16];
    regRd = instr[15:11];

    // immediate values
    immValue = { {16{instr[15]}}, instr[15:0] };

    // jump 
    // jumpDest[31:28]
    // jumpDest[27:2] = instr[25:0];
    jumpDest = { {5{instr[25]}}, instr[25:0] };

    signedBranch = { {16{instr[15]}}, instr[15:0] };
    branchDest = pc + signedBranch;

    regOut1 = registerMem[regRs];
    regOut2 = registerMem[regRt];
  end
  
endmodule
