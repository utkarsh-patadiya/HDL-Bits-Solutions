module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=0, B=1; 
    always @(posedge clk or posedge areset) begin 
        if (areset) out<=1;
        else begin case(in)
        	B:out<=out;
            A:out<=~out;
        endcase end
    end

endmodule
