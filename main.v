 module main(input[2:0]SW,output wire[6:0] HEX0,output wire[6:0] HEX1,output wire[6:0] HEX2,input clk_128,input clk_192,input clk_256,output wire[1:0] LEDR);

/////////////////////////////////////the main need to change /////////////////////////////////////////////////





// ///// run 3100 ---> clocck 100 /// AES 256
// ///// run 2100 ---> clocck 100 /// AES 128
// wire [127:0]out_main; wire [127:0]out_main_256; wire [127:0] out_desipher;
// wire [127:0] out_desipher_192; wire [127:0] out_desipher_256;
// integer counter_128=0;
// integer counter_192=0;
// integer counter_256=0;
// //decipher
// wire [127:0]main_disipher_input;
// wire [127:0]main_disipher_input_192;
// wire [127:0]main_disipher_input_256;

// reg  [127:0]in_disipher128;
// reg  [127:0]in_disipher192;
// reg  [127:0]in_disipher256;
// //cipher 128
// wire [127:0] state;
// wire [127:0] temp_out_main_cipher;
// wire [127:0] temp_out_main_decipher;
// wire [127:0] key_128;
// wire [127:0] state_128;
// //////////////////////////////////////////////256///////////////////////////////////////////////
// wire [127:0] state_256;
// wire [255:0] key_256;
// wire [127:0] temp_out_main_cipher_256;
// wire [127:0] temp_out_main_decipher_256;
// //encoder
// wire [7:0] encoder_input;
// wire [7:0] encoder_input_192;
// wire [7:0] encoder_input_256;
// //decoder
// wire [11:0]input_decoder;
// wire [11:0]input_decoder_192;
// wire [11:0]input_decoder_256;
// // reg  [127:0] bit192;
// // wire [127:0] state_192;
// // reg  [127:0] bit256;
// // wire [127:0] state_256;
// assign state = 128'h00112233445566778899aabbccddeeff;
// assign key_128 = 128'h000102030405060708090a0b0c0d0e0f;
// assign key_192 = 192'h000102030405060708090a0b0c0d0e0f1011121314151617;
// assign key_256 = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;

// //128 bit//
// always@(posedge clk_128)
// begin
    
//        if(counter_128==11)
//             begin
//                 in_disipher128<=out_main;
//             end
//         else
//             counter_128=counter_128+1;
     
//      // else if(SW[1])begin

//      // end
//      // else if(SW[2]) begin
//      //      if(counter_256>=15)
//      //        begin
//      //            in_disipher256<=out_main_256;
//      //            counter_256=counter_256+1;
//      //        end
//      //    else
//      //    begin
//      //        counter_256=counter_256+1;
//      //    end
//      end
// //192 bit//
// /*always@(posedge clk_192)
// begin
//        if(i==11)
//             begin
//                 in_disipher128<=out_main;
//             end
//         else
//             i=i+1;
// end*/
// //256 //
// always@(posedge clk_256)
// begin
//        if(counter_256>=15)
//             begin
//                 in_disipher256<=out_main_256;
//                 counter_256=counter_256+1;
//             end
//         else
//         begin
//             counter_256=counter_256+1;
//         end
// end
// ////////////////////////////////////////////////////////////////////cipher128////////////////////////////////////////////////////////////
// assign state_128=state;

// Cipher128 c(temp_out_main_cipher,clk_128,state_128,key_128);
// assign out_main=temp_out_main_cipher;
// ////////////////////////////////////////////////////////////////////cipher192////////////////////////////////////////////////////////////

// ////////////////////////////////////////////////////////////////////cipher256////////////////////////////////////////////////////////////
// assign state_256=state;
// Cipher256 c_256(temp_out_main_cipher_256,clk_256,state_256,key_256);
// assign out_main_256=temp_out_main_cipher_256;
// //////////////////////////////////////////////////////////////decipher 128//////////////////////////////////////////////////////////////////
// assign main_disipher_input=in_disipher128;
// InvCipher128 s(temp_out_main_decipher,clk_128,main_disipher_input,key_128);
// assign out_desipher=temp_out_main_decipher;
// assign encoder_input=out_main[7:0];
// //////////////////////////////////////////////////////////////decipher 192//////////////////////////////////////////////////////////////////

// //////////////////////////////////////////////////////////////decipher 256//////////////////////////////////////////////////////////////////

// assign main_disipher_input_256=in_disipher256;
// InvCipher256 i(temp_out_main_decipher_256,clk_256,main_disipher_input_256,key_256);
// assign out_desipher_256=temp_out_main_decipher_256;
// assign encoder_input_256=out_main_256[7:0];
// /////////////////////////////////////////////////////////Encoder////////////////////////////////////////////////////
// Encoder E(encoder_input,input_decoder);
// // Encoder E1(encoder_input_192,input_decoder);
// // Encoder E2(encoder_input_256,input_decoder);
// ////////////////////////////////////////////////////Decoder//////////////////////////////////////////////////////////////////
// Decoder d1(input_decoder,HEX0,HEX1,HEX2);
// // Decoder d2(input_decoder,HEX0,HEX1,HEX2);
// // Decoder d3(input_decoder,HEX0,HEX1,HEX2);

///////////////////////////////////////////////////////flag check///////////////////////////////////////////////////
reg ledr;
always @(*)
begin
     if(state==temp_out_main_decipher)
          ledr=1;
     else 
          ledr=0;  
end
assign LEDR[0]=ledr;
assign LEDR[1]=ledr;

 endmodule