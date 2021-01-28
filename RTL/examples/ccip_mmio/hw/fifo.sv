// fifo.sv
// Implements delay buffer (fifo)
// On reset all entries are set to 0
// Shift causes fifo to shift out oldest entry to q, shift in d

module fifo
  #(
  parameter DEPTH=8,
  parameter BITS=64
  )
  (
  input clk,rst_n,en,
  input [BITS-1:0] d,
  output [BITS-1:0] q
  );

  // your RTL code here


  reg [2:0] rd; // buffer pointer 

  reg [BITS:0] buffer [DEPTH-1:0]; // buffer data

  integer i; // used for buffer reset

  always @(posedge clk) begin 

    if ( rst_n == 1'b0) begin 

      rd <= 3'b0;
      // reset toi zero 
      for ( i = 0; i < DEPTH; i = i+1 ) begin 
        buffer[i] <=  {BITS{1'b0}};
      end

    end 

    else if ( en == 1'b1) begin 
      rd <= rd + 1; // Should overflow back to 0
      buffer[rd] <= d;
    end 

  end 

  assign q = buffer[rd]; // one ahead of the newest is the oldest

  
endmodule // fifo
