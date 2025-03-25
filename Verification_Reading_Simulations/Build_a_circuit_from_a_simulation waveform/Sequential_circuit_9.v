module top_module (
    input clk,
    input a,
    output [3:0] q );
    always @(posedge clk) q<=a?4'h4:(q==4'h6 ? 4'h0:(q+1'b1));
endmodule
