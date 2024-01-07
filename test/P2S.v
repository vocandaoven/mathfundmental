module P2S
#(parameter BIT_WIDTH = 8)(
    input clk,
    input start,
    input[BIT_WIDTH-1:0] par_in,
    output sclk,
    output sclrn,
    output sout,
    output EN
);

    wire[BIT_WIDTH:0] Q;
    wire finish;
    wire q;

    SR_Latch m0 (.S(start & finish),.R(~finish),.Q(q),.Qn()); // Your code here

    ShiftReg #(.BIT_WIDTH(BIT_WIDTH)) m1 (.shift_in(~q),.shiftn_loadp(q),.clk(clk),.par_in({1'b0,par_in}),.Q(Q)); // Your code here
    assign finish = &Q[BIT_WIDTH:1];// Your code here

    assign EN = !start && finish;
    assign sclk = finish | ~clk;
    assign sclrn = 1'b1;
    assign sout = Q[0];

endmodule
