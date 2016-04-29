module InstrDecod(instr, pc, regWrite, writeData, opcode, funct, regOut1, regOut2, regRt, regRd, immValue, jumpDest, branchDest);
  input [31:0] instr;    //from Instruction Fetch
  input [31:0] pc; //from Instruction Fetch
  input [31:0] writeData;
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

  reg [31:0] registerMem [0:31];

  wire [4:0] regRs, regRt, regRd;
  wire [31:0] regOut1, regOut2;
  wire [31:0] immValue, branchAddr, jumpDest;
 
  integer k;
  initial
    begin
    for (k = 0; k < 31 - 1; k = k + 1)
      begin
        registerMem[k] = 0;
      end
  end

  always @(writeData) begin
    if (regWrite == 1)
      registerMem[regRd] = writeData;
    else
      registerMem[regRt] = writeData;
  end

  //always @(instr) begin
    assign opcode = instr[31:26];
    assign funct = instr[5:0];

    // registers
    assign regRs = instr[25:21];
    assign regRt = instr[20:16];
    assign regRd = instr[15:11];


    // immediate values
    assign immValue = { {16{instr[15]}}, instr[15:0] };

    // jump 
    assign jumpDest[31:28] = pc[31:28];
    assign jumpDest[27:2] = instr[25:0];
    assign jumpDest [1:0] = 0;

    assign branchDest = immValue;
    assign branchDest[31:28] = pc[31:28];

    assign regOut1 = registerMem[regRs];
    assign regOut2 = registerMem[regRt];
  //end
  
endmodule
