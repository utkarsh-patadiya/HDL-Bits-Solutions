module top_module (
    input clk,
    input a,
    output reg q );
    always @(posedge clk) q<=a?0:1;
endmodule
