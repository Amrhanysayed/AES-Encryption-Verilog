module AddRoundKey(input [127:0] state, input [127:0] key, output [127:0] out);
    assign out = state ^ key;
endmodule