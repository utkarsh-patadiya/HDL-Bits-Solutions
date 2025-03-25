module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    always @(posedge clk or posedge areset) 
        state<= areset ? 2'b01
                        : (train_valid ? (train_taken ? (state==2'b11 ? state 
                                                        : state+1'b1) 
                                                    : (state==2'b00 ? state 
                                                        : state-1'b1)) 
                        : state ) ;
endmodule
