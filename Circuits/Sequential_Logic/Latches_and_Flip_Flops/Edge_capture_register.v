module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] prev_state;
    always @(posedge clk) begin 
        prev_state<=in;
        if(reset) out<=0;
        else out<=out|(~in&prev_state);
    end
endmodule
