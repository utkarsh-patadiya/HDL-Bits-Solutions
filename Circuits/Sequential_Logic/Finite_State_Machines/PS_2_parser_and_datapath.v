module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //
   
    parameter A=2'b00,B=2'b01,C=2'b10,D=2'b11;
    reg [1:0] state,next;
    reg [7:0] b1,b2,b3;
    // State transition logic (combinational)
    always @(*) begin 
        case (state) 
            A: begin
                if(in[3]) begin 
                    next<=B;
                    b1<=in;
                end
                else next<=A; 
            end
            B: begin
                b2<=in;
                next<=C; 
            end
            C: begin
                b3<=in;
                next<=D; 
            end
            D: begin
                if(in[3]) begin 
                    b1<=in;
                    next<=B;
                end
                else next<=A; 
            end
        endcase
    end
    // State flip-flops (sequential)
    always @(posedge clk) begin 
        if(reset) state<=A;
        else begin
            out_bytes <= {b1,b2,b3};
            state<=next; 
        end
    end
    // Output logic
    assign done =state==D;
endmodule
