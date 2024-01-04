module Bullet_Judge (
    input clk,rst,
    input clk2,
    input [9:0] p_x,p_y,
    input [9:0] startp_x,startp_y,
    input [9:0] x,y,
    input boom,
    output reg [9:0] b_x,b_y,
    output mybullet_en,
    output reg [11:0] mybullet_rgb
);

    reg [9:0] b_x_next,b_y_next;
    reg EN_reg;

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            b_x <= startp_x;
            b_y <= startp_y;
        end
        else begin
            b_x <= b_x_next;
            b_y <= b_y_next;
        end
    end
    
    always @(posedge clk2 or posedge rst)begin
        if(rst)begin
            b_x_next <= startp_x;
            b_y_next <= startp_y;
        end
        else if(b_y + 480 < p_y)begin
            b_x_next <= p_x + 10'd23;
            b_y_next <= p_y + 10'd40;
        end
        else begin
            b_x_next <= b_x;
            b_y_next <= b_y - 1;
        end
    end

    always @* begin
        mybullet_rgb <= 12'b111111111111;
    end

    assign mybullet_en = (x >= b_x && x < b_x + 10 && y + 480 >= b_y && y + 480 < b_y + 40 && b_y > 480);
    
endmodule