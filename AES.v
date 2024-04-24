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
