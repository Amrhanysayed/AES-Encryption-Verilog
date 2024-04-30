module main(input[2:0]SW,output wire[6:0] HEX0,output wire[6:0] HEX1,output wire[6:0] HEX2,input clk,output wire [127:0]out_main,output wire [127:0] out_desipher);
integer i=0;
integer j;
//decipher
reg  [127:0]in_disipher;
wire [127:0]main_disipher_input;
//cipher 128
wire [127:0] state;
wire [127:0] temp_out_main_cipher;
wire [127:0] temp_out_main_decipher;
wire [127:0] key_128;
reg  [127:0] bit128;
wire [127:0] state_128;
//encoder
wire [7:0] encoder_input;
//decoder
wire [11:0]input_decoder;
// reg  [127:0] bit192;
// wire [127:0] state_192;
// reg  [127:0] bit256;
// wire [127:0] state_256;
assign state = 128'h00112233445566778899aabbccddeeff;
assign key_128 = 128'h000102030405060708090a0b0c0d0e0f;
always@(posedge clk)
begin
       if(i==11)
            begin
                in_disipher<=out_main;
            end
        else
            i=i+1;
end
assign state_128=state;
assign main_disipher_input=in_disipher;
Cipher128 c(temp_out_main_cipher,clk,state_128,key_128);
assign out_main=temp_out_main_cipher;
InvCipher128 s(temp_out_main_decipher,clk,main_disipher_input,key_128);
assign out_desipher=temp_out_main_decipher;
assign encoder_input=out_main[7:0];
    reg [11:0]bcd;
     always @(encoder_input or posedge clk)
        begin
          
            bcd = 0; //initialize bcd to zero.
            for (j = 0; j < 8; j = j+1) //run for 8 iterations
            begin
               
               bcd = {bcd[10:0],encoder_input[7-j]}; //shifting and assign to bcd
                    
                //if a binary digit of 'bcd' is more than 4, add 3 to it.  
                if(j < 7 && bcd[3:0] > 4&&bcd[3:0]!=='bx) 
                    bcd[3:0] = bcd[3:0] + 3;
                if(j < 7 && bcd[7:4] > 4&&bcd[7:4]!=='bx)
                    bcd[7:4] = bcd[7:4] + 3;
                if(j < 7 && bcd[11:8] > 4&&bcd[11:8]!=='bx)
                    bcd[11:8] = bcd[11:8] + 3;  
               
            
          end
        end    
assign input_decoder=bcd; //assign the output
reg [6:0] HEX0_1;
reg [6:0] HEX0_2;
reg [6:0] HEX0_3;    
always @(input_decoder or posedge clk)  
begin 
   
if(input_decoder[3:0]==0)
     HEX0_1<=7'b1000000;
else if(input_decoder[3:0]==1)
     HEX0_1<=7'b1111001;
else if(input_decoder[3:0]==2)
     HEX0_1<=7'b0100100;
else if(input_decoder[3:0]==3)
     HEX0_1<=7'b0110000;
else if(input_decoder[3:0]==4)
     HEX0_1<=7'b0011001;
else if(input_decoder[3:0]==5)
     HEX0_1<=7'b0010010;
else if(input_decoder[3:0]==6)
     HEX0_1<=7'b0000010;
else if(input_decoder[3:0]==7)
     HEX0_1<=7'b0111000;
else if(input_decoder[3:0]==8)
     HEX0_1<=7'b0000000;
else if(input_decoder[3:0]==9)
     HEX0_1<=7'b0010000;
else 
     HEX0_1<=7'b1111111;
    
end
always @(input_decoder or posedge clk) 
begin 
    
if(input_decoder[7:4]==0)
     HEX0_2<=7'b1000000;
else if(input_decoder[7:4]==1)
     HEX0_2<=7'b1111001;
else if(input_decoder[7:4]==2)
     HEX0_2<=7'b0100100;
else if(input_decoder[7:4]==3)
     HEX0_2<=7'b0110000;
else if(input_decoder[7:4]==4)
     HEX0_2<=7'b0011001;
else if(input_decoder[7:4]==5)
     HEX0_2<=7'b0010010;
else if(input_decoder[7:4]==6)
     HEX0_2<=7'b0000010;
else if(input_decoder[7:4]==7)
     HEX0_2<=7'b0111000;
else if(input_decoder[7:4]==8)
     HEX0_2<=7'b0000000;
else if(input_decoder[7:4]==9)
     HEX0_2<=7'b0010000;
else 
     HEX0_2<=7'b1111111;

end
always @(input_decoder or posedge clk) 
begin 
   
if(input_decoder[7:0]!='bx&&input_decoder[11:8]==0)
     HEX0_3<=7'b1000000;
else if(input_decoder[11:8]==1)
     HEX0_3<=7'b1111001;
else if(input_decoder[11:8]==2)
     HEX0_3<=7'b0100100;
else if(input_decoder[11:8]==3)
     HEX0_3<=7'b0110000;
else if(input_decoder[11:8]==4)
     HEX0_3<=7'b0011001;
else if(input_decoder[11:8]==5)
     HEX0_3<=7'b0010010;
else if(input_decoder[11:8]==6)
     HEX0_3<=7'b0000010;
else if(input_decoder[11:8]==7)
     HEX0_3<=7'b0111000;
else if(input_decoder[11:8]==8)
     HEX0_3<=7'b0000000;
else if(input_decoder[11:8]==9)
     HEX0_3<=7'b0010000;
else 
     HEX0_3<=7'b1111111;
    
end
assign HEX0=HEX0_1;
assign HEX1=HEX0_2;
assign HEX2=HEX0_3;
endmodule