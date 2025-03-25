module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
    always @(posedge clk) state<=(a==b)?a:state;
    assign q=(a==b)?state:~state;
endmodule
