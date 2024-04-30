module Cipher128(output wire [127:0] out1,input clk);
    wire [127:0] state;
    reg  [127:0] state0;
    reg  [127:0]temp;
    wire [127:0] key;
    wire [127:0] out;
    wire [127:0] out_lastround;
    integer i=-1;
    assign state = 128'h00112233445566778899aabbccddeeff;
    assign key = 128'h000102030405060708090a0b0c0d0e0f;
    wire [0:1407] w;
    KeyExpansion128 uut(key, w);
    round x(state0, w[((i+1)*128)+:128],out);   
 always@ (posedge clk) 
    begin 
        if(i==-1)
        begin
            state0<=state^w[0:127];
            temp<=out;
            i=i+1;
        end
        else if(i<10)
        begin
        state0<=out;  
        temp<=out;
        i=i+1;
        end
        else if(i==10)
        begin
            temp<=out_lastround;
        end
    end
    assign out1=temp;
    last_round xs(state0,w[((i+1)*128)+:128],out_lastround);
    assign temp=out_lastround;
endmodule

module InvCipher128(output [127:0] out1,input clk);
    wire [127:0] state;
    wire [127:0] key;
    reg  [127:0] state0;
    reg  [127:0]temp;
    wire [127:0] out;
    wire [127:0] out_lastround;
    assign state = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
    assign key = 128'h000102030405060708090a0b0c0d0e0f;
    integer i=10;

    
    wire [0:1407] w;

    KeyExpansion128 uut(key, w);
    round_inverse r(state0,w[((i)*128)+:128],out);
    always@ (posedge clk) 
    begin 
        if(i==10)
        begin
            state0<=state^w[1280+:128];
            temp<=out;
            i=i-1;
        end
        else if(i>0)
        begin
        state0<=out;  
        temp<=out;
        i=i-1;
        end
        else if(i==0)
        begin
            temp<=out_lastround;
        end
    end
    assign out1=temp;
    last_round_inv l(state0,w [((i)*128)+:128],out_lastround);
    assign temp=out_lastround;

endmodule

module Cipher128_tb();//must be run in modelsim( run 1200 )

    reg clk; // Define clock signal
    wire [127:0] outer;

    // Instantiate the module under test
    Cipher128 uut(outer, clk);

    // Clock generation
    initial begin
        clk = 0; // Initialize clock
        #50;
        repeat (10) begin // Repeat for 10 positive edges
            #50 clk = 1; // Set clock high after 50 time units
            #50 clk = 0; // Set clock low after another 50 time units
        end
        #50; // Wait for final stabilization
        $display("out = %h", outer); // Display the output
        //$finish; // End the simulation
    end

endmodule




module InvCipher128_tb();
    reg clk; // Define clock signal
    wire [127:0] outer;

    // Instantiate the module under test
    InvCipher128 uut(outer, clk);

    // Clock generation
    initial begin
        clk = 0; // Initialize clock
        #50;
        repeat (10) begin // Repeat for 10 positive edges
            #50 clk = 1; // Set clock high after 50 time units
            #50 clk = 0; // Set clock low after another 50 time units
        end
        #50; // Wait for final stabilization
        $display("out = %h", outer); // Display the output
        //$finish; // End the simulation
    end

endmodule