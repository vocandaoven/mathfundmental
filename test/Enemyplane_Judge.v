module Enemyplane_Judge (
    input clk,rst,
    input clk_move,
    input boom,
    input [9:0] x,y,
    output reg [9:0] enemy_x,enemy_y,
    output reg [11:0] rgb,
    output enemyplane_exist,
    output enemy_en
);

    reg [9:0] e_next_x,e_next_y;
    reg EN_reg;
    wire [11:0] enemy_rgb,boom_rgb;
    wire [9:0] col,row;
    reg [3:0] boom_count; 
    assign boom_rgb = 12'b100101101001;

    assign col = x - enemy_x;
    assign row = y - enemy_y;

    enemyplane_mem Enemy (.clka(clk),.addra(col + row * 50),.douta(enemy_rgb));
    //boom_mem Boom (.clka(clk),.addra(col + row * 50),.douta(boom_rgb));

    always @(posedge clk or posedge rst) begin
        if(rst)begin
            enemy_x <= {$random} % 590;
            enemy_y <= 0;
        end
        else begin
            enemy_x <= e_next_x;
            enemy_y <= e_next_y;
        end
    end

    always @(posedge clk_move) begin
        e_next_x <= enemy_x;
        e_next_y <= enemy_y;
        if(boom_count == 4'b0) begin
            if(enemy_y < 430) begin
                e_next_y <= enemy_y + 1;
            end
            else begin
                e_next_x <= {$random} % 590;
                e_next_y <= 0;
            end
        end
    end

    always @(posedge clk_move or posedge rst) begin
        if(rst) begin
            boom_count <= 4'b0;
        end
        else if(boom) begin
            if(boom_count < 4'b1111) boom_count <= boom_count + 1;
            else boom_count <= boom_count;
        end
        else begin
            boom_count <= 4'b0;
        end
    end
    
    always @* begin
        EN_reg <= 0;
        if(boom_count > 4'b0 && boom_count < 4'b1111) begin
            rgb <= boom_rgb;
            if(boom_rgb != 12'b111111111111) EN_reg <= 1;
        end
        else begin
            rgb <= enemy_rgb;
            if(enemy_rgb != 12'b111111111111 && boom_count != 4'b1111) EN_reg <= 1;
        end
    end

    assign enemy_en = (EN_reg && x >= enemy_x && x < enemy_x + 50 && y >= enemy_y && y < enemy_y + 50 && EN_reg);
    assign enemyplane_exist = (boom_count == 4'b0);
    
endmodule