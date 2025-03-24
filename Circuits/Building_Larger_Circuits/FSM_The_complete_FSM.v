module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );

    parameter D0=4'h0,D1=4'h1,D2=4'h2,D3=4'h3,S0=4'h4,S1=4'h5,S2=4'h6,S3=4'h7,COUNTING=4'h9,DONE=4'ha;
    reg [3:0] state,next_state;
    always @(*) begin 
        case(state)
            D0: 		next_state <= data ? D1 : D0;
            D1: 		next_state <= data ? D2 : D0;
            D2: 		next_state <= data ? D2 : D3;
            D3: 		next_state <= data ? S0 : D0;
            S0: 		next_state <= S1;
            S1: 		next_state <= S2;
            S2: 		next_state <= S3;
            S3: 		next_state <= COUNTING;
            COUNTING: 	next_state <= done_counting ? DONE : COUNTING;
            DONE: 		next_state <= ack ? D0 : DONE;
            default: 	next_state <= 4'bxxxx;
        endcase
    end
    always @(posedge clk) begin 
        if(reset) state<=D0;
        else state<=next_state;
    end
    
    assign { shift_ena, counting, done } = { state[2] ,state[3]&state[0] ,state[3]&state[1] };
endmodule
