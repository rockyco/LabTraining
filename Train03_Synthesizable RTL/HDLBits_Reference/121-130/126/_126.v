module top_module(
    input clk,
    input in,
    input reset,
    output out); //

    reg [1 : 0] curr_state;
    reg [1 : 0] next_state;
    
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;

    // State transition logic
    always@(*)
    begin
        case(curr_state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
        endcase
    end

    // State flip-flops with asynchronous reset
    always@(posedge clk)
    begin
        if(reset)
            curr_state <= A;
        else
            curr_state <= next_state;
    end

    // Output logic
    always@(*)
    begin
        case(curr_state)
            A: out = 1'b0;
            B: out = 1'b0;
            C: out = 1'b0;
            D: out = 1'b1;
        endcase
    end

endmodule
