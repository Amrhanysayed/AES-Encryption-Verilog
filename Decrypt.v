

module Decrypt  #(parameter nk=4,parameter nr=10) ( input  [(nk*32)-1:0] key , input clk, input reset,input [127:0]state,input [0:((nr+1)*128)-1] w,output wire [127:0] out1);
    reg  [127:0]temp;
    wire [127:0] out;
    wire [127:0] out_lastround;
    //integer i=nr;
    integer i=-1;
    round_inverse r(temp,w[(((2*nr)-i)*128)+:128],out);
    always@ (posedge clk or posedge reset) 
    begin 
        // if(enable==1'b1)
        // begin
        if(reset==1'b1)
        begin
            //i<=nr;
            temp<=state^w[((nr)*128)+:128];
            i<=0;
        end
        else
        begin
            i <= i + 1;
            if(i==nr && state !== 'bx)
            begin
                temp<=state^w[((nr)*128)+:128];
            end
            else if(i == 2*nr && state !== 'bx)
            begin
                temp<=out_lastround;
            end
            else if(i > nr && i < 2*nr && state !== 'bx)
            begin
                temp<=out;
            end
        end
    end
    assign out1=temp;
    last_round_inv l(temp,w [0+:128],out_lastround);
endmodule


