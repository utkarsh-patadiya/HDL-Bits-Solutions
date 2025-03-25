module history_shift(
    input clk,
    input areset,

    input predict_valid,
    input pred_tak,
    output reg [6:0] predict_history,

    input train_mispredicted,
    input train_taken,
    input [6:0] train_history
);
    always @(posedge clk or posedge areset) begin 
        if(areset) predict_history<=0;
        else if(train_mispredicted) predict_history<={train_history[5:0],train_taken};
        else if(predict_valid) predict_history<={predict_history[5:0],pred_tak};
    end
endmodule


module top_module(
    input clk,
    input areset,

    input  predict_valid,
    input  [6:0] predict_pc,
    output predict_taken,
    output reg [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
    reg [1:0] pht[127:0];

    history_shift HS(	clk,
                        areset,
                        predict_valid,
                        predict_taken,
                        predict_history,  // output
                        train_mispredicted & train_valid,
                        train_taken,
                        train_history); // use module from previous question of histroy shift

    integer i;
    always @(posedge clk or posedge areset) begin        
        if(areset) for(i=0;i<128;i=i+1) pht[i] <= 2'h1;
        else if(train_valid) 
            case(pht[train_pc ^ train_history])
                2'h0: pht[train_pc ^ train_history] <= train_taken ? 2'h1 : 2'h0;
                2'h1: pht[train_pc ^ train_history] <= train_taken ? 2'h2 : 2'h0;
                2'h2: pht[train_pc ^ train_history] <= train_taken ? 2'h3 : 2'h1;
                2'h3: pht[train_pc ^ train_history] <= train_taken ? 2'h3 : 2'h2;                
            endcase
    end
    assign predict_taken = pht[predict_pc ^ predict_history][1];
endmodule