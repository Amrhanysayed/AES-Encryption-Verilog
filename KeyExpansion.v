module keyexpansion(input[127:0] keyin,output[1407:0]keys);

     assign keys[1407:1280]=keyin;
     genvar i;
     generate

     for ( i=0;i<10 ;i=i+1 ) begin: keyexpansion_loop
     keyexpansion_ s(keys[(1407-(i*128)):(1280-(i*128))],keys[(1279-(i*128)):(1152-(i*128))],i);

     end
     endgenerate

endmodule

module keyexpansion_(input [127:0] keyin,output [127:0] keyout,input integer round);
     /// search for word in verilog
     wire[31:0] w0,w1,w2,w3,w3shifiting;
     wire[31:0] w0out,w1out,w2out,w3out;
     ///////////// input key ----> words 
     assign w0=keyin[127:96];
     assign w1=keyin[95:64];
     assign w2=keyin[63:32];
     assign w3=keyin[31:0];
     ///////////////////// w3shifiting ----> sending for subByte /////////////////////
     assign w3shifiting={w3[23:0], w3[31:24]};
     ///////////////////// w3shifiting ----> sending for subByte /////////////////////
     wire[31:0] submatrix;
          /// input    ///output 
     subBytes s(w3shifiting,submatrix) ;
     assign w0out=w0^submatrix^rcon(round);
     assign w1out=w1^w0out;
     assign w2out=w2^w1out;
     assign w3out=w3^w2out;

     assign keyout[127:96]=w0out;
     assign keyout[95:64]=w1out;
     assign keyout[63:32]=w2out;
     assign keyout[31:0]=w3out;

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
          default: rcon=32'h00_00_00_00; 
          endcase
     endfunction


endmodule

