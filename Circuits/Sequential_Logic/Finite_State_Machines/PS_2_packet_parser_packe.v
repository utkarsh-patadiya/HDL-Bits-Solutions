module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //

    parameter A=2'b00,B=2'b01,C=2'b10,D=2'b11;
    reg [1:0] state,next;
    // State transition logic (combinational)
    always @(*) begin 
        case (state) 
            A: next<=in[3]?B:A;
            B: next<=C;
            C: next<=D;
            D: next<=in[3]?B:A;
        endcase
    end
    // State flip-flops (sequential)
    always @(posedge clk) begin 
        if(reset) state<=A;
        else state<=next;
    end
    // Output logic
    assign done =state==D;
endmodule
