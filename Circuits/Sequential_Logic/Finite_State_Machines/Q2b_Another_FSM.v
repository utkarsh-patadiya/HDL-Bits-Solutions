module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x, 
    input y,
    output f,
    output g
); 

    parameter A=4'h1,B=4'h2,C=4'h3,D=4'h4,E=4'h5,F=4'h6,G=4'h7,H=4'h8,I=4'h0;
    reg [3:0] state,next_state;
    always @(*) begin 
        case (state) 
            I: next_state<=resetn?A:B;
            A: next_state<=x?B:C;
            B: next_state<=x?C:B;
            C: next_state<=x?C:D;
            D: next_state<=x?E:B;
            E: next_state<=y?F:G;
            F: next_state<=F;
            G: next_state<=y?F:H;
            H: next_state<=H;
        endcase
    end
    always @(posedge clk) begin 
        if(~resetn) state<=I;
        else state<= next_state;
    end
    assign f=state==A;
    assign g=state==E|state==F|state==G;
endmodule
