module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
    always @(posedge clk) begin 
        if (reset|(q[3]&q[0]&slowena)) q<=0;
        else q<=q+(slowena?1:0);
    end
        
endmodule