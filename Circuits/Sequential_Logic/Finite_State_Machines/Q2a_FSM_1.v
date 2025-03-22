module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);
    
    parameter A=3'h0,B=3'h1,C=3'h2,D=3'h3,E=3'h4,F=3'h5;
    reg [2:0] state,next_state;

    always @(*) begin
        case (state)
            A: next_state <= ~w?A:B;
            B: next_state <= ~w?D:C;
            C: next_state <= ~w?D:E;
            D: next_state <= ~w?A:F;
            E: next_state <= ~w?D:E;
            F: next_state <= ~w?D:C;
            default: next_state <= 3'bxxx;
        endcase
    end
    always @(posedge clk ) begin
        if(reset) state <= A;
        else state <= next_state;
    end
    assign z= state==E | state==F;
endmodule
