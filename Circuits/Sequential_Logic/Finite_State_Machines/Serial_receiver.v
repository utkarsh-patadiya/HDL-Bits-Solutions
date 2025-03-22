module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    parameter 	IDLE=4'h0,START=4'h1,
                D0=4'h2,
                D1=4'h3,
                D2=4'h4,
                D3=4'h5,
                D4=4'h6,
                D5=4'h7,
                D6=4'h8,
                D7=4'h9,
                DONE=4'ha,WAIT=4'hb;
    reg [3:0] state,next_state;
    
    always @(*) begin 
        case(state)
            IDLE: next_state<=in?IDLE:START;
            START: next_state<=D0;
            D0: next_state<=D1;
            D1: next_state<=D2;
            D2: next_state<=D3;
            D3: next_state<=D4;
            D4: next_state<=D5;
            D5: next_state<=D6;
            D6: next_state<=D7;
            D7: next_state<=in?DONE:WAIT;
            DONE: next_state<=in?IDLE:START;
            WAIT: next_state<=in?IDLE:WAIT;
        endcase
    end

    always @(posedge clk) begin
        if(reset) state<=IDLE;
        else state<=next_state;
    end
    assign done=state==DONE;
endmodule
