module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); 
    MUXDFF m1(.clk(KEY[0]),.R(SW[3]),.E(KEY[1]),.L(KEY[2]),.w(KEY[3]),.Q(LEDR[3]));
    MUXDFF m2(.clk(KEY[0]),.R(SW[2]),.E(KEY[1]),.L(KEY[2]),.w(LEDR[3]),.Q(LEDR[2]));
    MUXDFF m3(.clk(KEY[0]),.R(SW[1]),.E(KEY[1]),.L(KEY[2]),.w(LEDR[2]),.Q(LEDR[1]));
    MUXDFF m4(.clk(KEY[0]),.R(SW[0]),.E(KEY[1]),.L(KEY[2]),.w(LEDR[1]),.Q(LEDR[0]));

endmodule

module MUXDFF (
    input clk,
    input w, R, E, L,
    output Q
);
    always @(posedge clk) 
        Q<=L?R:(E?w:Q);
endmodule
