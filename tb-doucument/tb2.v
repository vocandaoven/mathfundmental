`timescale 1ns/1ps

module tb2();
reg clk,rst,clk2;
reg [9:0] x,y;
reg boom;
wire [9:0] e_x,e_y;
wire [11:0] rgb;
wire e_en;

Enemyplane_Judge gg(
    .clk(clk),
    .rst(rst),
    .clk_move(clk2),
    .x(x),.y(y),
    .boom(boom),
    .enemy_x(e_x),.enemy_y(e_y),
    .enemy_en(e_en),
    .rgb(rgb)
);

initial begin
    clk = 0;
    clk2 = 0;
    rst = 1;
    #5;
    rst = 0;
    boom = 0;

end

    always #10 clk <= ~clk;
    always #20 clk2 <= ~clk2;

endmodule