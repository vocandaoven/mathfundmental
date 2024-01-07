module DisplaySync(
    input [ 1:0] scan,
    input [15:0] hexs,
    input [ 3:0] points,
    input [ 3:0] LEs,
    output[ 3:0] HEX,
    output[ 3:0] AN,
    output       point,
    output       LE
);
    Mux4to1b4 m1 (scan,hexs[3:0],hexs[7:4],hexs[11:8],hexs[15:12],HEX);
    Mux4to1 m2 (points[0],points[1],points[2],points[3],scan,point);
    Mux4to1 m3 (LEs[0],LEs[1],LEs[2],LEs[3],scan,LE);
    Mux4to1b4 m4 (scan,4'b1110,4'b1101,4'b1011,4'b0111,AN);
endmodule