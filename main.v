 module main(input[3:0]SW,input clk,output wire[6:0] HEX0,output wire[6:0] HEX1,output wire[6:0] HEX2,output wire[1:0] LEDR,output wire[127:0]out_main,output wire[11:0] test_encorder); 

////////////////////////////////////////////////////// new main  ////////////////////////////////////////////////////////////////
/*
SW[0] = 128 bit
SW[1] = 192 bit
SW[2] = 256 bit
SW[3] = reset
output wire[11:0] test_encorder ---> for testing only
output wire[127:0]out_main ---> for testing only
*/

localparam nk_128 =4 ;
localparam nr_128 =10 ;
localparam nk_192 =6 ;
localparam nr_192 =12 ;
localparam nk_256 =8 ;
localparam nr_256 =14 ;
integer counter=0;
wire [127:0]out_128;
wire [127:0]out_192;
wire [127:0]out_256;
wire [127:0]out_desipher_128;
wire [127:0]out_desipher_192;
wire [127:0]out_desipher_256;
// reg [127:0]out_main_decipher_reg;
//wire [127:0]out_main;
reg [127:0]out_main_reg;
//////////////////////////////////// enables //////////////////////////////////////////////////
integer enable_Decipher_128;
integer enable_Decipher_192;
integer enable_Decipher_256;
//////////////////////////////////////states&&keys///////////////////////////////////////////////////
wire [127:0]key_128;
wire [191:0]key_192;
wire [255:0]key_256;
wire [127:0]state;
assign state = 128'h00112233445566778899aabbccddeeff;
assign key_128 = 128'h000102030405060708090a0b0c0d0e0f;
assign key_192 = 192'h000102030405060708090a0b0c0d0e0f1011121314151617;
assign key_256 = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
initial begin
     enable_Decipher_128=0;
     enable_Decipher_192=0;   
     enable_Decipher_256=0;
end


 ///////////////////////////////////////////////Encipher///////////////////////////////////////////////
Encrypt #(nk_128, nr_128) e128(key_128,clk,state,out_128);
Encrypt #(nk_192, nr_192) e192(key_192,clk,state,out_192);
Encrypt #(nk_256, nr_256) e256(key_256,clk,state,out_256);
/////////////////////////////////////////////Decipher///////////////////////////////////////////////
Decrypt #(nk_128, nr_128) d128(key_128,clk,enable_Decipher_128,out_main,out_desipher_128);
Decrypt #(nk_192, nr_192) d192(key_192,clk,enable_Decipher_192,out_main,out_desipher_192);
Decrypt #(nk_256, nr_256) d256(key_256,clk,enable_Decipher_256,out_main,out_desipher_256);
always@(posedge clk)
begin
   if(SW[3]==1)
   begin

     enable_Decipher_128=0;
     enable_Decipher_192=0;   
     enable_Decipher_256=0;
     out_main_reg=0;
     counter=0;
   end

    else if(SW[0]==1)
    begin
    
     if(counter<=11)
     begin
      out_main_reg=out_128;
      if(counter==11)
          begin
          enable_Decipher_128=1;
          end
     end
      else if(counter>11)
     begin
          out_main_reg=out_desipher_128;
             
     end
         
   
     end
    
    else if(SW[1]==1)
    begin
     if(counter<=13)
     begin
      out_main_reg=out_192;
      if(counter==13)
          begin
          enable_Decipher_192=1;
          end
     end
        else if(counter>13)
     begin
         
        out_main_reg=out_desipher_192;
     end
    
    end
     else if(SW[2]==1)
     begin
           if(counter<=15)
     begin
     out_main_reg=out_256;
     if(counter==15)
          begin
          enable_Decipher_256=1;
          end
     end
        else if(counter>15)
     begin
        
            out_main_reg=out_desipher_256;  
       end
     end  

  counter=counter+1;
  
     
     

end
assign out_main=out_main_reg;
/////////////////////////////////////////////Encorder && decoder ///////////////////////////////////////////////
wire [11:0] Output_Encoder;
assign test_encorder=Output_Encoder;
Encoder en1 (out_main[7:0],Output_Encoder);
Decoder de1 (Output_Encoder,HEX0,HEX1,HEX2);




///////////////////////////////////////////////////////flag check///////////////////////////////////////////////////

reg ledr;
always @(posedge clk)
begin
     if(state==out_main&&counter>nr_128)
          ledr=1;
     else 
          ledr=0;  
end
assign LEDR[0]=ledr;
assign LEDR[1]=ledr;

endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


module main_tb;
  // Inputs
  reg[2:0] SW;
  reg clk;

  // Outputs
  wire [6:0] HEX0;
  wire [6:0] HEX1;
  wire [6:0] HEX2;
  wire [1:0] LEDR;
  wire  [127:0]out_main;
     wire [11:0] test_encorder;
  // Instantiate the Unit Under Test (UUT)
 main uut (
    .SW(SW),
    .clk(clk),
    .HEX0(HEX0),
    .HEX1(HEX1),
    .HEX2(HEX2),
    .LEDR(LEDR),
     .out_main(out_main),
     .test_encorder(test_encorder)
  );

  // Clock generator
  always #5 clk = ~clk;
  integer i;
 integer j;
  // Test sequence
  initial begin
    // Initialize Inputs
   SW = 0;
    clk = 0;

    //Wait for 100 clock cycles
    for ( i = 0; i < 100; i = i + 1) begin
      #5;
      clk = ~clk;
    end

    
    //// 128 bit
    SW = 1;
    // Wait for 11 clock cycles
   
    for ( j = 0; j < 22; j = j + 1) begin
      #5;
      clk = ~clk;
    end

      //// 192 bit
//     SW = 2;
//     // Wait for 13 clock cycles
//     for ( j = 0; j < 13; j = j + 1) begin
//       #5;
//       clk = ~clk;
//     end

 //// 256 bit
//     // Test SW = 2
//     SW = 4;
//     // Wait for 15 clock cycles
//     for ( j = 0; j < 15; j = j + 1) begin
//       #5;
//       clk = ~clk;
//     end
$monitor("%b %h %h %h %b %h %h ",SW,HEX0,HEX1,HEX2,LEDR,out_main,test_encorder);
   
  end

endmodule