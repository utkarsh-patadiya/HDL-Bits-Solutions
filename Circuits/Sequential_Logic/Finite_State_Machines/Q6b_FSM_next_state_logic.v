module top_module (
    input [3:1] y,
    input w,
    output Y2
  );

    reg state;
    always @(*) begin
        casez({y,w})
            4'b001z: state = 1'b1;
            4'b0101: state = 1'b1;
            4'b1001: state = 1'b1;
            4'b101z: state = 1'b1;
            default: state = 1'b0;
        endcase
    end
    
    assign Y2 = state;

endmodule