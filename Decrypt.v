

module Decrypt  #(parameter nk=4,parameter nr=10) ( input  [(nk*32)-1:0] key , input clk, input  enable,input [127:0]state,output wire [127:0] out1);
    //  wire  [(nk*32)-1:0] key;
    reg  [127:0] state0;
    // wire [127:0] state;
    reg  [127:0]temp;
    wire [127:0] out;
    wire [127:0] out_lastround;
  
    wire [0:((nr+1)*128)-1] w;
  // for testing only /////////////////////////////////////////
//     assign state = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
//    assign key = 128'h000102030405060708090a0b0c0d0e0f;
   //////////////////////////////////////////////////////////////
    integer i=nr;

    
   
 keyExpansion #(nk, nr) key_expansion_inst (key,w);
    round_inverse r(state0,w[((i)*128)+:128],out);
    always@ (posedge clk or posedge enable) 
    begin 
        if(enable==1'b1)
    begin
         if(i==nr && state !== 'bx)
        begin
            state0<=state^w[((nr)*128)+:128];
            temp<=state^w[((nr)*128)+:128];
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
    end
    assign out1=temp;
    last_round_inv l(state0,w [((i)*128)+:128],out_lastround);
    //assign temp=out_lastround;

endmodule


// module Decrypt_tb;
//     reg clk;
//     reg enable;
//     reg [127:0] state;
//     wire [127:0] out1;

//     Decrypt #(4, 10) dut (
//         .clk(clk),
//         .enable(enable),
//         .out1(out1)
//     );

//     initial begin
//         clk = 0;
//         enable = 0;
//         //state = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;

//         #10;
//         enable = 1;
//         #10;
//            enable = 1;
//         #10;
//            enable = 1;
//         #10;
//            enable = 1;
//         #10;
//            enable = 1;
//         #10;
//            enable = 1;
//         #10;
//            enable = 1;
//         #10;
//            enable = 1;
//         #10;
//            enable = 1;
//         #10;
//            enable = 1;
//         #10;
//            enable = 1;
//         #10;
//            enable = 1;
//         #10;
//         //enable = 1;
//         #10;

//         // Add more test cases here

//         //$finish;
//     end

//     always begin
//         #5;
//         clk = ~clk;
//     end
// endmodule