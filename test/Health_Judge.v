module Health_Judge (
    input clk, rst,
    input [9:0] x, y,
    input [3:0] present_health,
    output reg [11:0] health1_rgb,
    output reg [11:0] health2_rgb,
    output reg [11:0] health3_rgb,
    output health_EN1,
    output health_EN2,
    output health_EN3
)

    always @* begin
        health1_rgb <= 12'b000000001111;
        health2_rgb <= 12'b000000001111;
        health3_rgb <= 12'b000000001111;
    end

    assign health_EN1 = (x >= 420 && x <= 480 && y >= 460 && y <= 470 && present_health >= 4'b0001);
    assign health_EN2 = (x >= 480 && x <= 540 && y >= 460 && y <= 470 && present_health >= 4'b0010);
    assign health_EN3 = (x >= 540 && x <= 600 && y >= 460 && y <= 470 && present_health >= 4'b0011);

endmodule