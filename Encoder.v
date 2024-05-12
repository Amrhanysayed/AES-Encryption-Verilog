module Encoder(input [7:0]bin,output wire[11:0]bcd_out);
    integer i;   
    reg [11:0]bcd;
     always @(*)
        begin
            bcd = 0; //initialize bcd to zero.
            for (i = 0; i < 8; i = i+1) //run for 8 iterations
            begin
                bcd = {bcd[10:0],bin[7-i]}; //shifting and assign to bcd
                    
                //if a binary digit of 'bcd' is more than 4, add 3 to it.  
                if(i < 7 && bcd[3:0] > 4) 
                    bcd[3:0] = bcd[3:0] + 4'b0011;
                if(i < 7 && bcd[7:4] > 4)
                    bcd[7:4] = bcd[7:4] + 4'b0011;
                if(i < 7 && bcd[11:8] > 4)
                    bcd[11:8] = bcd[11:8] + 4'b0011;
            end
        end    
    assign bcd_out=bcd; //assign the output
endmodule

