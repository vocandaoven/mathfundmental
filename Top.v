module Top (
    input clk,
    input rst,
    output [11:0] rgb,
    output vsync,
    output hsync
);
    wire [9:0] x,y;
    Test m0 (.clk(clk),.rst(rst),.rgb(rgb),.vsync(vsync),.hsync(hsync),.x(x),.y(y),.EN());
endmodule