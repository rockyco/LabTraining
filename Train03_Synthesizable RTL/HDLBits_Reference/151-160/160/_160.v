module top_module (input a, input b, input c, output out);//
    
    wire out_temp;
    assign out = ~out_temp;

    andgate inst1(
        .out(out_temp),
        .a(a),
        .b(b),
        .c(c),
        .d(1'b1),
        .e(1'b1)
    );

endmodule
