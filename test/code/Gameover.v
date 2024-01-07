module Gameover (
    input clk,rst,
    input gameover,
    input [9:0] x,y,
    output EN,
    output reg [11:0] rgb
);

    reg EN_reg;
    wire [9:0] col;
    wire [11:0] game_rgb;
    assign col = y - 180;

    gameover_mem Game (.addra(col * 640 + x),.douta(game_rgb),.clka(clk));

    
    always @* begin
        EN_reg = 0;
        if(game_rgb != 12'b111100000000)EN_reg = 1;
        rgb <= game_rgb;
    end

    assign EN = (x >= 0 && x <= 640 && y >= 160 && y <= 320 && gameover && EN_reg);
    
endmodule