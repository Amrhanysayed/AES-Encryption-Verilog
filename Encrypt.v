module Encrypt  #(parameter nk=4,parameter nr=10) (input  [(nk*32)-1:0] key,input clk, input  reset,input [127:0]state,input [0:((nr+1)*128)-1] w,output wire [127:0] out1);
    //;
    //wire [127:0] state;
    reg  [127:0] state0;
    reg  [127:0]temp;
    // wire [127:0] key;
    wire [127:0] out;
    wire [127:0] out_lastround;
    integer i=-1;
    //// for testing only /////////////////////////////////////////
    // assign state = 128'h00112233445566778899aabbccddeeff;
    // assign key = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
    //////////////////////////////////////////////////////////////
    
   // keyExpansion #(nk, nr) key_expansion_inst (key,w);
    round x(state0, w[((i+1)*128)+:128],out);   
 always@ (posedge clk or posedge reset)
    begin 
        if(reset==1'b1)
        begin
            i=-1;
            state0 <= 'bx;
            temp <= 'bx;
        end
        else
        begin
            if(i==-1 && state !== 'bx)
            begin
                state0<=state^w[0:127];
                temp=state^w[0:127];
                i=i+1;
            end
            else if(i < (nr-1) && state !== 'bx)
            begin
            state0<=out;  
            temp<=out;
            i=i+1;
            end
            else if(i == (nr-1) && state !== 'bx)
            begin
                temp<=out_lastround;
                i=i+1;
            end
        end
    end
    assign out1=temp;
    last_round xs(state0,w[((i+1)*128)+:128],out_lastround);
    //assign temp=out_lastround;
endmodule

