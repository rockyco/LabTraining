module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    
    reg [3 : 0] curr_state;
    reg [3 : 0] next_state;

    wire        w_shft_ena;
    reg [1 : 0] w_cntr;
    localparam A  = 4'd0;
    localparam B  = 4'd1;
    localparam B1 = 4'd2;
    localparam B2 = 4'd4;

    // State transition logic (combinational)
    always @(*) 
    begin
        case(curr_state)
            A : next_state = s ? B : A;
            B : next_state = B1;
            B1: next_state = B2;
            B2: next_state = B;
          default: next_state = A;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk ) begin
        if(reset)
            curr_state <= A;
        else begin
            curr_state <= next_state;
        end  
    end

    always @(posedge clk ) begin
        if(reset)
            w_cntr <= 2'b0;
        else if(curr_state == B)begin
            w_cntr <= w;
        end
        else if(curr_state == B1 || curr_state == B2)begin
            w_cntr <= w_cntr + w;
        end
    end

    assign  z = (curr_state == B && w_cntr == 2) ? 1'b1 : 1'b0;

endmodule
