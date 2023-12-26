module Test (
    input clk,
    input rst,
    input [11:0] Din,
    output reg [11:0] rgb,
    output reg vsync,hsync,
    output reg [9:0] x,y,
    output reg EN
);
    reg [9:0] vcnt,hcnt;
    always @(posedge clk or posedge rst) begin
        if(rst)begin
            hcnt <= 10'b0;
        end 
        else begin
            if(hcnt == 10'd799)hcnt <= 10'b0;
            else hcnt <= hcnt + 1;
        end
    end
    always @(posedge clk or posedge rst) begin
        if(rst)vcnt <= 10'b0;
        else begin
            if(hcnt == 10'd799)begin
                if(vcnt == 10'd524)vcnt <= 10'b0;
                else vcnt <= vcnt + 1;
            end
        end
    end

    always @(posedge clk) begin
        vsync <= vcnt > 2 ? 1 : 0;
        hsync <= hcnt > 96 ? 1 : 0;
        x <= hcnt - 10'd144;
        y <= vcnt - 10'd35;
        EN <= (vcnt > 10'd35) && (vcnt < 10'd515) && (hcnt > 144) && (hcnt < 784);
        if(EN) begin
            rgb <= Din;
        end
        else rgb <= 12'h000;
    end

endmodule