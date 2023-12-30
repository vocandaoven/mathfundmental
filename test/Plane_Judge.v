module Plane_Judge (
    input clk,rst,
    input clk_move,
    input [9:0] x,y,
    input [3:0] direction,
    input boom,
    output reg [9:0] p_x,p_y,
    output EN,
    output reg [11:0] rgb
);
    
    reg [9:0] p_x_next,p_y_next;
    reg EN_reg;
    reg [7:0] invincible_time,invincible_time_next;
    wire [11:0] plane_rgb;
    wire [9:0] col,row;

    assign col = x - p_x;
    assign row = y - p_y;

    plane_mem Plane (.clka(clk),.addra(col + row * 50),.douta(plane_rgb));

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            p_x <= 320 - 25;
            p_y <= 480 - 50;
        end
        else begin
            p_x <= p_x_next;
            p_y <= p_y_next;
        end
//        if(boom) begin

//        end
    end

    always @(posedge clk_move) begin
        p_x_next = p_x;
        case (direction)
            4'b0100: begin
                if(p_x > 0) p_x_next <= p_x - 1;
            end 
            4'b1000: begin
                if(p_x < 640 - 50) p_x_next <= p_x + 1;
            end
        endcase
    end

    always @(posedge clk_move) begin
        p_y_next = p_y;
        case (direction)
            4'b0001:begin
                if(p_y > 0)p_y_next <= p_y - 1;
            end
            4'b0010:begin
                if(p_y < 480-50) p_y_next <= p_y + 1;
            end 
        endcase
    end
    
    always @* begin
        EN_reg <= 0;
        if(invincible_time)rgb <= 12'b000010001111;
        else rgb <= plane_rgb;
        if(plane_rgb != 12'b111111111111)EN_reg <= 1;
    end

    assign EN = (x >= p_x && x < p_x + 50 && y >= p_y && y < p_y + 50 & EN_reg);

endmodule