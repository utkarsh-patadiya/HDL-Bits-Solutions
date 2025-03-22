module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);

    parameter START=4'h0,
                D1=4'h1,
                D2=4'h2,
                D3=4'h3,
                D4=4'h4,
                D5=4'h5,
                D6=4'h6,
                ERR=4'h7,
                DISC=4'h8,
                FLAG=4'h9;
    reg [3:0] state,next_state;
    always @(*) begin 
        case(state) 
            START: next_state<=in?D1:START;
            D1: next_state<=in?D2:START;
            D2: next_state<=in?D3:START;
            D3: next_state<=in?D4:START;
            D4: next_state<=in?D5:START;
            D5: next_state<=in?D6:DISC;
            D6: next_state<=in?ERR:FLAG;
            DISC: next_state<=in?D1:START;
            FLAG: next_state<=in?D1:START;
            ERR: next_state<=in?ERR:START;
            default: next_state<=4'bxxxx;
        endcase
    end

    always @(posedge clk) begin
        if(reset) state<=START;
        else state<=next_state;
    end
    assign {disc,flag,err} = {state==DISC,state==FLAG,state==ERR};
endmodule
