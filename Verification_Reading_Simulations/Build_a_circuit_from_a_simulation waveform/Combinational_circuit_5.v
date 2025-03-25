module top_module (
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    output [3:0] q );
    assign q= ( c[3]|c[2] ) ? 4'hf : (c[1]? (c[0]?d:a) : (c[0]?e:b));
endmodule
