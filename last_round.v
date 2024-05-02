module last_round(input[127:0] state, input [127:0] key,output wire[127:0] out);

wire[127:0]states[2:0];
SubBytes w(state,states[0]);
ShiftRows w1(states[0],states[1]);
AddRoundKey q(states[1],key,states[2]);
assign out=states[2];
endmodule