module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    reg [7:0] prev_state;
    always @(posedge clk) begin 
        pedge<=in&~prev_state;
        prev_state<=in;
    end
endmodule