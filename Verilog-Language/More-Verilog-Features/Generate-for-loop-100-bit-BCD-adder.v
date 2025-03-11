module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    wire [99:0] carry;
    bcd_fadd BCD0(a[3:0],b[3:0],cin,carry[0],sum[3:0]);
    genvar i;
    generate
        for (i = 1; i < 100; i = i + 1) begin : bcd_chain
            bcd_fadd BCD(a[i*4+3:i*4],b[i*4+3:i*4],carry[i-1],carry[i],sum[i*4+3:i*4]);
            end
    endgenerate
    assign cout=carry[99];
endmodule
