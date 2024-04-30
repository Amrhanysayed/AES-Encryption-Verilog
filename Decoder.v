/*module Decoder(input[11:0] word,output wire[6:0]HEX0,output wire[6:0]HEX1,output wire[6:0] HEX2);
reg [6:0] HEX0_1;
reg [6:0] HEX0_2;
reg [6:0] HEX0_3;    
always @(*) 
begin 
if(word[3:0]==0)
     HEX0_1<=7'b1000000;
else if(word[3:0]==1)
     HEX0_1<=7'b1111001;
else if(word[3:0]==2)
     HEX0_1<=7'b0100100;
else if(word[3:0]==3)
     HEX0_1<=7'b0110000;
else if(word[3:0]==4)
     HEX0_1<=7'b0011001;
else if(word[3:0]==5)
     HEX0_1<=7'b0010010;
else if(word[3:0]==6)
     HEX0_1<=7'b0000010;
else if(word[3:0]==7)
     HEX0_1<=7'b0111000;
else if(word[3:0]==8)
     HEX0_1<=7'b0000000;
else if(word[3:0]==9)
     HEX0_1<=7'b0010000;
else 
     HEX0_1<=7'b1111111;
end
always @(*) 
begin 
if(word[7:4]==0)
     HEX0_2<=7'b1000000;
else if(word[7:4]==1)
     HEX0_2<=7'b1111001;
else if(word[7:4]==2)
     HEX0_2<=7'b0100100;
else if(word[7:4]==3)
     HEX0_2<=7'b0110000;
else if(word[7:4]==4)
     HEX0_2<=7'b0011001;
else if(word[7:4]==5)
     HEX0_2<=7'b0010010;
else if(word[7:4]==6)
     HEX0_2<=7'b0000010;
else if(word[7:4]==7)
     HEX0_2<=7'b0111000;
else if(word[7:4]==8)
     HEX0_2<=7'b0000000;
else if(word[7:4]==9)
     HEX0_2<=7'b0010000;
else 
     HEX0_2<=7'b1111111;
end
always @(*) 
begin 
if(word[11:8]==0)
     HEX0_3<=7'b1000000;
else if(word[11:8]==1)
     HEX0_3<=7'b1111001;
else if(word[11:8]==2)
     HEX0_3<=7'b0100100;
else if(word[11:8]==3)
     HEX0_3<=7'b0110000;
else if(word[11:8]==4)
     HEX0_3<=7'b0011001;
else if(word[11:8]==5)
     HEX0_3<=7'b0010010;
else if(word[11:8]==6)
     HEX0_3<=7'b0000010;
else if(word[11:8]==7)
     HEX0_3<=7'b0111000;
else if(word[11:8]==8)
     HEX0_3<=7'b0000000;
else if(word[11:8]==9)
     HEX0_3<=7'b0010000;
else 
     HEX0_3<=7'b1111111;
end
assign HEX0=HEX0_1;
assign HEX1=HEX0_2;
assign HEX2=HEX0_3;
endmodule*/