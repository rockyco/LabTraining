module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //
    
    reg [3 : 0] Q_0;
    reg [3 : 0] Q_1;
    reg [3 : 0] Q_2;
    
    assign c_enable[0] = 1'b1;
    assign c_enable[1] = (Q_0 == 4'd9) ? 1'b1 : 1'b0;
    assign c_enable[2] = ((Q_1 == 4'd9) && (Q_0 == 4'd9)) ? 1'b1 : 1'b0;
    
    assign OneHertz    = (Q_2 == 4'd9) && (Q_1 == 4'd9) && (Q_0 == 4'd9);

    bcdcount COUNT0(
        .clk(clk),
        .reset(reset),
        .enable(c_enable[0]),
        .Q(Q_0)
    ); 
    
    bcdcount COUNT1(
        .clk(clk),
        .reset(reset),
        .enable(c_enable[1]),
        .Q(Q_1)
    ); 
    
    bcdcount COUNT2(
        .clk(clk),
        .reset(reset),
        .enable(c_enable[2]),
        .Q(Q_2)
    ); 
    
endmodule
