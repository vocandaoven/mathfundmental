module Collision_Judge (
    input clk,rst,
    input [9:0] mp_x,mp_y,ep_x,ep_y,
    input mp_exist,ep_exist,
    output reg collision
);

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            collision <= 0;
        end
        else begin
            if(mp_x + 50 >= ep_x && mp_x <= ep_x + 50 && mp_y + 50 >= ep_y && mp_y <= ep_y + 50 && mp_exist && ep_exist) begin
                collision <= 1;
            end
        end
    end
    
endmodule