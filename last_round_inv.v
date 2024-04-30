module last_round_inv(input[127:0] state, input [127:0] key,output wire[127:0] out);
wire[127:0]states[2:0];
InvShiftRows shift(state,states[0]);
InvSubBytes sub(states[0],states[1]);
AddRoundKey k(states[1],key ,states[2]);
assign out=states[2];
endmodule