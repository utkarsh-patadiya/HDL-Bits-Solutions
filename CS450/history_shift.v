module top_module(
    input clk,
    input areset,

    input predict_valid,
    input predict_taken,
    output [31:0] predict_history,

    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);
    reg [31:0] register;
    always @(posedge clk or posedge areset) begin 
        if(areset) register<=0;
        else if(train_mispredicted) register<={train_history[30:0],train_taken};
        else if(predict_valid) register<={register[30:0],predict_taken};
    end
    assign predict_history=register;
endmodule
