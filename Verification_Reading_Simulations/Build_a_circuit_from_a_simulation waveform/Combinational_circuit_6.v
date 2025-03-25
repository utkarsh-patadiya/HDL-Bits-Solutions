module top_module (
    input [2:0] a,
    output [15:0] q ); 
    assign q = a[2] ? ( a[1] ? (a[0] ? 16'h2f19 : 16'hc526 ) 
                             : (a[0] ? 16'h64ce : 16'h2066 ) )
                    : ( a[1] ? (a[0] ? 16'h5a0e : 16'h27d4 ) 
                             : (a[0] ? 16'haee0 : 16'h1232 ) ) ;
endmodule
