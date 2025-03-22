module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); 
    parameter 	START=4'h0,
                D0=4'h1,
                D1=4'h2,
                D2=4'h3,
                D3=4'h4,
                D4=4'h5,
                D5=4'h6,
                D6=4'h7,
                D7=4'h8,
                PB=4'h9,
                IDLE=4'ha,DONE=4'hb,WAIT=4'hc,ERR=4'hd;
    reg [3:0] state,next_state;
    reg [7:0] data_in;
    wire odd;

    parity P(.clk(clk),.reset(next_state==START),.in(in),.odd(odd));
    always @(*) begin 
        case (state)
            IDLE: next_state<=in?IDLE:START;
            START: next_state<=D0; 
            D0: next_state<=D1; 
            D1: next_state<=D2; 
            D2: next_state<=D3; 
            D3: next_state<=D4; 
            D4: next_state<=D5; 
            D5: next_state<=D6; 
            D6: next_state<=D7; 
            D7: next_state<=PB;
            PB: next_state<=in?(odd?DONE:ERR):WAIT;
            DONE: next_state<=in?IDLE:START;
            WAIT: next_state<=in?IDLE:WAIT;
            ERR: next_state<=in?IDLE:START;
            default: next_state<=4'bxxxx;
        endcase
    end

    always @(posedge clk) begin
        if(reset) state<=IDLE;
        else state<=next_state;
        data_in[state]<=in;
    end
    assign out_byte=data_in[7:0];
    assign done=state==DONE;
endmodule
