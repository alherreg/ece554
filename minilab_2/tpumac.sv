// Spec v1.1
module tpumac
 #(parameter BITS_AB=8,
   parameter BITS_C=16)
  (
   input clk, rst_n, WrEn, en,
   input signed [BITS_AB-1:0] Ain,
   input signed [BITS_AB-1:0] Bin,
   input signed [BITS_C-1:0] Cin,
   output reg signed [BITS_AB-1:0] Aout,
   output reg signed [BITS_AB-1:0] Bout,
   output reg signed [BITS_C-1:0] Cout
  );
// NOTE: added register enable in v1.1
// Also, Modelsim prefers "reg signed" over "signed reg"

    always_ff @(posedge clk) begin 
        if (~rst_n) begin 
            Aout <= {BITS_AB{1'b0}};
            Bout <= {BITS_AB{1'b0}};
            Cout <= {BITS_C{1'b0}};
        end
        else if (en) begin 
            Aout <= Ain;
            Bout <= Bin;
            Cout <= WrEn ? Cin : (Ain*Bin) + Cout;
        end  
    end 

endmodule 