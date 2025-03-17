module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);
    always @(posedge clk)
        if(reset|(q[3]&q[0])) q<=0;
        else q<=q+1;
endmodule