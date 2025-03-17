module top_module (
    input clk,
    input reset,   
    output [3:1] ena,
    output [15:0] q);
    always @(posedge clk) begin 
        
        if (reset) q=0;
        else begin    
            q=q+1;
            if (q[3]&q[1]) q=q+4'h6;
            if (q[7]&q[5]) q=q+8'h60;
            if (q[11]&q[9]) q=q+12'h600;
            if (q[15]&q[13]) q=q+16'h6000;
            
        end
    end
    assign ena[1]=q[3]&q[0];
    assign ena[2]=q[7]&q[4]&ena[1];
    assign ena[3]=q[11]&q[8]&ena[2];
endmodule
