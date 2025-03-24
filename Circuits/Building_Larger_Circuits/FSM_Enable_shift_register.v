module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);

    parameter A=3'b000,B=3'b001,C=3'b010,D=3'b011,END=3'b100;
    reg [2:0] state,next_state;
    always @(*) begin 
        case(state) 
            A: next_state<=B;
            B: next_state<=C;
            C: next_state<=D;
            D: next_state<=END;
            END: next_state<=END;
            default: next_state<=3'bxxx;
        endcase
    end
    always @(posedge clk) begin 
        if(reset) state<=A;
        else state<=next_state;
    end
    assign shift_ena = ~state[2];
endmodule
