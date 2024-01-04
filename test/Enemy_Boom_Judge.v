module Enemy_Boom_Judge (
    input clk, rst,
    input clk2,
    input [9:0] ep_x, ep_y,
    input [9:0] b_x, b_y,
    input mybullet_en,
    input enemy_en,
    input [2:0] enemy_health,
    output boom
)
    reg [9:0] fake_ep_x;
    reg [9:0] fake_ep_y;
    reg [2:0] present_health;
    reg present_mb_en;

    always@(posedge clk or posedge rst) begin
         if(rst) begin
            present_health <= enemy_health;
            fake_ep_x <= ep_x;
            fake_ep_y <= ep_y + 480;
            present_health <= enemy_health;
            present_mb_en <= mybullet_en;
        end
        else begin 
            if(present_mb_en && present_health && enemy_en && fake_ep_x >= b_x - 10 && fake_ep_x < b_x + 50 && fake_ep_y >= b_y - 50 && fake_ep_y < b_y + 40) begin
                present_mb_en <= 1'b0;
                present_health <= present_health - 1;
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

