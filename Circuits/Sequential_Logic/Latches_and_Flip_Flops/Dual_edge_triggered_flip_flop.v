module top_module (
    input clk,
    input d,
    output q
);
    reg pos,neg;
    always @(posedge clk)
        pos <= d;
    always @(negedge clk)
        neg <= d;
    assign q = clk?pos:neg;
endmodule
