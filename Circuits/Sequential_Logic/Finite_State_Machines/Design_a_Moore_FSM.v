module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    parameter A=4'b1111,B=4'b0110,C=4'b0010,D=4'b0000,E=4'b0111,F=4'b0011,G=4'b1110;
    reg [3:0] state,next;
    
    always @(*) begin 
        case(state)
            A: next<=s[1]?B:A;
            B: next<=s[2]?C:(s[1]?B:A);
            C: next<=s[3]?D:(s[2]?C:E);
            D: next<=s[3]?D:F;
            E: next<=s[2]?C:(s[1]?E:A);
            F: next<=s[3]?D:(s[2]?F:E);
            default : next <= 4'bxxxx;
        endcase
    end
    always @(posedge clk) begin 
        if(reset) state<=A;
        else state<=next;
    end
    
    assign {fr3,fr2,fr1,dfr} = state;
endmodule
