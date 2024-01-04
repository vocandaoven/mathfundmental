module Enemy_Bullet_Judge (
    input clk,rst,
    input clk2,
    input [9:0] ep_x,ep_y,
    input [9:0] startep_x,startep_y,
    input [9:0] x,y,
    input boom,
    output reg [9:0] eb_x,eb_y,
    output enemy_bullet_en,
    output reg [11:0] enemy_bullet_rgb
);

    reg eb_x_next,eb_y_next;
    reg EN_reg;

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            eb_x <= startep_x;
            eb_y <= startep_y;
        end
        else begin
            eb_x <= eb_x_next;
            eb_y <= eb_y_next;
        end
    end
    
    always @(posedge clk2)begin
        eb_x_next <= eb_x;
        eb_y_next <= eb_y;
        if(eb_y - 480 > ep_y)begin
            eb_x_next <= ep_x + 10'd23;
            eb_y_next <= ep_y + 10'd40;
        end
        else begin
            eb_y_next <= eb_y + 1;  //enemy bullets fly downward
        end
        enemy_bullet_rgb <= 12'b000011110000;
    end

    assign mybullet_en = (x >= eb_x && x < eb_x + 4 && y - 480 >= eb_y && y - 480 < eb_y + 40 && eb_y <=0 );
    
endmodule