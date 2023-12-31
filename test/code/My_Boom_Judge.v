module My_Boom_Judge (
    input clk, rst,
    input clk2,
    input [9:0] p_x, p_y,
    input [9:0] eb_x, eb_y,
    input [9:0] bb_x, bb_y,
    input enemy_bullet_en,  //1 for the enemy bullet exist
    input boss_bullet_en,
    input my_en,  //1 for my plane exist
    input [3:0] my_health,
    output reg boom,  //1 for my plane boom, 1 is positive
    output reg present_eb_en,  //1 for enemy bullet still exist
    output reg present_bb_en,
    output reg [3:0] present_health
);
    reg [9:0] fake_mp_x;
    reg [9:0] fake_mp_y;
    reg [31:0] collide_count;
    

    always@(posedge clk or posedge rst) begin
         if(rst) begin
            present_health <= my_health;
            fake_mp_x <= p_x;
            fake_mp_y <= p_y + 480;
            present_eb_en <= enemy_bullet_en;
            present_bb_en <= boss_bullet_en;
            collide_count <= 32'b0;
        end
        else begin 
            fake_mp_x <= p_x;
            fake_mp_y <= p_y + 480;
            if(present_eb_en && present_health && my_en && eb_x >= fake_mp_x - 10 && eb_x < fake_mp_x + 50 && eb_y >= fake_mp_y - 50 && eb_y < fake_mp_y + 40) begin
                present_eb_en <= 1'b0;
                if(present_health > 4'b0) begin
                    present_health <= present_health - 1;
                end
            end 
            else if(present_bb_en && present_health && my_en && bb_x >= fake_mp_x -20 && bb_x < fake_mp_x + 50 && bb_y >= fake_mp_y - 50 && bb_y >= fake_mp_y + 60) begin
                present_bb_en <= 1'b0;
                if(present_health > 4'b0) begin
                    present_health <= present_health - 1;
                end
            end
            else begin
                present_health <= present_health;
                collide_count <= collide_count + 1;
                if(collide_count > 15_000_0) begin
                    present_eb_en <= enemy_bullet_en;
                    present_bb_en <= boss_bullet_en;
                    collide_count <= 32'b0;
                end
            end
        end
    end 

    always@(posedge clk2 or posedge rst) begin
        if(rst) begin
            boom <= 1'b0;
        end
        else if(present_health == 4'b0) begin
            boom <= 1'b1;
        end 
        else begin
            boom <= 1'b0;
        end
    end

endmodule

