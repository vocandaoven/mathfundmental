    module Mux4to1b4 (
        input  [1:0] S,
        input  [3:0] D0,
        input  [3:0] D1,
        input  [3:0] D2,
        input  [3:0] D3,
        output [3:0] Y
    );
    wire w1,w2,w3,w4;
    assign w1 = ~S[0] & ~S[1];
    assign w2 = S[0] & ~S[1];
    assign w3 = ~S[0] & S[1];
    assign w4 = S[0] & S[1];
    assign Y[0] = (D0[0] & w1) | (D1[0] & w2) | (D2[0] & w3) | (D3[0] & w4);
    assign Y[1] = (D0[1] & w1) | (D1[1] & w2) | (D2[1] & w3) | (D3[1] & w4);
    assign Y[2] = (D0[2] & w1) | (D1[2] & w2) | (D2[2] & w3) | (D3[2] & w4);
    assign Y[3] = (D0[3] & w1) | (D1[3] & w2) | (D2[3] & w3) | (D3[3] & w4);
endmodule