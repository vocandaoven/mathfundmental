module My_Boom_Judge (
    input clk, rst,
    input clk2,
    input [9:0] p_x, p_y,
    input [9:0] eb_x, eb_y,
    input enemy_bullet_en,
    input my_en,
    input [3:0] my_health,
    output reg boom,
    output reg present_eb_en;
    output reg [3:0] present_health
);
    reg [9:0] fake_mp_x;
    reg [9:0] fake_mp_y;
    reg present_eb_en;

    always@(posedge clk or posedge rst) begin
         if(rst) begin
            present_health <= my_health;
            fake_mp_x <= p_x;
            fake_mp_y <= p_y + 480;
            present_eb_en <= enemy_bullet_en;
        end
        else begin 
            fake_mp_x <= p_x;
            fake_mp_y <= p_y + 480;
            present_eb_en <= enemy_bullet_en;
            if(present_eb_en && present_health && my_en && fake_mp_x >= eb_x - 10 && fake_mp_x < eb_x + 50 && fake_mp_y >= eb_y - 50 && fake_mp_y < eb_y + 40) begin
                present_eb_en <= 1'b0;
                if(present_health > 4'b0) begin
                    present_health <= present_health - 1;
                end
            end else begin
                present_health <= present_health;
            end
        end
    end 

    always@(posedge clk2 or posedge rst) begin
        if(rst) begin
            boom <= 1'b0;
        end
        else if(present_health == 3'b0) begin
            boom <= 1'b1;
        end 
        else begin
            boom <= 1'b0;
        end
    end

endmodule

