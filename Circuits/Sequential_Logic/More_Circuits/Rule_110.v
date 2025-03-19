module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 
    wire [511:0] right={q[510:0],1'b0};
    wire [511:0] center=q[511:0];
    wire [511:0] left={1'b0,q[511:1]};
    
    always @(posedge clk) begin 
        if (load) q<=data;
        else q<=(~left&(center|right))|(center^right);
    end
endmodule
