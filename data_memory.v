module data_memory(address, write_data, control_write, read_data);
  // Parameters
  // w is the size of each cell
  parameter w = 31;
  // cells is the count for each cell
  parameter cells = 255;

  // Inputs
  input [w:0] address;
  input [w:0] write_data;
  input [0:0] control_write;
  output [w:0] read_data;

  wire [w:0] address;
  wire [0:0] control_write;
  // Actual mememory register
  reg [w:0] storage [0:cells];
  reg [w:0] read_data;

  always @(*) begin

    // If we are supposed to write this cycle
    // lets write
    if(control_write == 1)
      begin
        storage[address] = write_data;
      end
    else
      // Otherwise, we are reading
      begin
        read_data = storage[address];
      end
  end
endmodule