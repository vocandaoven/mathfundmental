module Score (
    input clk, rst,
    input [31:0] score,
    output seg_clk,
    output seg_clrn,
    output seg_EN,
    output seg_out,
    output LED_EN
);

wire [31:0] clk_div;
reg [31:0] score_1;

clkdiv clkdiv_1 (.clk(clk), .rst(0), .div_res(clk_div));
Sseg_Dev Sseg_Dev_1 (.clk(clk), .start(clk_div[19]), .hexs(score_1), .points(8'hFF), .LEs(8'b00000000), .sclk(seg_clk), .sclrn(seg_clrn), .sout(seg_out), .EN(seg_EN));

always@ (posedge clk or posedge rst) begin
    if(rst) begin
        score_1 <= 32'b0;
    end
    else begin
        score_1 <= score;
    end 
end

endmodule