module Boss_Judge (
    input clk, rst,
    input clk_move,
    input boom,
    input [9:0] x, y,
    input revive,
    output reg [9:0] boss_x, boss_y,
    output reg [11:0] rgb,
    output boss_EN,
    output boss_exist
);

    reg [9:0] boss_next_x,boss_next_y;
    reg EN_reg;
    wire [11:0] boss_rgb,boom_rgb;
    wire [9:0] col,row;
    reg [7:0] boom_count; 

    assign col = x - boss_x;
    assign row = y - boss_y;

    boss_mem Boss (.clka(clk),.addra(col + row * 50),.douta(boss_rgb));
    boom_mem Boom (.clka(clk),.addra(col + row * 50),.douta(boom_rgb));

    always @(posedge clk or posedge rst) begin
        if(rst)begin
            boss_x <= 320 - 64;
            boss_y <= 0;
        end
        else begin
            boss_x <= boss_next_x;
            boss_y <= boss_next_y;
        end
    end

    always @(posedge clk_move) begin
        boss_next_x <= boss_x;
        boss_next_y <= boss_y;
        if(boom_count == 8'b0) begin
            if(revive) begin
                boss_next_x <= 320-64;
                boss_next_y <= 0;
            end
            else begin
                boss_next_x <= 320-64;
                boss_next_y <= 0;
            end
        end
    end

    always @(posedge clk_move or posedge rst) begin
        if(rst) begin
            boom_count <= 8'b0;
        end
        else if(boom) begin
            if(boom_count < 8'b11111111) boom_count <= boom_count + 1;
            else boom_count <= boom_count;
        end
        else begin
            boom_count <= 8'b0;
        end
    end
    
    always @* begin
        EN_reg <= 0;
        if(boom_count > 8'b0 && boom_count < 8'b11111111) begin
            rgb <= boom_rgb;
            if(boom_rgb != 12'b111111111111) EN_reg <= 1;
        end
        else begin
            rgb <= boss_rgb;
            if(boss_rgb != 12'b111111111111 && boss_count != 8'b11111111) EN_reg <= 1;
        end
    end

    assign boss_EN = (EN_reg && x >= boss_x && x < boss_x + 50 && y >= boss_y && y < boss_y + 50 && EN_reg);
    assign boss_exist = (boom_count == 8'b0);

endmodule