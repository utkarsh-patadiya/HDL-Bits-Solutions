module top_module (input a, input b, input c, output out);//
    wire not_out;
    assign out = ~not_out;
    andgate inst1 ( not_out ,a, b, c,1'b1,1'b1);
endmodule
