module cpu(clk, rst);
  input clk, rst;

  wire [31:0] instruction;
  wire mem_to_reg, mem_write, branch, alu_src, reg_dst, reg_write;
  wire [2:0] alu_ctrl;
  wire [31:0] writeData;
  wire [5:0] opcode, funct;
  wire [31:0] regOut1, regOut2;
  wire [4:0] regRt, regRd;
  wire [31:0] immValue;
  wire [31:0] result;
  wire [31:0] readData;

  allAlu alu(regOut1, regOut2, immValue, reg_dst, regRt, regRd, alu_src, alu_ctrl, writeRegister, result);

  control ctrl(opcode, funct, mem_to_reg, mem_write, branch, alu_ctrl, alu_src, reg_dst, reg_write);

  if_phase fetcher(clk, rst, branch, instruction);
  InstrDecod decode(instruction, reg_write, writeData, opcode, funct, regOut1, regOut2, regRt, regRd, immValue);

  data_memory mem(result, regOut2, mem_write, readData);
  Mux2 last_mux(result, readData, mem_to_reg, writeData);

endmodule

module allAlu(regOut1, regOut2, immValue, regDst, regRt, regRd, alu_src, alu_ctrl, writeRegister, result);
  input [31:0] regOut1, regOut2, immValue;
  input alu_src;
  input [2:0] alu_ctrl;
  input [4:0] regRt, regRd;
  input regDst; 

  output [4:0] writeRegister;
  output [31:0] result;

  wire [31:0] regOut1, regOut2, immValue;
  wire alu_src;
  wire [2:0] alu_ctrl;
  wire [31:0] result;
  wire outBranch;
  wire [31:0] actualSource;

  alu alu(result, outBranch, regOut1, actualSource, alu_ctrl);
  Mux1 mux(regRt, regRd, regDst, writeRegister);
  Mux2 other_mux(regOut2, immValue, alu_src, actualSource);


endmodule