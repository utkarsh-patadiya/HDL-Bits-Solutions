module top_module (
    input clk,
    input x,
    output z
); 
    wire d1,d2,d3;
    reg q1,q2,q3;
    assign d1=q1^x;
    assign d2=x&~q2;
    assign d3=x|~q3;
    always @(posedge clk) begin 
        {q1,q2,q3}={d1,d2,d3};
    end
    assign z=~(q1|q2|q3);
endmodule