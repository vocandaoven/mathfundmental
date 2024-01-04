`timescale 1ns/1ps

module tb();
reg clk,rst,clk2;
reg [9:0] p_x,p_y,startp_x,startp_y;
reg [9:0] x,y;
reg boom;
wire [9:0] b_x,b_y;
wire [11:0] mybullet_rgb;
wire mybullet_en;

Bullet_Judge gg(
    .clk(clk),
    .rst(rst),
    .clk2(clk2),
    .p_x(p_x),
    .p_y(p_y),
    .startp_x(startp_x),
    .startp_y(startp_y),
    .x(x),.y(y),
    .boom(boom),
    .b_x(b_x),.b_y(b_y),
    .mybullet_rgb(mybullet_rgb),
    .mybullet_en(mybullet_en)
);

initial begin
    clk = 0;
    clk2 = 0;
    rst = 1;
    p_x = 10'd270;
    p_y = 10'd430 + 10'd480;
    startp_x = 10'd270;
    startp_y = 10'd430 + 10'd520;
    #5;
    rst = 0;
    boom = 0;
end


    always #10 clk <= ~clk;
    always #20 clk2 <= ~clk2;

endmodule