module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    parameter WL=3'b000,WR=3'b001,FL=3'b010,FR=3'b011,DL=3'b100,DR=3'b101,DIE=3'b110;
    reg [2:0] state,next_state;
    reg [4:0] count;
    
    always @(*) begin   
        case(state)  
            WL: 
                next_state<=~ground?FL:(dig?DL:(bump_left?WR:WL)); 
            WR: 
                next_state<=~ground?FR:(dig?DR:(bump_right?WL:WR)); 
            FL:
                next_state<=~ground?FL:((count>19)?DIE:WL);
            FR: 
                next_state<=~ground?FR:((count>19)?DIE:WR);
            DL:
                next_state<=~ground?FL:DL; 
            DR:
                next_state<=~ground?FR:DR; 
            DIE: next_state<=DIE;            
        endcase
    end
    always @(posedge clk or posedge areset) begin 
        if(areset) begin 
            state<=WL;
            count<=0;
        end
        else begin 
            if(aaah) count<=count+(count>24?0:1);
            else count<=0;
            state<=next_state;
        end 
    end  
    assign {walk_left,walk_right,aaah,digging} = {state==WL,state==WR,state[1]==1'b1,state[2]==1'b1} & {4{~(state==DIE)}};
endmodule
