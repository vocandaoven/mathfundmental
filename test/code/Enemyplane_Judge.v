module Enemyplane_Judge (
    input clk,rst,
    input clk_move,
    input boom,
    input revive,
    input [9:0] x,y,
    output reg [9:0] enemy_x,enemy_y,
    output reg [11:0] rgb,
    output enemyplane_exist,
    output enemy_en,
    output reg Counter
);

    reg [9:0] e_next_x,e_next_y;
    reg EN_reg;
    wire [11:0] enemy_rgb,boom_rgb;
    wire [9:0] col,row;
    reg [7:0] boom_count; 
    reg counter1 ,counter2, counter3;

    assign col = x - enemy_x;
    assign row = y - enemy_y;

    enemyplane_mem Enemy (.clka(clk),.addra(col + row * 50),.douta(enemy_rgb));
    explode_mem Boom (.clka(clk),.addra(col + row * 50),.douta(boom_rgb));

    always @(posedge clk or posedge rst) begin
        if(rst)begin
            enemy_x <= 120-25;
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
        if(boom_count == 8'b0) begin
            if(revive) begin
                e_next_x <= (enemy_x + 100 > 640 ? 120 : enemy_x + 100);
                e_next_y <= 0;
            end
            else if(enemy_y < 430) begin
                e_next_y <= enemy_y + 1;
            end
            else begin
                e_next_x <= (enemy_x + 100 > 640 ? 120 : enemy_x + 100);
                e_next_y <= 0;
            end
        end
    end

    always @(posedge clk_move or posedge rst) begin
        if(rst) begin
            boom_count <= 8'b0;
        end
        else if(boom) begin
            if(boom_count < 8'b11111111) begin 
                boom_count <= boom_count + 1;
            end
            else begin 
                boom_count <= boom_count;
            end
        end
        else begin
            boom_count <= 8'b0;
        end
    end
    
    always@ (posedge clk_move or posedge rst) begin
        if(rst) begin
            counter1 <= 1'b0;
            counter2 <= 1'b0;
            counter3 <= 1'b0;
            Counter <= 1'b0;
        end
        else begin
            counter1 <= ~enemyplane_exist;
            counter2 <= counter1;
            counter3 <= counter2;
            if(counter2 == 1 && counter3 == 0) begin
                Counter <= 1'b1;
            end
            else Counter <= 1'b0;
        end
    end

    always @* begin
        EN_reg <= 0;
        if(boom_count > 8'b0 && boom_count < 8'b11111111) begin
            rgb <= boom_rgb;
            if(boom_rgb != 12'b111111111111) EN_reg <= 1;
        end
        else begin
            rgb <= enemy_rgb;
            if(enemy_rgb != 12'b111111111111 && boom_count != 8'b11111111) EN_reg <= 1;
        end
    end

    assign enemy_en = (EN_reg && x >= enemy_x && x < enemy_x + 50 && y >= enemy_y && y < enemy_y + 50 && EN_reg);
    assign enemyplane_exist = (boom_count == 8'b0);
    
endmodule