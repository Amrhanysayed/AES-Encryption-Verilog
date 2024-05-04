

module Decrypt  #(parameter nk=4,parameter nr=10) ( input  [(nk*32)-1:0] key , input clk, input  enable,input [127:0]state,input [0:((nr+1)*128)-1] w,output wire [127:0] out1);
    reg  [127:0] state0;
    reg  [127:0]temp;
    wire [127:0] out;
    wire [127:0] out_lastround;
    integer i=nr;
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
        else
        begin
            i = nr;
            state0 <= 'bx;
            temp <= 'bx;
        end
    end
    assign out1=temp;
    last_round_inv l(state0,w [((i)*128)+:128],out_lastround);
endmodule


