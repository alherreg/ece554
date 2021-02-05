module systolic_array
#(
   parameter BITS_AB=8,
   parameter BITS_C=16,
   parameter DIM=8
   )
  (
   input clk,rst_n,WrEn,en,
   input signed [BITS_AB-1:0] A [DIM-1:0],
   input signed [BITS_AB-1:0] B [DIM-1:0],
   input signed [BITS_C-1:0]  Cin [DIM-1:0],
   input [$clog2(DIM)-1:0]    Crow, //[2:0]
   output signed [BITS_C-1:0] Cout [DIM-1:0]
   );

   wire [DIM-1:0] WrEn_sel;
   //wire signed [BITS_C-1:0] Cout_all [DIM-1:0];
   wire signed [BITS_AB-1:0] A_reg [DIM-1:0][DIM-1:0];
   wire signed [BITS_AB-1:0] B_reg [DIM:0][DIM:0];
   wire signed [BITS_C-1:0] Cout_reg [DIM-1:0][DIM-1:0];
   genvar i;
   genvar j;
  
   
   
   generate;
       for(i = 0; i < DIM; i++) begin 
           for (j = 0; j< DIM; j++)begin 
               tpumac iTPUMAC(
                    .clk(clk), .rst_n(rst_n), .WrEn(WrEn_sel[i] & WrEn), .en(en),
                    .Ain(A_reg[i][j]), .Bin(B_reg[i][j]), .Cin(Cin[i]),
                    .Aout(A_reg[i][j+1]),.Bout(B_reg[i+1][j]),.Cout(Cout_reg[i][j])
                );
               
           end
       end
   endgenerate



   assign WrEn_sel = rst_n ? ({(DIM-1){1'b0}} + 1'b1) << Crow : 0;

    assign Cout = Cout_reg[Crow][7:0];

    assign A_reg[0][0] = A[0];
    assign A_reg[1][0] = A[1];
    assign A_reg[2][0] = A[2];
    assign A_reg[3][0] = A[3];
    assign A_reg[4][0] = A[4];
    assign A_reg[5][0] = A[5];
    assign A_reg[6][0] = A[6];
    assign A_reg[7][0] = A[7];

    assign B_reg[0][0] = B[0];
    assign B_reg[0][1] = B[1];
    assign B_reg[0][2] = B[2];
    assign B_reg[0][3] = B[3];
    assign B_reg[0][4] = B[4];
    assign B_reg[0][5] = B[5];
    assign B_reg[0][6] = B[6];
    assign B_reg[0][7] = B[7];
    






endmodule