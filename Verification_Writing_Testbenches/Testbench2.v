module top_module();
    reg clk,in;
    reg [2:0] s;
    wire out;
    q7 dut(.clk(clk),.in(in),.s(s),.out(out));
    always #5 clk=~clk;
    initial begin 
        {clk,in,s}=5'b00010;
        #10 s=3'h6;
        #10 s=3'h2;in=1;
        #10 s=3'h7;in=0;
        #10 s=3'h0;in=1;
        #30 in=0;
    end
endmodule
