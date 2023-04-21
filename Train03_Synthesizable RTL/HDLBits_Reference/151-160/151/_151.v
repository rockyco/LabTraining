module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    
    localparam FSM_W  = 10;
    localparam FSM_W1 = FSM_W - 1'b1;

    reg [FSM_W1 : 0]   curr_state;
    reg [FSM_W1 : 0]   next_state;

    localparam  IDLE      = 0;
    localparam  AFT_RST   = 1;
    localparam  STRT_X_MNT= 2;
    localparam  X_1       = 3;
    localparam  X_0       = 4;
    localparam  X_10      = 5;
    localparam  X_101     = 6;
    localparam  Y_S0      = 7;
    localparam  G_O0      = 8;
    localparam  G_O1      = 9;

    // State transition logic (combinational)
    always @(*) begin
        next_state[IDLE      ]          =   1'b0; // never reach for nxt_state
        next_state[AFT_RST   ]          =   (curr_state[IDLE   ]);
        next_state[STRT_X_MNT]          =   (curr_state[AFT_RST]);
        next_state[X_1       ]          =   (curr_state[STRT_X_MNT] &&  x) || (curr_state[X_1    ] &&  x) || (curr_state[X_0    ] &&  x);
        next_state[X_0       ]          =   (curr_state[STRT_X_MNT] && ~x) || (curr_state[X_10   ] && ~x) || (curr_state[X_0    ] && ~x);
        next_state[X_10      ]          =   (curr_state[X_1    ] && ~x);
        next_state[X_101     ]          =   (curr_state[X_10   ] &&  x);
        next_state[Y_S0      ]          =   (curr_state[X_101  ] && ~y);
        next_state[G_O0      ]          =   (curr_state[Y_S0   ] && ~y) ||  curr_state[G_O0   ];
        next_state[G_O1      ]          =   (curr_state[Y_S0   ] &&  y) || (curr_state[X_101  ] &&  y) || curr_state[G_O1   ];
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if(~resetn)
            curr_state   <=  'b1; //IDLE
        else begin
            curr_state   <=  next_state;
        end  
    end

    //output logic
    assign  f    =    curr_state[AFT_RST];
    assign  g    =   (curr_state[X_101] || curr_state[G_O1] || curr_state[Y_S0]) ? 1'b1 : 1'b0;

endmodule
