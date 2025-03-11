module top_module(
    output zero
);
    wire x;
    assign zero=x&~x;
endmodule
