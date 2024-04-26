module MixColumns(input [127:0] state_in, output [127:0] state_out);

     function [7:0]mul2;
          input [7:0] a; // input

          if(a[7] == 1)
          begin
               mul2 = (a << 1) ^ 8'h1b;
          end
          else
          begin
               mul2 = a << 1;
          end
     endfunction

     function [7:0]mul3;
        input [7:0] a; // input
          begin
               mul3 = mul2(a) ^ a;
          end
     endfunction

     genvar i;
     generate
     for ( i=0;i<4 ;i=i+1 ) begin: setter_loop

          assign state_out[(31+(i*32)):(24+(i*32))] = mul2(state_in[(31+(i*32)):(24+(i*32))]) ^ mul3(state_in[(23+(i*32)):(16+(i*32))]) ^ state_in[(15+(i*32)):(8+(i*32))] ^ state_in[(7+(i*32)):(0+(i*32))];
          
          assign state_out[(23+(i*32)):(16+(i*32))] = state_in[(31+(i*32)):(24+(i*32))] ^ mul2(state_in[(23+(i*32)):(16+(i*32))]) ^ mul3(state_in[(15+(i*32)):(8+(i*32))]) ^ state_in[(7+(i*32)):(0+(i*32))];
          
          assign state_out[(15+(i*32)):(8+(i*32))]= state_in[(31+(i*32)):(24+(i*32))] ^ state_in[(23+(i*32)):(16+(i*32))] ^ mul2(state_in[(15+(i*32)):(8+(i*32))]) ^ mul3(state_in[(7+(i*32)):(0+(i*32))]);
          
          assign state_out[(7+(i*32)):(0+(i*32))] = mul3(state_in[(31+(i*32)):(24+(i*32))]) ^ state_in[(23+(i*32)):(16+(i*32))] ^ state_in[(15+(i*32)):(8+(i*32))] ^ mul2(state_in[(7+(i*32)):(0+(i*32))]);

     end
     endgenerate

endmodule

module InvMixColumns(input [127:0] state_in, output [127:0] state_out);

    function [7:0]mul2;
          input [7:0] a; // input

          if(a[7] == 1)
          begin
               mul2 = (a << 1) ^ 8'h1b;
          end
          else
          begin
               mul2 = a << 1;
          end
     endfunction

     function [7:0]mul;
        input [7:0] a; // input
        input [7:0] b; // input
        if(b == 8'h0e) begin
            mul = mul2(mul2(mul2(a))) ^ mul2(a) ^ mul2(a) ^ mul2(a);
        end
        else if(b == 8'h0b) begin
            mul = mul2(mul2(mul2(a))) ^ mul2(a) ^ a;
        end
        else if(b == 8'h0d) begin
            mul = mul2(mul2(mul2(a))) ^ mul2(a) ^ mul2(a) ^ a;
        end
        else if(b == 8'h09) begin
            mul = mul2(mul2(mul2(a))) ^ a;
        end
     endfunction



     genvar i;
     generate
     for ( i=0;i<4 ;i=i+1 ) begin: invsetter_loop

          assign state_out[(31+(i*32)):(24+(i*32))] = mul(state_in[(31+(i*32)):(24+(i*32))], 8'h0e) ^ mul(state_in[(23+(i*32)):(16+(i*32))], 8'h0b) ^ mul(state_in[(15+(i*32)):(8+(i*32))], 8'h0d) ^ mul(state_in[(7+(i*32)):(0+(i*32))], 8'h09);
          
          assign state_out[(23+(i*32)):(16+(i*32))] = mul(state_in[(31+(i*32)):(24+(i*32))], 8'h09) ^ mul(state_in[(23+(i*32)):(16+(i*32))], 8'h0e)^ mul(state_in[(15+(i*32)):(8+(i*32))], 8'h0b) ^ mul(state_in[(7+(i*32)):(0+(i*32))], 8'h0d);
          
          assign state_out[(15+(i*32)):(8+(i*32))]= mul(state_in[(31+(i*32)):(24+(i*32))], 8'h0d) ^ mul(state_in[(23+(i*32)):(16+(i*32))], 8'h09) ^ mul(state_in[(15+(i*32)):(8+(i*32))], 8'h0e) ^ mul(state_in[(7+(i*32)):(0+(i*32))], 8'h0b);
          
          assign state_out[(7+(i*32)):(0+(i*32))] = mul(state_in[(31+(i*32)):(24+(i*32))], 8'h0b) ^ mul(state_in[(23+(i*32)):(16+(i*32))], 8'h0d) ^ mul(state_in[(15+(i*32)):(8+(i*32))], 8'h09) ^ mul(state_in[(7+(i*32)):(0+(i*32))], 8'h0e);

     end
     endgenerate

endmodule