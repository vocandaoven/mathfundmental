module Enemy_Bullet_Judge (
    input clk,rst,
    input clk2,
    input [9:0] ep_x,ep_y,
    input [9:0] startep_x,startep_y,
    input [9:0] x,y,
    input boom,
    output reg [9:0] eb_x,eb_y,
    output enemy_bullet_en,
    output enemybullet_exist,
    output reg [11:0] enemy_bullet_rgb
);

    reg [9:0] eb_x_next,eb_y_next;
    reg EN_reg;
    reg boom_EN;

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
    
    always @(posedge clk2 or posedge rst)begin
        if(rst) begin 
            eb_x_next <= startep_x;
            eb_y_next <= startep_y;
            boom_EN <= 1'b1;
        end
        else begin
            eb_x_next <= eb_x;
            eb_y_next <= eb_y;
            if(eb_y + 480 > ep_y)begin
                eb_x_next <= ep_x + 10'd23;
                eb_y_next <= ep_y + 10'd40;
                boom_EN <= 1'b1;
            end
            else begin
                eb_y_next <= eb_y + 1;  //enemy bullets fly downward
                if(boom) boom_EN <= 1'b0;
            end
        end
        enemy_bullet_rgb <= 12'b111111111111;  //need to be specified
    end

    assign enemy_bullet_en = (x >= eb_x && x < eb_x + 10 && y + 480 >= eb_y && y + 480 < eb_y + 40 && eb_y <= 960 & boom_EN);
    assign enemybullet_exist = (boom_EN == 1'b1);
    
endmodule