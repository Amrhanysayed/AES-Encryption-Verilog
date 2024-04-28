module ShiftRows (input [0:127] state ,output wire [0:127] out);
      //first row
    assign out[0:7]=state[0:7];
    assign out[32:39]=state[32:39];
    assign out[64:71]=state[64:71];
    assign out[96:103]=state[96:103];
      //second row
    assign out[8:15]=state[40:47];
    assign out[40:47]=state[72:79];
    assign out[72:79]=state[104:111];
    assign out[104:111]=state[8:15];
      //third row
    assign out[80:87]=state[16:23];
    assign out[112:119]=state[48:55];
    assign out[16:23]=state[80:87];
    assign out[48:55]=state[112:119];
      //fourth row
    assign out[24:31]=state[120:127];
    assign out[56:63]=state[24:31];
    assign out[88:95]=state[56:63];
    assign out[120:127]=state[88:95];
endmodule

module InvShiftRows(input [0:127] state ,output wire [0:127] out);
      //first row
    assign out[0:7]=state[0:7];
    assign out[32:39]=state[32:39];
    assign out[64:71]=state[64:71];
    assign out[96:103]=state[96:103];
      //second row
    assign out[8:15]=state[104:111];
    assign out[40:47]=state[8:15];
    assign out[72:79]=state[40:47];
    assign out[104:111]=state[72:79];
      //third row
    assign out[16:23]=state[80:87];
    assign out[48:55]=state[112:119];
    assign out[80:87]=state[16:23];
    assign out[112:119]=state[48:55];
      //fourth row
    assign out[24:31]=state[56:63];
    assign out[56:63]=state[88:95];
    assign out[88:95]=state[120:127];
    assign out[120:127]=state[24:31];
endmodule
