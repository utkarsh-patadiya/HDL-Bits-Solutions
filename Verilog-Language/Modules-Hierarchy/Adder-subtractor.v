module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire cout1,cout2;
    add16 adder1(a[15:0],{16{sub}}^b[15:0],sub,sum[15:0],cout1);
    add16 adder2(a[31:16],{16{sub}}^b[31:16],cout1,sum[31:16],cout2);
endmodule