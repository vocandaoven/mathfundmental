module Enemy_Bullet_Judge (
    input clk,rst,
    input clk2,
    input [9:0] ep_x,ep_y,
    input [9:0] startep_x,startep_y,
    input [9:0] x,y,
    input enemyplane_exist,  //1 for enemy plane exist
    input collide,  //0 for enemy bullet collide, 1 for enemy bullet exist
    output reg [9:0] eb_x,eb_y,
    output enemy_bullet_en,  //1 for enemy bullet can show on the VGA
    output enemybullet_exist,  //1 for enemy bullet exist, actually equal to enemy_bullet_en
    output reg [11:0] enemy_bullet_rgb
);

    reg [9:0] eb_x_next,eb_y_next;
    reg [9:0] counter;
    reg EN_reg;
    reg collide_EN;  //1 for enemy bullet collide, 0 for enemy bullet exist
    wire [11:0] bullet_rgb;
    wire [9:0] col,row;
    
    assign row = y + 480 - eb_y;
    assign col = x - eb_x;
    
    eb_mem Bullet (.clka(clk),.addra(col + row * 10),.douta(bullet_rgb));

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
            collide_EN <= 1'b0;
        end
        else begin
            eb_x_next <= eb_x;
            eb_y_next <= eb_y;
            if(counter == 480)begin
                eb_x_next <= ep_x + 10'd23;
                eb_y_next <= ep_y + 10'd40;
                collide_EN <= 1'b0;
                counter <= 0;
            end
            else begin
                eb_y_next <= eb_y + 1;  //enemy bullets fly downward
                counter <= counter + 1;
                if(~collide) collide_EN <= 1'b1;
            end
        end
    end
    
    always @* begin
        enemy_bullet_rgb <= bullet_rgb;  //need to be specified
    end

    assign enemy_bullet_en = (x >= eb_x && x < eb_x + 10 && y + 480 >= eb_y && y + 480 < eb_y + 40 && eb_y <= 960 & ~collide_EN & enemyplane_exist);
    assign enemybullet_exist = (collide_EN == 1'b0 & enemyplane_exist);
    
endmodule