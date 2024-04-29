module last_round(input[127:0] state, input [127:0] key,output wire[127:0] out);
// wire [127:0]states[9:0];
// //wire [6:0]out_deoder[2:0];
// //reg [127:0] need;
// //wire [11:0]out_endoer;
// // AddRoundKey k(states[4],key,states[1]);
// // SubBytes s(states[1],states[2]);
// // ShiftRows r(states[2],states[3]);
// // Encoder e(states[3][7:0],out_endoer);
// // Decoder d(out_endoer,out_deoder[0],out_deoder[1],out_deoder[2]);
// always  @(*) begin : last_round  // level 01
// if(i==10)
// begin
// need=state;
// end

// end
// assign states[4]=need;
// assign out=states[3];
wire[127:0]states[2:0];
SubBytes w(state,states[0]);
ShiftRows w1(states[0],states[1]);
AddRoundKey q(states[1],key,states[2]);
assign out=states[2];
endmodule