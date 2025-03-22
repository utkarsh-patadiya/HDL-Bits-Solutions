module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 

    parameter A=2'b00,B=2'b01,C=2'b10,D=2'b11;
    reg [1:0] state,next_state;
    
    always @(*) begin 
        case(state) 
            A: next_state<=~ground?C:(bump_left?B:A);
            B: next_state<=~ground?D:(bump_right?A:B);
            C: next_state<=~ground?C:A;
            D: next_state<=~ground?D:B;
        endcase
    end
    
    always @(posedge clk or posedge areset) begin 
        if(areset) state<=A;
        else state<=next_state;
    end
    
    assign {walk_left,walk_right,aaah} = {state==A,state==B,state[1]==1'b1};
endmodule
