module control(op, funct, mem_to_reg, mem_write, branch, alu_ctrl, alu_src, reg_dst, reg_write) ;
  input [5:0] funct;
  input [5:0] op;

  output [0:0] mem_to_reg, mem_write, branch, alu_src, reg_dst, reg_write;
  output [2:0] alu_ctrl;

  reg [0:0] mem_to_reg, mem_write, branch, alu_src, reg_dst, reg_write;
  reg [2:0] alu_ctrl;



  always @(*) begin
    case(op)
      // jump opcode
      5'b000010: begin
        branch = 1;
        reg_write = 0;
        mem_write = 0;
	end
      // R type op-code
      5'b000000:
        case(funct)
          // we are an R instruction type
          // what function are we?

          // add funct
          5'b100000: begin
            reg_write = 1;
            reg_dst = 1;
            alu_src = 0;
            branch = 0;
            mem_write = 0;
            alu_ctrl = 1'b01;
	end
          // sub funct
          5'b100100: begin
            reg_write = 1;
            reg_dst = 1;
            alu_src = 0;
            branch = 0;
            mem_write = 0;
            alu_ctrl = 1'b10;
	end
        endcase
      // I type OP codes

      // Addi
      5'b001000: begin
        reg_write = 1;
        reg_dst = 0;
        alu_src = 1;
        branch = 0;
        mem_write = 0;
        mem_to_reg = 0;
	end
      // lw
      5'b100011: begin
        reg_write = 1;
        reg_dst = 0;
        alu_src = 1;
        branch = 0;
        mem_write = 0;
        mem_to_reg = 1;
        alu_ctrl = 1'b01;
	end
      // sw
      5'b101011: begin
        reg_write = 0;
        alu_src = 1;
        branch = 0;
        mem_write = 1;
        alu_ctrl = 1'b01;
	end
      // beq 
      5'b000100: begin
        reg_write = 0;
        alu_src = 0;
        branch = 1;
        mem_write = 0;
        alu_ctrl = 1'b00;
	end
    endcase
  end
endmodule