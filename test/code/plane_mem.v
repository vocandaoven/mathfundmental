module Plane_mem (
    input clka,
    input [11:0] addra,
    output [11:0] douta
);
    
    reg [11:0] REG [2499:0];

    assign douta = REG[addra];

endmodule