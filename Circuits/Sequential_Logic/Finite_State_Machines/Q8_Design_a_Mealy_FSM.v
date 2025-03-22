module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 

    parameter START=2'b00,ONE=2'b01,ZERO=2'b10;
    reg [1:0] state,next_state;
    always @(*) begin
        case(state) 
            START: next_state<=x?ONE:START;
            ONE: next_state<=x?ONE:ZERO;
            ZERO: next_state<=x?ONE:START;
        endcase
    end 
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) state <= START;
        else state <= next_state;
    end
    assign z=x&state==ZERO;
endmodule

