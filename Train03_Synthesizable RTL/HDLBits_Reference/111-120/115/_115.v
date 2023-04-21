module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 
    
    reg[7:0] shift_reg;
    
    always@(posedge clk)
    begin
        if(enable)begin
            shift_reg <= {S,shift_reg[7:1]};
        end
    end
    
    always@(*) 
    begin
        case({A, B, C})
            3'd0: Z = shift_reg[7];
            3'd1: Z = shift_reg[6];
            3'd2: Z = shift_reg[5];
            3'd3: Z = shift_reg[4];
            3'd4: Z = shift_reg[3];
            3'd5: Z = shift_reg[2];
            3'd6: Z = shift_reg[1];
            3'd7: Z = shift_reg[0];
            default: Z = 8'd0;
        endcase
    end

endmodule
