

module KeyExpansion192(input[191:0] keyin,output[2495:0]keys);

     assign keys[2495:2304]=keyin;
     genvar i;
     generate

     for ( i=0;i<12 ;i=i+1 ) begin: keyexpansion_loop
     keyExpansion_192 s(keys[(2495-(i*192)):(2304-(i*192))],keys[(2303-(i*192)):(2112-(i*192))],i);

     end
     endgenerate

endmodule

module keyExpansion_192(input [191:0] keyin,output [191:0] keyout,input integer round);
     /// search for word in verilog
     wire[31:0] w0,w1,w2,w3,w4,w5,w5shifiting;
     wire[31:0] w0out,w1out,w2out,w4out,w3out,w5out;
     ///////////// input key ----> words 
     assign w0=keyin[191:160];
     assign w1=keyin[159:128];
     assign w2=keyin[127:96];
     assign w3=keyin[95:64];
     assign w4=keyin[63:32];
     assign w5=keyin[31:0];
     ///////////////////// w3shifiting ----> sending for subByte /////////////////////
     assign w5shifiting={w5[23:0], w5[31:24]};
     ///////////////////// w3shifiting ----> sending for subByte /////////////////////
     wire[31:0] submatrix;
                /// input    ///output 
     subBytes s(w5shifiting,submatrix) ;
     assign w0out=w0^submatrix^rcon(round);
     assign w1out=w1^w0out;
     assign w2out=w2^w1out;
     assign w3out=w3^w2out;
     assign w4out=w4^w3out;
     assign w5out=w5^w4out;

     assign keyout[191:160]=w0out;
     assign keyout[159:128]=w1out;
     assign keyout[127:96]=w2out;
     assign keyout[95:64]=w3out;
     assign keyout[63:32]=w4out;
     assign keyout[31:0]=w5out;

     ///////////////////////////////////////////////////
     function [31:0]rcon ;
     input integer ro   ;
          case (ro)
          0:rcon=32'h01_00_00_00;
          1:rcon=32'h02_00_00_00;
          2:rcon=32'h04_00_00_00;
          3:rcon=32'h08_00_00_00;
          4:rcon=32'h10_00_00_00;
          5:rcon=32'h20_00_00_00;
          6:rcon=32'h40_00_00_00;
          7:rcon=32'h80_00_00_00;
          8:rcon=32'h1b_00_00_00;
          9:rcon=32'h36_00_00_00;
          10: rcon = 32'h6c_00_00_00;
          11: rcon = 32'hd8_00_00_00;
          default: rcon=32'h00_00_00_00; 
          endcase
     endfunction


endmodule
