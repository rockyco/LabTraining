module top_module (
    input [3:1] y,
    input w,
    output Y2);
    
    wire [3 : 1] curr_state = y[3 : 1];
    reg  [3 : 1] next_state;
    
    parameter A = 3'd0;
    parameter B = 3'd1;
    parameter C = 3'd2;
    parameter D = 3'd3;
    parameter E = 3'd4;
    parameter F = 3'd5;
    
    always@(*)
    begin
        case(curr_state)
            A: next_state = w ? A : B;
            B: next_state = w ? D : C;
            C: next_state = w ? D : E;
            D: next_state = w ? A : F;
            E: next_state = w ? D : E;
            F: next_state = w ? D : C;
            default: next_state = A;
        endcase
    end
    
    assign Y2 = next_state[2];

endmodule
