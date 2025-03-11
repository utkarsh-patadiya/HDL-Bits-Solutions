module top_module ( input a, input b, output out );
    //mod_a inst1 (a,b,out);
    mod_a inst2 (.out(out),.in1(a),.in2(b));
endmodule