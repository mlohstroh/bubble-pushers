// The CPU module that contains all the data
module cpu(clk, rst);
  input clk, rst;

  // Wires here are the connections between modules 
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

  // Full alu module
  allAlu alu(regOut1, regOut2, immValue, reg_dst, regRt, regRd, alu_src, alu_ctrl, writeRegister, result, canBranch);

  // Instruction decode step
  InstrDecod decode(instruction, currentPC, reg_write, writeData, writeRegister, opcode, funct, regOut1, regOut2, regRt, regRd, immValue, jumpDest, branchDest);

  // Fetching the next instruction code
  if_phase fetcher(clk, rst, branchDest, canReallyBranch, jumpDest, jumpCtrl, instruction, currentPC);

  // The control module
  control ctrl(opcode, funct, mem_to_reg, mem_write, branch_ctrl, alu_ctrl, alu_src, reg_dst, reg_write, jumpCtrl);

  // RAM for the CPU
  data_memory mem(result, regOut2, mem_write, readData);
  // Branching mux for the ALU result
  mux #(32) last_mux(result, readData, mem_to_reg, writeData);

  // final branch control
  bestAnd branchAnd(branch_ctrl, canBranch, canReallyBranch);
endmodule


// Module that wires all the ALU components together
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

  // alu operations based on control
  alu alu(result, canBranch, regOut1, actualSource, alu_ctrl);
  // Muxes that select the inputs to the ALU
  mux #(5) mux(regRt, regRd, regDst, writeRegister);
  mux #(32) other_mux(regOut2, immValue, alu_src, actualSource);
endmodule

// An and module for to determine if we can branch or not
module bestAnd(inOne, inTwo, outResult);
  input inOne;
  input inTwo;

  output outResult;
  reg outResult;

  always @(*) begin
    outResult = inOne & inTwo;
  end
endmodule