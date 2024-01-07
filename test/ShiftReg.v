module ShiftReg
#(parameter BIT_WIDTH = 8)(
    input       clk,
    input       shiftn_loadp,
    input       shift_in,
    input [BIT_WIDTH:0] par_in,
    output[BIT_WIDTH:0] Q
);

 reg [BIT_WIDTH:0] Q_reg = 0;
 always@(posedge clk) begin
    if(shiftn_loadp) begin
        Q_reg = par_in;
    end else begin
        Q_reg = {shift_in, Q_reg[BIT_WIDTH:1]};
    end
end
assign Q = Q_reg;

endmodule
