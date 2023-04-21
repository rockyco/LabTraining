module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    
    assign ena[1] = (q[3 : 0] == 4'd9) ? 1'b1 : 1'b0;
    assign ena[2] = ((q[3 : 0] == 4'd9) && (q[7 : 4] == 4'd9)) ? 1'b1 : 1'b0;
    assign ena[3] = ((q[3 : 0] == 4'd9) && (q[7 : 4] == 4'd9) && (q[11 : 8] == 4'd9)) ? 1'b1 : 1'b0;
    
    bcd_count COUNT0(
        .clk(clk),
        .reset(reset),
        .ena(1'b1),
        .q(q[3 : 0])
    );
    
    bcd_count COUNT1(
        .clk(clk),
        .reset(reset),
        .ena(ena[1]),
        .q(q[7 : 4])
    );
    
    bcd_count COUNT2(
        .clk(clk),
        .reset(reset),
        .ena(ena[2]),
        .q(q[11 : 8])
    );
    
    bcd_count COUNT3(
        .clk(clk),
        .reset(reset),
        .ena(ena[3]),
        .q(q[15 : 12])
    );

endmodule

module bcd_count(
    input clk,
    input reset,
    input ena,
    output [3 : 0] q
);
    
    always@(posedge clk)
    begin
        if(reset) begin
            q <= 4'd0;
        end
        else if(ena) begin
            if(q < 4'd9) begin
                q <= q + 1'b1;
            end
            else begin
                q <= 4'd0;
            end
        end
        else begin
            q <= q;
        end
    end
    
endmodule
