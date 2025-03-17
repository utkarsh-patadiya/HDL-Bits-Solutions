module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //
    wire [11:0] Q;
    assign c_enable[0]=1'b1;
    assign c_enable[1]=Q[3]&Q[0];
    assign c_enable[2]=Q[7]&Q[4]&c_enable[1];    
    
    bcdcount counter0 (clk, reset, c_enable[0], Q[3:0] );
    bcdcount counter1 (clk, reset, c_enable[1], Q[7:4] );    
    bcdcount counter2 (clk, reset, c_enable[2], Q[11:8]);
    
    assign OneHertz=Q[11]&Q[8]&c_enable[2];
endmodule