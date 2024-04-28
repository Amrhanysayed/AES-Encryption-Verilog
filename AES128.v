module Cipher128(output [127:0] out);
    wire [127:0] state;
    wire [127:0] key;

    assign state = 128'h00112233445566778899aabbccddeeff;
    assign key = 128'h000102030405060708090a0b0c0d0e0f;

    wire [127:0] states [39:0] ;

    
    wire [0:1407] w;

    KeyExpansion128 uut(key, w);
 

    AddRoundKey ak1(state, w[0:127], states[0]);
    
    genvar i;
    generate
        for(i = 0; i < 9; i = i + 1) begin: round
            SubBytes sb(states[(i*4)], states[(i*4)+1]);
            ShiftRows sr(states[(i*4)+1], states[(i*4)+2]);
            MixColumns mc(states[(i*4)+2], states[(i*4)+3]);
            AddRoundKey ak(states[(i*4)+3], w[((i+1)*128)+:128], states[(i*4)+4]);
        end
    endgenerate

    SubBytes sb2(states[(8*4)+4], states[(8*4)+5]);
    ShiftRows sr2(states[(8*4)+5], states[(8*4)+6]);
    AddRoundKey ak2(states[(8*4)+6], w[1280+:128], states[(8*4)+7]);
    
    
    assign out = states[(8*4)+7];

endmodule

module InvCipher128(output [127:0] out);
    wire [127:0] state;
    wire [127:0] key;

    assign state = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
    assign key = 128'h000102030405060708090a0b0c0d0e0f;

    wire [127:0] states [39:0] ;

    
    wire [0:1407] w;

    KeyExpansion128 uut(key, w);
 

    AddRoundKey ak1(state, w[1280+:128], states[0]);
    
    genvar i;
    generate
        for(i = 0; i < 9; i = i + 1) begin: round
            
            InvShiftRows sr(states[(i*4)], states[(i*4)+1]);
            InvSubBytes sb(states[(i*4)+1], states[(i*4)+2]);
            AddRoundKey ak(states[(i*4)+2], w[((10-i-1)*128)+:128], states[(i*4)+3]);
            InvMixColumns mc(states[(i*4)+3], states[(i*4)+4]);
            
        end
    endgenerate


    InvShiftRows sr2(states[(8*4)+4], states[(8*4)+5]);
    InvSubBytes sb2(states[(8*4)+5], states[(8*4)+6]);
    
    AddRoundKey ak2(states[(8*4)+6], w[0:127], states[(8*4)+7]);
    
    
    assign out = states[(8*4)+7];

endmodule

module Cipher128_tb();
    wire [127:0] out;
    Cipher128 uut(out);
    initial begin
        #10;
        $display("out = %h", out);
    end

endmodule

module InvCipher128_tb();
    wire [127:0] out;
    InvCipher128 uut(out);
    initial begin
        #10;
        $display("out = %h", out);
    end

endmodule