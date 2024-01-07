module DisplayNumber(
    input        clk,
    input        rst,
    input [15:0] hexs,
    input [ 3:0] points,
    input [ 3:0] LEs,
    output[ 3:0] AN,
    output[ 7:0] SEGMENT
);
    wire [31:0] w1;
    wire [3:0] w2;
    wire point,LE;
    clkdiv m0 (clk,rst,w1);
    DisplaySync m1 (w1[18:17],hexs,points,LEs,w2,AN,point,LE);
    MyMC14495 m2 (w2[0],w2[1],w2[2],w2[3],LE,SEGMENT[0],SEGMENT[1],SEGMENT[2],SEGMENT[3],SEGMENT[4],SEGMENT[5],SEGMENT[6],SEGMENT[7],point);
endmodule