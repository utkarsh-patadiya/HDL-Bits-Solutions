module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output tc
);
    reg [9:0] counter;
    always @(posedge clk) counter<=load?data:(counter==10'b0 ? 10'b0:counter-1'b1);
    assign tc=counter==10'b0;
endmodule
