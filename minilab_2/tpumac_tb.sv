module tpumac_tb #(parameter BITS_AB=8, parameter BITS_C=16)();

    logic clk; 
    logic rst_n;
    logic WrEn;
    logic en;

    logic signed [BITS_AB-1:0] Ain;
    logic signed [BITS_AB-1:0] Bin;
    logic signed [BITS_C-1:0] Cin;

    logic signed [BITS_AB-1:0] Aout;   
    logic signed [BITS_AB-1:0] Bout;
    logic signed [BITS_C-1:0] Cout;

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


    integer i;
    integer errors;

    // Clk signal 
    always #5 clk = ~clk;

    initial begin

        // Instantiate the values for all the values 
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

        clk = 1'b1;
		rst_n = 1'b0;
		en = 1'b0;
		errors = 0;

        @(posedge clk) 

        // Check that the values of the have been reset 
        if (Aout != 0 || Bout != 0 || Cout != 0) begin 
            errors++;
        end

        rst_n = 1;
        en = 1;
        WrEn = 1;

        // i = 0 
        @(negedge clk)
        Ain = vals_Ain[0];
        Bin = vals_Bin[0];
        Cin = vals_Cin[0];
        @(posedge clk)
        en = 0;
        @(posedge clk)
        en =1;

        // Check the values againts the solutions 
        if (Aout != vals_Ain[0] || Bout != vals_Bout[0] || Cout != vals_Cout[0]) begin 
            errors++;
            $display("Aout: Expected: %d, Got %d\n", vals_Aout[0], Aout);
            $display("Bout: Expected: %d, Got %d\n", vals_Bout[0], Bout);
            $display("Cout: Expected: %d, Got %d\n", vals_Cout[0], Cout);
        end


        // i = 1 
        
        @(negedge clk)
        WrEn = 0;
        Ain = vals_Ain[1];
        Bin = vals_Bin[1];
        Cin = vals_Cin[1];
        @(posedge clk)
        en = 0;
        @(posedge clk)
        en =1;

        // Check the values againts the solutions 
        if (Aout != vals_Ain[1] || Bout != vals_Bout[1] || Cout != vals_Cout[1]) begin 
            errors++;
            $display("Aout: Expected: %d, Got %d\n", vals_Aout[1], Aout);
            $display("Bout: Expected: %d, Got %d\n", vals_Bout[1], Bout);
            $display("Cout: Expected: %d, Got %d\n", vals_Cout[1], Cout);
        end

        // i = 2 
        @(negedge clk)
        Ain = vals_Ain[2];
        Bin = vals_Bin[2];
        Cin = vals_Cin[2];
        @(posedge clk)
        en = 0;
        @(posedge clk)
        en =1;
        
        // Check the values againts the solutions 
        if (Aout != vals_Ain[2] || Bout != vals_Bout[2] || Cout != vals_Cout[2]) begin 
            errors++;
            $display("Aout: Expected: %d, Got %d\n", vals_Aout[2], Aout);
            $display("Bout: Expected: %d, Got %d\n", vals_Bout[2], Bout);
            $display("Cout: Expected: %d, Got %d\n", vals_Cout[2], Cout);
        end

        // i = 3 
        @(negedge clk)
        Ain = vals_Ain[3];
        Bin = vals_Bin[3];
        Cin = vals_Cin[3];
        @(posedge clk)
        en = 0;
        @(posedge clk)
        en =1;

        // Check the values againts the solutions 
        if (Aout != vals_Ain[3] || Bout != vals_Bout[3] || Cout != vals_Cout[3]) begin 
            errors++;
            $display("Aout: Expected: %d, Got %d\n", vals_Aout[3], Aout);
            $display("Bout: Expected: %d, Got %d\n", vals_Bout[3], Bout);
            $display("Cout: Expected: %d, Got %d\n", vals_Cout[3], Cout);
        end

        // i = 4 
        @(negedge clk)
        WrEn = 1;
        Ain = vals_Ain[4];
        Bin = vals_Bin[4];
        Cin = vals_Cin[4];
        @(posedge clk)
        en = 0;
        @(posedge clk)
        en =1;

        // Check the values againts the solutions 
        if (Aout != vals_Ain[4] || Bout != vals_Bout[4] || Cout != vals_Cout[4]) begin 
            errors++;
            $display("Aout: Expected: %d, Got %d\n", vals_Aout[4], Aout);
            $display("Bout: Expected: %d, Got %d\n", vals_Bout[4], Bout);
            $display("Cout: Expected: %d, Got %d\n", vals_Cout[4], Cout);
        end

        // i = 5 
        @(negedge clk)
        WrEn = 0;
        Ain = vals_Ain[5];
        Bin = vals_Bin[5];
        Cin = vals_Cin[5];
        @(posedge clk)
        en = 0;
        @(posedge clk)
        en =1;

        // Check the values againts the solutions 
        if (Aout != vals_Ain[5] || Bout != vals_Bout[5] || Cout != vals_Cout[5]) begin 
            errors++;
            $display("Aout: Expected: %d, Got %d\n", vals_Aout[5], Aout);
            $display("Bout: Expected: %d, Got %d\n", vals_Bout[5], Bout);
            $display("Cout: Expected: %d, Got %d\n", vals_Cout[5], Cout);
        end

        // i = 6
        @(negedge clk)
        WrEn = 1; 
        Ain = vals_Ain[6];
        Bin = vals_Bin[6];
        Cin = vals_Cin[6];
        @(posedge clk)
        en = 0;
        @(posedge clk)
        en =1;

        // Check the values againts the solutions 
        if (Aout != vals_Ain[6] || Bout != vals_Bout[6] || Cout != vals_Cout[6]) begin 
            errors++;
            $display("Aout: Expected: %d, Got %d\n", vals_Aout[6], Aout);
            $display("Bout: Expected: %d, Got %d\n", vals_Bout[6], Bout);
            $display("Cout: Expected: %d, Got %d\n", vals_Cout[6], Cout);
        end

        // i = 7
        @(negedge clk)
        WrEn = 1;
        Ain = vals_Ain[7];
        Bin = vals_Bin[7];
        Cin = vals_Cin[7];
        @(posedge clk)
        en = 0;
        @(posedge clk)
        en =1;

        // Check the values againts the solutions 
        if (Aout != vals_Ain[7] || Bout != vals_Bout[7] || Cout != vals_Cout[7]) begin 
            errors++;
            $display("Aout: Expected: %d, Got %d\n", vals_Aout[7], Aout);
            $display("Bout: Expected: %d, Got %d\n", vals_Bout[7], Bout);
            $display("Cout: Expected: %d, Got %d\n", vals_Cout[7], Cout);
        end

        // i = 8
        @(negedge clk)
        WrEn = 1;
        Ain = 8'shC6;
        Bin = 8'sh4A;
        Cin = 16'shF2B5;
        @(posedge clk)
        en = 0;
        @(posedge clk)
        en =1;

        // Check the values againts the solutions 
        if (Aout != 8'shC6 || Bout != 8'sh4A || Cout != 16'shF2B5) begin 
            errors++;
            $display("Aout: Expected: %d, Got %d\n", 8'shC6, Aout);
            $display("Bout: Expected: %d, Got %d\n", 8'sh4A, Bout);
            $display("Cout: Expected: %d, Got %d\n", 16'shF2B5, Cout);
        end

        // i = 9
        @(negedge clk)
        WrEn = 0;
        Ain = 8'shC6;
        Bin = 8'sh4A;
        Cin = 16'shF2B5;
        @(posedge clk)
        en = 0;
        @(posedge clk)
        en =1;

        // Check the values againts the solutions 
        if (Aout != 8'shC6 || Bout != 8'sh4A || Cout != 16'shE1F1) begin 
            errors++;
            $display("Aout: Expected: %d, Got %d\n", 8'shC6, Aout);
            $display("Bout: Expected: %d, Got %d\n", 8'sh4A, Bout);
            $display("Cout: Expected: %d, Got %d\n", 16'shE1F1, Cout);
        end

        $display("Errors: %d", errors);

		if(!errors) begin
			$display("YAHOO!!! All tests passed.");
		end
		else begin
			$display("ARRRR!  Ye codes be blast! Aye, there be errors. Get debugging!");
		end

		$stop;
                



    end 


endmodule 