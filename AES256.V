module Cipher256(output wire [127:0] out1,input clk);
    reg  [127:0] state0;
    reg  [127:0]temp;
    wire  [127:0]state;
    wire [255:0]key;
    wire [127:0] out;
    wire [127:0] out_lastround;
    integer i=-1;
    assign state = 128'h00112233445566778899aabbccddeeff;
    assign key = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
    wire [0:1919] w;
    KeyExpansion256 uut(key, w);
    round x(state0, w[((i+1)*128)+:128],out);   
 always@ (posedge clk) 
    begin 
        if(i==-1 && state !== 'bx)
        begin
            state0<=state^w[0:127];
            temp<=out;
            i=i+1;
        end
        else if(i<13 && state !== 'bx)
        begin
        state0<=out;  
        temp<=out;
        i=i+1;
        end
        else if(i==13 && state !== 'bx)
        begin
            temp<=out_lastround;
            i=i+1;
        end
    end
    assign out1=temp;
    last_round xs(state0,w[((i+1)*128)+:128],out_lastround);
    //assign temp=out_lastround;
endmodule

module InvCipher256(output [127:0] out1,input clk);
    reg  [127:0] state0;
    reg  [127:0]temp;
    wire [127:0] out;
    wire [127:0] out_lastround;
    wire [255:0]key;
     wire  [127:0]state;
    assign state = 128'h8ea2b7ca516745bfeafc49904b496089;
    assign key = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
    integer i=14;

    
    wire [0:1919] w;

    KeyExpansion256 uut(key, w);
    round_inverse r(state0,w[((i)*128)+:128],out);
    always@ (posedge clk) 
    begin 
        if(i==14 && state !== 'bx)
        begin
            state0<=state^w[1792+:128];
            temp<=out;
            i=i-1;
        end
        else if(i>0&& state !== 'bx)
        begin
        state0<=out;  
        temp<=out;
        i=i-1;
        end
        else if(i==0 && state !== 'bx)
        begin
            temp<=out_lastround;
            i=i-1;
        end
    end
    assign out1=temp;
    last_round_inv l(state0,w [((i)*128)+:128],out_lastround);
    //assign temp=out_lastround;

endmodule

module Cipher256_tb();//must be run in modelsim( run 1200 )

    reg clk; // Define clock signal
    wire [127:0] outer;

    // Instantiate the module under test
    Cipher256 uut(outer, clk);

    // Clock generation
    initial begin
        clk = 0; // Initialize clock
        #50;
        repeat (14) begin // Repeat for 14 positive edges
            #50 clk = 1; // Set clock high after 50 time units
            #50 clk = 0; // Set clock low after another 50 time units
        end
        #50; // Wait for final stabilization
        $display("out = %h", outer); // Display the output
        //$finish; // End the simulation
    end

endmodule




module InvCipher256_tb();
    reg clk; // Define clock signal
    wire [127:0] outer;

    // Instantiate the module under test
    InvCipher256 uut(outer, clk);

    // Clock generation
    initial begin
        clk = 0; // Initialize clock
        #50;
        repeat (14) begin // Repeat for 14 positive edges
            #50 clk = 1; // Set clock high after 50 time units
            #50 clk = 0; // Set clock low after another 50 time units
        end
        #50; // Wait for final stabilization
        $display("out = %h", outer); // Display the output
        //$finish; // End the simulation
    end

endmodule