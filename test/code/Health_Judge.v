module Health_Judge (
    input clk, rst,
    input [9:0] x, y,
    input [3:0] present_health,
    input [3:0] present_bhealth,
    output reg [11:0] health1_rgb,
    output reg [11:0] health2_rgb,
    output reg [11:0] health3_rgb,
    output health_EN1,
    output health_EN2,
    output health_EN3,
    output bhealth_EN1,
    output bhealth_EN2,
    output bhealth_EN3,
    output bhealth_EN4,
    output bhealth_EN5,
    output bhealth_EN6,
    output bhealth_EN7,
    output bhealth_EN8
);

    always @* begin
        health1_rgb <= 12'b111111111111;
        health2_rgb <= 12'b111111111111;
        health3_rgb <= 12'b111111111111;
    end

    assign health_EN1 = (x >= 420 && x <= 480 && y >= 460 && y <= 470 && present_health >= 4'b0001);
    assign health_EN2 = (x >= 480 && x <= 540 && y >= 460 && y <= 470 && present_health >= 4'b0010);
    assign health_EN3 = (x >= 540 && x <= 600 && y >= 460 && y <= 470 && present_health >= 4'b0011);
    assign bhealth_EN1 = (x >= 400 && x <= 425 && y >= 10 && y <= 20 && present_bhealth >= 4'b0001);
    assign bhealth_EN2 = (x >= 425 && x <= 450 && y >= 10 && y <= 20 && present_bhealth >= 4'b0010);
    assign bhealth_EN3 = (x >= 450 && x <= 475 && y >= 10 && y <= 20 && present_bhealth >= 4'b0011);
    assign bhealth_EN4 = (x >= 475 && x <= 500 && y >= 10 && y <= 20 && present_bhealth >= 4'b0100);
    assign bhealth_EN5 = (x >= 500 && x <= 525 && y >= 10 && y <= 20 && present_bhealth >= 4'b0101);
    assign bhealth_EN6 = (x >= 525 && x <= 550 && y >= 10 && y <= 20 && present_bhealth >= 4'b0110);
    assign bhealth_EN7 = (x >= 550 && x <= 575 && y >= 10 && y <= 20 && present_bhealth >= 4'b0111);
    assign bhealth_EN8 = (x >= 575 && x <= 600 && y >= 10 && y <= 20 && present_bhealth >= 4'b1000);

endmodule