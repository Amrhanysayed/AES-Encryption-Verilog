module ShiftRows (input [127:0] state ,output wire [127:0] out  );
    //first row
    assign out[7:0]=state[7:0];
    assign out[39:32]=state[39:32];
    assign out[71:64]=state[71:64];
    assign out[103:96]=state[103:96];
    //second row
    assign out[15:8]=state[47:40];
    assign out[47:40]=state[79:72];
    assign out[79:72]=state[111:104];
    assign out[111:104]=state[15:8];
    //third row
    assign out[87:80]=state[23:16];
    assign out[119:112]=state[55:48];
    assign out[23:16]=state[87:80];
    assign out[55:48]=state[119:112];
    //fourth row
    assign out[31:24]=state[127:120];
    assign out[63:56]=state[31:24];
    assign out[95:88]=state[63:56];
    assign out[127:120]=state[95:88];
endmodule 

module inverse_shift_Rows(input [127:0] state ,output wire [127:0] out);
    //first row
    assign out[7:0]=state[7:0];
    assign out[39:32]=state[39:32];
    assign out[71:64]=state[71:64];
    assign out[103:96]=state[103:96];
    //second row
    assign out[15:8]=state[111:104];
    assign out[47:40]=state[15:8];
    assign out[79:72]=state[47:40];
    assign out[111:104]=state[79:72];
    //third row
    assign out[23:16]=state[87:80];
    assign out[55:48]=state[119:112];
    assign out[87:80]=state[23:16];
    assign out[119:112]=state[55:48];
    //fourth row
    assign out[31:24]=state[63:56];
    assign out[63:56]=state[95:88];
    assign out[95:88]=state[127:120];
    assign out[127:120]=state[31:24];
endmodule

module decoder(input[2:0] word,output wire[6:0]HEX0,output wire[6:0]HEX1,output wire[6:0] HEX2);
reg HEX0_1[6:0];
reg HEX0_2[6:0];
reg HEX0_3[6:0];    
always @(*) 
begin 
if(word[0]==0)
     HEX0_1<=7'b1000000;
else if(word[0]==1)
     HEX0_1<=7'b1111001;
else if(word[0]==2)
     HEX0_1<=7'b0100100;
else if(word[0]==3)
     HEX0_1<=7'b0110000;
else if(word[0]==4)
     HEX0_1<=7'b0011001;
else if(word[0]==5)
     HEX0_1<=7'b0010010;
else if(word[0]==6)
     HEX0_1<=7'b0000010;
else if(word[0]==7)
     HEX0_1<=7'b0111000;
else if(word[0]==8)
     HEX0_1<=7'b0000000;
else if(word[0]==9)
     HEX0_1<=7'b0010000;
else 
     HEX0_1<=7'b1111111;
end
always @(*) 
begin 
if(word[1]==0)
     HEX0_2<=7'b1000000;
else if(word[1]==1)
     HEX0_2<=7'b1111001;
else if(word[1]==2)
     HEX0_2<=7'b0100100;
else if(word[1]==3)
     HEX0_2<=7'b0110000;
else if(word[1]==4)
     HEX0_2<=7'b0011001;
else if(word[1]==5)
     HEX0_2<=7'b0010010;
else if(word[1]==6)
     HEX0_2<=7'b0000010;
else if(word[1]==7)
     HEX0_2<=7'b0111000;
else if(word[1]==8)
     HEX0_2<=7'b0000000;
else if(word[1]==9)
     HEX0_2<=7'b0010000;
else 
     HEX0_2<=7'b1111111;
end
always @(*) 
begin 
if(word[2]==0)
     HEX0_3<=7'b1000000;
else if(word[2]==1)
     HEX0_3<=7'b1111001;
else if(word[2]==2)
     HEX0_3<=7'b0100100;
else if(word[2]==3)
     HEX0_3<=7'b0110000;
else if(word[2]==4)
     HEX0_3<=7'b0011001;
else if(word[2]==5)
     HEX0_3<=7'b0010010;
else if(word[2]==6)
     HEX0_3<=7'b0000010;
else if(word[2]==7)
     HEX0_3<=7'b0111000;
else if(word[2]==8)
     HEX0_3<=7'b0000000;
else if(word[2]==9)
     HEX0_3<=7'b0010000;
else 
     HEX0_3<=7'b1111111;
end
assign HEX0=HEX0_1;
assign HEX1=HEX0_2;
assign HEX2=HEX0_3;
endmodule