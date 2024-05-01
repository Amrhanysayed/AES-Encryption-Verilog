module Cipher192(output wire [127:0] out1,input clk, input [127:0]state, input [191:0] key);
    reg  [127:0] state0;
    reg  [127:0] temp;
    wire [127:0] out;
    wire [127:0] out_lastround;
    integer i=-1;

    // for testing
    // wire [127:0] state;
    // wire [191:0] key;
    // assign state = 128'h00112233445566778899aabbccddeeff;
    // assign key = 192'h000102030405060708090a0b0c0d0e0f1011121314151617;
    wire [0:1663] w;
    KeyExpansion192 uut(key, w);
    round x(state0, w[((i+1)*128)+:128],out);   
 always@ (posedge clk) 
    begin 
        if(i==-1 && state !== 'bx)
        begin
            state0<=state^w[0:127];
            temp=state0;
            i=i+1;
        end
        else if(i < 11 && state !== 'bx)
        begin
        state0<=out;  
        temp<=out;
        i=i+1;
        end
        else if(i == 11 && state !== 'bx)
        begin
            temp<=out_lastround;
            i=i+1;
        end
    end
    assign out1=temp;
    last_round xs(state0,w[((i+1)*128)+:128],out_lastround);
    //assign temp=out_lastround;
endmodule

module InvCipher192(output wire [127:0] out1,input clk); //, input [127:0]state, input [191:0] key);
    reg  [127:0] state0;
    reg  [127:0] temp;
    wire [127:0] out;
    wire [127:0] out_lastround;

    // for testing
    wire [191:0] key;
    wire  [127:0] state;
    
    assign state = 128'hdda97ca4864cdfe06eaf70a0ec0d7191;
    assign key = 192'h000102030405060708090a0b0c0d0e0f1011121314151617;
    integer i=12;

    
    wire [0:1663] w;

    KeyExpansion192 uut(key, w);
    round_inverse r(state0,w[((i)*128)+:128],out);
    always@ (posedge clk) 
    begin 
        if(i == 12 && state !== 'bx)
        begin
            state0<=state^w[1536+:128];
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

module Cipher192_tb(); // must run in modelsim ( run 1400 )

    reg clk; // Define clock signal
    wire [127:0] _output;

    // Instantiate the module under test
    Cipher192 uut(_output, clk);

    // Clock generation
    initial begin
        clk = 0; // Initialize clock
        #50;
        repeat (13) begin // Repeat for 11 positive edges
            #50 clk = 1; // Set clock high after 50 time units
            #50 clk = 0; // Set clock low after another 50 time units
        end
        #50; // Wait for final stabilization
        $display("out = %h", _output); // Display the output
        //$finish; // End the simulation
    end

endmodule




module InvCipher192_tb(); // must run in modelsim ( run 1400 )
    reg clk; // Define clock signal
    wire [127:0] _output;

    // Instantiate the module under test
    InvCipher192 uut(_output, clk);

    // Clock generation
    initial begin
        clk = 0; // Initialize clock
        #50;
        repeat (13) begin // Repeat for 10 positive edges
            #50 clk = 1; // Set clock high after 50 time units
            #50 clk = 0; // Set clock low after another 50 time units
        end
        #50; // Wait for final stabilization
        $display("out = %h", _output); // Display the output
        //$finish; // End the simulation
    end

endmodule