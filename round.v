module round(input[127:0] state, input [127:0] key ,output wire[127:0] out);
wire[127:0]states[3:0];
SubBytes w(state,states[0]);
ShiftRows w1(states[0],states[1]);
MixColumns w2(states[1],states[2]);
AddRoundKey q(states[2],key,states[3]);
assign out=states[3];

endmodule
