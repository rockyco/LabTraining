module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
); //

    localparam FSM_W = 10 - 1;
    
    localparam  S           = 0;
    localparam  S_1         = 1;
    localparam  S_11        = 2;
    localparam  S_110       = 3;
    localparam  B0          = 4;
    localparam  B1          = 5;
    localparam  B2          = 6;
    localparam  B3          = 7;
    localparam  S_COUNT     = 8;
    localparam  S_WAIT      = 9;
    
    reg [FSM_W : 0] next_state;
    
    always@(*)
    begin
        next_state[S      ] = (state[S] & ~d) || (state[S_1] & ~d) || 
        				      (state[S_110] & ~d) || (state[S_WAIT] & ack);
        next_state[S_1    ] = (state[S] &  d);
        next_state[S_11   ] = (state[S_1] &  d) || (state[S_11] &  d);
        next_state[S_110  ] = (state[S_11] & ~d);
        next_state[B0     ] = (state[S_110] &  d);
        next_state[B1     ] =  state[B0];
        next_state[B2     ] =  state[B1];
        next_state[B3     ] =  state[B2];
        next_state[S_COUNT] = (state[B3]) || (state[S_COUNT] & ~done_counting);
        next_state[S_WAIT ] = (state[S_COUNT] & done_counting) || (state[S_WAIT] & ~ack);
    end
    
    assign B3_next    =   next_state[B3];
    assign S_next     =   next_state[S ];
    assign S1_next    =   next_state[S_1];
    assign Count_next =   next_state[S_COUNT];
    assign Wait_next  =   next_state[S_WAIT];
    assign done       =   state[S_WAIT] ;
    assign counting   =   state[S_COUNT];
    assign shift_ena  =   state[B0] 
                      ||  state[B1]
                      ||  state[B2]
                      ||  state[B3];

endmodule
