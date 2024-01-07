module Boss_Bullet_Judge (
    input clk, rst,
    input clk2, 
    input [9:0] boss_x, boss_y,
    input [9:0] startboss_x, startboss_y,
    input [9:0] x, y,
    input boss_exist,
    input collide,
    output reg [9:0] bb_x, bb_y,
    output boss_bullet_en,
    output bossbullet_exist,
    output reg [11:0] boss_bullet_rgb
);

    reg [9:0] bb_x_next,bb_y_next;
    reg [9:0] counter;
    reg EN_reg;
    reg collide_EN;  //1 for enemy bullet collide, 0 for enemy bullet exist
    wire [11:0] bullet_rgb;
    wire [9:0] col,row;
    
    assign row = y + 480 - bb_y;
    assign col = x - bb_x;
    
    boss_bullet_mem Bullet (.clka(clk),.addra(col + row * 20),.douta(bullet_rgb));

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            bb_x <= startboss_x;
            bb_y <= startboss_y;
        end
        else begin
            bb_x <= bb_x_next;
            bb_y <= bb_y_next;
        end
    end
    
    always @(posedge clk2 or posedge rst)begin
        if(rst) begin 
            bb_x_next <= startboss_x;
            bb_y_next <= startboss_y;
            collide_EN <= 1'b0;
        end
        else begin
            bb_x_next <= bb_x;
            bb_y_next <= bb_y;
            if(counter == 480)begin
                bb_x_next <= boss_x + 10'd54;
                bb_y_next <= boss_y + 10'd60;  //the bullet is 20*60 size
                collide_EN <= 1'b0;
                counter <= 0;
            end
            else begin
                bb_y_next <= bb_y + 1;  //enemy bullets fly downward
                counter <= counter + 1;
                if(~collide) collide_EN <= 1'b1;
            end
        end
    end
    
    always @* begin
        boss_bullet_rgb <= bullet_rgb;  //need to be specified
    end

    assign boss_bullet_en = (x >= bb_x && x < bb_x + 20 && y + 480 >= bb_y && y + 480 < bb_y + 60 && bb_y <= 960 & ~collide_EN & boss_exist);
    assign bossbullet_exist = (collide_EN == 1'b0 & boss_exist);
    
endmodule
