    assign out_both=in[99:1]&in[98:0];
    assign out_any=in[99:1]|in[98:0];
    assign out_different={in[99]^in[0],in[99:1]^in[98:0]};
endmodule
