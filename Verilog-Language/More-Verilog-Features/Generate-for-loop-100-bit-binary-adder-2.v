module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );

//	genvar i;
//    assign {cout[0],sum[0]}=a[0]+b[0]+cin;
//    generate 
//        for(i=1;i<100;i=i+1) begin : adder_chain
//            assign {cout[i],sum[i]}=a[i]+b[i]+cout[i-1];
//        end
//   endgenerate

	full_adder FA0 (
        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .sum(sum[0]),
        .cout(cout[0])
    );
    genvar i;
    generate
        for (i = 1; i < 100; i = i + 1) begin : adder_chain
                full_adder FA (
                    .a(a[i]),
                    .b(b[i]),
                    .cin(cout[i-1]),
                    .sum(sum[i]),
                    .cout(cout[i])
                );
            end
    endgenerate
    
endmodule

module full_adder(
    input a, b, cin,
    output sum, cout
);
    assign {cout, sum} = a + b + cin;
endmodule

