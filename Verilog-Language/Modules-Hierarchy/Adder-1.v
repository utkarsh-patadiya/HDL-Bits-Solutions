module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] s1,s2;
    wire cout1,cout2;
    add16 adder1(a[15:0],b[15:0],0,s1,cout1);
    add16 adder2(a[31:16],b[31:16],cout1,s2,cout2);
    assign sum = {s2,s1};
endmodule
