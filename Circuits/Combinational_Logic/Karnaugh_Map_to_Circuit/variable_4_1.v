module top_module(
    input a,
    input b,
    input c,
    input d,
    output out ); 
    //assign out = (~a|~b|c)&(c|~d|~b)&(a|b|~c|~d)&(~c|d|~a);
    assign out = (~a&~d)|(b&c&d)|(~c&~b)|(a&~b&d);
endmodule