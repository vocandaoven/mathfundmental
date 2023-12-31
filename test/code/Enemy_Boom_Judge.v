module Enemy_Boom_Judge (
    input clk, rst,
    input clk2,
    input [9:0] ep_x, ep_y,
    input [9:0] b_x, b_y,
    input mybullet_en,  //1 for my bullet exist
    input enemy_en,  //1 for enemy palne exist
    input [2:0] enemy_health,
    output reg revive,
    output reg present_mb_en,  //1 for my bullet still exist
    output reg boom  //1 for enemy plane boom
);
    reg [9:0] fake_ep_x;
    reg [9:0] fake_ep_y;
    reg [2:0] present_health;
    reg [31:0] collide_count;
    reg [31:0] reset_count;

    always@(posedge clk or posedge rst) begin
         if(rst) begin
            revive <= 1'b0;
            present_health <= enemy_health;
            fake_ep_x <= ep_x;
            fake_ep_y <= ep_y + 480;
            present_health <= enemy_health;
            present_mb_en <= mybullet_en;
            collide_count <= 32'b0;
            reset_count <= 32'b0;
        end
        else begin 
            fake_ep_x <= ep_x;
            fake_ep_y <= ep_y + 480;
            if(present_mb_en && present_health && enemy_en && b_x >= fake_ep_x - 10 && b_x < fake_ep_x + 50 && b_y < fake_ep_y + 50 && b_y > fake_ep_y - 40) begin
                present_mb_en <= 1'b0;
                if(present_health > 3'b0) begin
                    present_health <= present_health - 1;
                end
            end else begin
                present_health <= present_health;
                collide_count <= collide_count + 1;
                if(collide_count > 15_000_0) begin
                    present_mb_en <= mybullet_en;
                    collide_count <= 32'b0;
                end
                if(boom) begin
                    reset_count <= reset_count + 1;
                    if(reset_count > 32'h03FFFFFF) begin
                        present_health <= enemy_health;
                        revive <= 1'b1;
                        reset_count <= 32'b0;
                    end
                end
                else if(revive) begin
                    reset_count <= reset_count + 1;
                    if(reset_count > 750000) begin
                        revive <= 1'b0;
                        reset_count <= 32'b0;
                    end
                end
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