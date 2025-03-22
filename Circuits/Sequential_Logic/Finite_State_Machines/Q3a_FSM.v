module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    parameter START=2'h0,
                FIRST=2'h1,
                SECOND=2'h2,
                THIRD=2'h3;
    reg [1:0] state, next_state;
    reg [3:0] data;
    always @(*) begin 
        case(state) 
            START: next_state<=s?FIRST:START;
            FIRST: next_state<=SECOND;
            SECOND: next_state<=THIRD;
            THIRD: next_state<=FIRST;       
        endcase
    end
    always @(posedge clk) begin 
        if(reset) begin 
            state<=START;
            data<=4'b0000;
        end
        else begin 
            state<=next_state;
            data[state]<=w;
        end
    end
    assign z=(state==FIRST)&((~data[3]&data[2]&data[1])|(data[3]&(data[2]^data[1])));
endmodule
/*
module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);

    parameter A=4'h0,
                B=4'h1,
                C=4'h2,
                D=4'h3,
                E=4'h4,
                F=4'h5,
                G=4'h6,
                H=4'h7,
                I=4'h8;
    reg [3:0] state, next_state;
    always @(*) begin 
        case(state) 
            A: next_state<=s?B:A;
            B: next_state<=w?F:C;
            C: next_state<=w?D:I;
            D: next_state<=w?E:H;
            E: next_state<=w?F:C;
            F: next_state<=w?G:D;
            G: next_state<=w?H:E;
            H: next_state<=w?F:C;
            I: next_state<=H;         
        endcase
    end
    always @(posedge clk) begin 
        if(reset) state<=A;
        else state<=next_state;
    end
    assign z=state==E;
endmodule
*/