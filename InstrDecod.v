module InstrDecod(instr, pc, regWrite, writeData, writeRegister, opcode, funct, regOut1, regOut2, regRt, regRd, immValue, jumpDest, branchDest);
  input [31:0] instr;    //from Instruction Fetch
  input [31:0] pc; //from Instruction Fetch
  input [31:0] writeData; // the full 32 bit value that gets written to register
  input [4:0] writeRegister; // The register to write the reg data to
  input regWrite;   //from Control

  output [5:0] opcode; //sent to Control
  output [5:0] funct;  //sent to ALU Control
  output [31:0] regOut1; //sent to Exe(Read data 1)
  output [31:0] regOut2; //sent to Exe(Read data 2)
  output [4:0] regRt;  //sent to Exe Mux(RegDst = 0)
  output [4:0] regRd;  //sent to Exe Mux(RegDst = 1)
  output [31:0] jumpDest;  //sent for Jump address
  output [31:0] immValue; // immediate value that is sign extended
  output [31:0] branchDest; // sign extended branch destination relative to PC

  reg signed [31:0] registerMem [0:31];

  // For uses, see inputs and outputs
  wire signed [31:0] writeData;
  wire signed [31:0] pc;
  reg [5:0] opcode, funct;
  reg [4:0] regRs, regRt, regRd;
  reg signed [31:0] regOut1, regOut2;
  reg signed [31:0] immValue, jumpDest, branchDest;
  reg signed [31:0] signedBranch;


  // Initialize the register memory to zero
  integer idx;
  initial
    begin
    for (idx = 0; idx < 32; idx = idx + 1)
      begin
        registerMem[idx] = 0;
      end
  end

  // always write because the writeData could be the same
  always @(*) begin
    if (regWrite == 1)
      registerMem[writeRegister] = writeData;
  end

  // whenever the instruction changes, do this.
  always @(instr) begin
    // pluck the opcode and function
    opcode = instr[31:26];
     funct = instr[5:0];

    // Pluck the registers out of the instruction
    regRs = instr[25:21];
    regRt = instr[20:16];
    regRd = instr[15:11];

    // Sign extend the values

    // This is taking the MSB and making all the other MSB's the same
    // then stick that value on the end
    immValue = { {16{instr[15]}}, instr[15:0] };

    // You are supposed to jump straight to the address
    jumpDest = { {5{instr[25]}}, instr[25:0] };

    // Only using this extra step to see the relative jumping
    signedBranch = { {16{instr[15]}}, instr[15:0] };
    // set the branch dest relative to the PC
    branchDest = pc + signedBranch;

    // Set the register values and output them
    regOut1 = registerMem[regRs];
    regOut2 = registerMem[regRt];
  end
  
endmodule
