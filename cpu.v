module cpu(clk, rst);
  input clk, rst;

  wire [31:0] instruction;
  wire mem_to_reg, mem_write, branch_ctrl, alu_src, reg_dst, reg_write, jumpCtr;
  wire [1:0] alu_ctrl;
  wire [31:0] writeData;
  wire [5:0] opcode, funct;
  wire [31:0] regOut1, regOut2;
  wire [4:0] regRt, regRd;
  wire [31:0] immValue;
  wire [31:0] result;
  wire [31:0] readData;
  wire [31:0] currentPC;
  wire [31:0] jumpDest;
  wire [31:0] branchDest;
  wire [4:0] writeRegister;
  wire canBranch;
  wire canReallyBranch;

  allAlu alu(regOut1, regOut2, immValue, reg_dst, regRt, regRd, alu_src, alu_ctrl, writeRegister, result, canBranch);

  //               (instr, pc, regWrite, writeData, opcode, funct, regOut1, regOut2, regRt, regRd, immValue, jumpDest, branchDest);
  InstrDecod decode(instruction, currentPC, reg_write, writeData, writeRegister, opcode, funct, regOut1, regOut2, regRt, regRd, immValue, jumpDest, branchDest);

  if_phase fetcher(clk, rst, branchDest, canReallyBranch, jumpDest, jumpCtrl, instruction, currentPC);

  control ctrl(opcode, funct, mem_to_reg, mem_write, branch_ctrl, alu_ctrl, alu_src, reg_dst, reg_write, jumpCtrl);

  data_memory mem(result, regOut2, mem_write, readData);
  Mux2 last_mux(result, readData, mem_to_reg, writeData);

  bestAnd branchAnd(branch_ctrl, canBranch, canReallyBranch);
endmodule

module allAlu(regOut1, regOut2, immValue, regDst, regRt, regRd, alu_src, alu_ctrl, writeRegister, result, canBranch);
  input [31:0] regOut1, regOut2, immValue;
  input alu_src;
  input [1:0] alu_ctrl;
  input [4:0] regRt, regRd;
  input regDst; 

  output [4:0] writeRegister;
  output [31:0] result;
  output canBranch;

  wire signed [31:0] regOut1, regOut2, immValue;
  wire alu_src;
  wire [1:0] alu_ctrl;
  wire signed [31:0] result;
  wire canBranch;
  wire [31:0] actualSource;

  alu alu(result, canBranch, regOut1, actualSource, alu_ctrl);
  Mux1 mux(regRt, regRd, regDst, writeRegister);
  Mux2 other_mux(regOut2, immValue, alu_src, actualSource);
endmodule

module bestAnd(inOne, inTwo, outResult);
  input inOne;
  input inTwo;

  output outResult;
  reg outResult;

  always @(*) begin
    outResult = inOne & inTwo;
  end
endmodule