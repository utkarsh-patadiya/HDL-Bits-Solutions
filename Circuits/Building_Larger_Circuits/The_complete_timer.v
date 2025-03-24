module counter_1k (
    input clk,
    input reset,
    output [9:0] q);
    always @(posedge clk) begin 
        if(reset | q==10'd999) q<=10'b0;
        else q<=q+1'b1;
    end
endmodule

module shift_reg_and_dec (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q);
    always @(posedge clk) begin 
        if(shift_ena) q<={q[2:0],data};
        else if(count_ena) q<=q-1'b1;
    end
endmodule

module FSM (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );

    parameter   D0=4'h0 ,
                D1=4'h1 ,
                D2=4'h2 ,
                D3=4'h3 ,
                S0=4'h4 ,
                S1=4'h5 ,
                S2=4'h6 ,
                S3=4'h7 ,
                COUNTING=4'h9 ,
                DONE=4'ha;
    reg [3:0] state,next_state;
    always @(*) begin 
        case(state)
            D0: 		next_state <= data ? D1 : D0;
            D1: 		next_state <= data ? D2 : D0;
            D2: 		next_state <= data ? D2 : D3;
            D3: 		next_state <= data ? S0 : D0;
            S0: 		next_state <= S1;
            S1: 		next_state <= S2;
            S2: 		next_state <= S3;
            S3: 		next_state <= COUNTING;
            COUNTING: 	next_state <= done_counting ? DONE : COUNTING;
            DONE: 		next_state <= ack ? D0 : DONE;
            default: 	next_state <= 4'bxxxx;
        endcase
    end
    always @(posedge clk) begin 
        if(reset) state<=D0;
        else state<=next_state;
    end
    
    assign { shift_ena , counting , done } = { state[2] , state[3] & state[0] , state[3] & state[1] };
endmodule

module top_module (
    input   clk         ,
    input   reset       , // Synchronous reset
    input   data        ,
    output  [3:0] count ,
    output  counting    ,
    output  done        ,
    input   ack        );

    wire shift_ena;
    FSM Fsm(
            clk                                                 ,
            reset                                               ,
            data                                                ,
            shift_ena                                           ,
            counting                                            ,
            ~|shift_reg_and_dec_wire & counter_1k_wire==10'd999 ,
            done                                                ,
            ack)                                                ;

    wire [3:0] shift_reg_and_dec_wire;
    shift_reg_and_dec SRD(
                            clk,
                            shift_ena                   ,
                            counter_1k_wire==10'd999    ,
                            data                        ,
                            shift_reg_and_dec_wire)     ;

    wire [9:0] counter_1k_wire;
    counter_1k C1(
                    clk             ,
                    ~counting       ,
                    counter_1k_wire);

    assign count = shift_reg_and_dec_wire;
endmodule
