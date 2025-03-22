module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2
  );

    localparam  S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4,S5 = 5, S6 = 6, S7 = 7, S8 = 8, S9 = 9;
    
    assign next_state[S0] 		= |	{state[S9:S7],state[S4:S0]	}	&	~in;
    assign next_state[S1] 		= |	{state[S9:S8],state[S0]		}	&	in;
    assign next_state[S6:S2] 	= 	state[S5:S1] 					& 	{5{in}};
    assign next_state[S7] 		= |	state[S7:S6] 					& 	in;
    assign next_state[S9:S8] 	= 	state[S6:S5] 					& 	{2{!in}};

    assign out1 = state[8] | state[9];
    assign out2 = state[7] | state[9];

endmodule