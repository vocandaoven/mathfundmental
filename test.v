module Test (
    input clk,
    input rst,
    output [11:0] rgb,
    output vsync,hsync,
    output [9:0] x,y,
    output EN
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

    wire [9:0] v_addr = vcnt - 10'd35;
    wire [9:0] h_addr = hcnt - 10'd144;

    always @(posedge clk) begin
        vsync <= vcnt > 2;
        hsync <= hcnt > 96;
        x <= h_addr;
        y <= v_addr;
        EN = (vcnt > 10'd35) && (vcnt < 10'd515) && (hcnt > 144) && (hcnt < 784);
        if(EN) begin
            rgb = 12'b111100000000;
        end
        else rgb = 12'h000;
    end

endmodule