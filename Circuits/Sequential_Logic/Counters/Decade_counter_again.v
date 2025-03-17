module top_module (
    input clk,
    input reset,
    output [3:0] q);
    always @(posedge clk) begin 
        if (reset|(q[3]&q[1])) q<=4'b0001;
        else q<=q+1;
    end
endmodule