module Bullet_Judge (
    input clk,rst,
    input clk2,
    input [9:0] p_x,p_y,
    input [9:0] startp_x,startp_y,
    input [9:0] x,y,
    input collide,  //0 for my bullet collide, 1 for my bullet exist
    output reg [9:0] b_x,b_y,
    output mybullet_en,  //1 for my bullet can show on the VGA
    output mybullet_exist,  //1 for my bullet exist
    output reg [11:0] mybullet_rgb
);

    reg [9:0] b_x_next,b_y_next;
    reg EN_reg;
    reg collide_EN;  //1 for my bullet collide, 0 for my bullet exist
    wire [11:0] bullet_rgb;
    wire [9:0] col,row;
    
    assign row = y + 480 - b_y;
    assign col = x - b_x;
    
    bullet_mem Bullet (.clka(clk),.addra(col + row * 10),.douta(bullet_rgb));

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
    
    always @(posedge clk2 or posedge rst) begin
        if(rst)begin
            b_x_next <= startp_x;
            b_y_next <= startp_y;
            collide_EN <= 1'b0;
        end
        else if(b_y + 480 < p_y) begin
            b_x_next <= p_x + 10'd23;
            b_y_next <= p_y - 10'd40;
            collide_EN <= 1'b0;
        end
        else begin
            b_x_next <= b_x;
            b_y_next <= b_y - 1;
            if(~collide) collide_EN <= 1'b1;
        end
    end

    always @* begin
        mybullet_rgb <= bullet_rgb;
    end

    assign mybullet_en = (x >= b_x && x < b_x + 10 && y + 480 >= b_y && y + 480 < b_y + 40 && b_y > 480 & ~collide_EN);
    assign mybullet_exist = (collide_EN == 1'b0);
    
endmodule