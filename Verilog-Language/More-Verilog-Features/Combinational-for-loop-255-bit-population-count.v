module top_module( 
    input [254:0] in,
    output [7:0] out );
	integer i;
    integer add;
    always @(*) begin
        add=0;
        for (i=0;i<255;i=i+1) begin
            add=add+(in[i]?1:0);
        end
    end
    assign out = add[7:0];
endmodule
