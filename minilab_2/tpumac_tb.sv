module tpumac_tb #(parameter BITS_AB=8, parameter BITS_C=16)();

    logic clk; 
    logic rst_n;
    logic WrEn;
    logic en;

    logic signed [BITS_AB-1:0] Ain;
    logic signed [BITS_AB-1:0] Bin;
    logic signed [BITS_C-1:0] Cin;

    logic reg signed [BITS_AB-1:0] Aout;   
    logic reg signed [BITS_AB-1:0] Bout;
    logic reg signed [BITS_C-1:0] Cout;

    // Instantiate the DUT 
    tpumac iDUT(.clk(clk), .rst_n(rst_n), .WrEn(WrEn), .en(en), .Ain(Ain), 
                .Bin(Bin), .Cin(Cin), .Aout(Aout), .Bout(Bout), .Cout(Cout));


    // Declare the testing values 
    logic signed [BITS_AB-1:0] vals_Ain [7:0];
    logic signed [BITS_AB-1:0] vals_Bin [7:0];
    logic signed [BITS_C-1:0] vals_Cin [7:0];

    logic signed [BITS_AB-1:0] vals_Aout [7:0];
    logic signed [BITS_AB-1:0] vals_Bout [7:0];
    logic signed [BITS_C-1:0] vals_Cout [7:0];

    // Instantiate the values for all the values 
    integer i;
    for (i = 0; i < 8; i++) begin 
        vals_Ain[i] = i;
    end 
    for (i = 0; i < 8; i++) begin 
        vals_Bin[i] = i*2;
    end 
    for (i = 0; i < 8; i++) begin 
        vals_Cin[i] = i*3;
    end 

    vals_Aout[0] = vals_Ain[0];   
    vals_Aout[1] = vals_Ain[1];
    vals_Aout[2] = vals_Ain[2];
    vals_Aout[3] = vals_Ain[3];
    vals_Aout[4] = vals_Ain[4];
    vals_Aout[5] = vals_Ain[5];
    vals_Aout[6] = vals_Ain[6];
    vals_Aout[7] = vals_Ain[7];

    vals_Bout[0] = vals_Bin[0];
    vals_Bout[1] = vals_Bin[1];
    vals_Bout[2] = vals_Bin[2];
    vals_Bout[3] = vals_Bin[3];
    vals_Bout[4] = vals_Bin[4];
    vals_Bout[5] = vals_Bin[5];
    vals_Bout[6] = vals_Bin[6];
    vals_Bout[7] = vals_Bin[7];

    vals_Cout[0] = vals_Cin[0]; // Wren = 1 
    vals_Cout[1] = vals_Ain[1]*vals_Bin[1] + vals_Cout[0]; // Wren = 0
    vals_Cout[2] = vals_Ain[2]*vals_Bin[2] + vals_Cout[1]; // Wren = 0
    vals_Cout[3] = vals_Ain[3]*vals_Bin[3] + vals_Cout[2]; // Wren = 0
    vals_Cout[4] = vals_Cin[4]; // Wren = 1
    vals_Cout[5] = vals_Ain[5]*vals_Bin[5] + vals_Cout[4]; // Wren = 0
    vals_Cout[6] = vals_Cin[6]; // Wren = 1
    vals_Cout[7] = vals_Cin[7]; // Wren = 1

    // Clk signal 
    always #5 clk = ~clk;

    initial begin

        clk = 1'b0;
		rst_n = 1'b0;
		en = 1'b0;
		errors = 0;

        @(posedge clk) 

        // Check that the values of the have been reset 
                



    end 


endmodule 