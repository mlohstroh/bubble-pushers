module control(op, funct, mem_to_reg, mem_write, branch, alu_ctrl, alu_src, reg_dst, reg_write) ;
  input [5:0] funct;
  input [5:0] op;

  ouput [0:0] mem_to_reg, mem_write, branch, alu_src, reg_dst, reg_write;
  ouput [2:0] alu_ctrl;

  always @(*) begin
    case(op) begin
      // jump opcode
      5'b000010: 
        branch = 1;
        reg_write = 0;
        mem_write = 0;
      // R type op-code
      5'b000000: begin
        case(funct) begin
          // we are an R instruction type
          // what function are we?

          // add funct
          5'b100000: 
            reg_write = 1;
            reg_dst = 1;
            alu_src = 0;
            branch = 0;
            mem_write = 0;
            alu_ctrl = 1'b01;
          // sub funct
          5'b100100:
            reg_write = 1;
            reg_dst = 1;
            alu_src = 0;
            branch = 0;
            mem_write = 0;
            alu_ctrl = 1'b10;
        endcase
      // I type OP codes

      // Addi
      5'b001000: 
        reg_write = 1;
        reg_dst = 0;
        alu_src = 1;
        branch = 0;
        mem_write = 0;
        mem_to_reg = 0;
      // lw
      5'b100011:
        reg_write = 1;
        reg_dst = 0;
        alu_src = 1;
        branch = 0;
        mem_write = 0;
        mem_to_reg = 1;
        alu_ctrl = 1'b01;
      // sw
      5'b101011:
        reg_write = 0;
        alu_src = 1;
        branch = 0;
        mem_write = 1;
        alu_ctrl = 1'b01;
      // beq 
      5'b000100:
        reg_write = 0;
        alu_src = 0;
        branch = 1;
        mem_write = 0;
        alu_ctrl = 1'b00;
    endcase
  end
endmodule