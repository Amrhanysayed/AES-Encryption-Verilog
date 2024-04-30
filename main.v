module main(input[2:0]SW,output wire HEX0,output wire HEX1,output wire HEX2,input clk,output wire [127:0]out_main,output wire [127:0] out_desipher);
integer i=0;
integer j=0;
reg  [127:0]in_disipher;
wire [127:0]main_disipher_input;
wire [127:0] state;
wire [127:0] temp_out_main_cipher;
wire [127:0] temp_out_main_decipher;
wire [127:0] key_128;
reg  [127:0] bit128;
wire [127:0] state_128;
wire [7:0] encoder_input;
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
  
    reg [11:0]bcd;
     always @(encoder_input)
        begin
            bcd = 0; //initialize bcd to zero.
            for (j = 0; j < 8; j = j+1) //run for 8 iterations
            begin
                bcd = {bcd[10:0],encoder_input[7-i]}; //shifting and assign to bcd
                    
                //if a binary digit of 'bcd' is more than 4, add 3 to it.  
                if(i < 7 && bcd[3:0] > 4) 
                    bcd[3:0] = bcd[3:0] + 3;
                if(i < 7 && bcd[7:4] > 4)
                    bcd[7:4] = bcd[7:4] + 3;
                if(i < 7 && bcd[11:8] > 4)
                    bcd[11:8] = bcd[11:8] + 3;  
            end
        end    
    assign input_decoder=bcd; //assign the output
    
endmodule