module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//

    // assign intermediate_result1 = compare? true: false;
    wire [7 : 0] min_ab;
    wire [7 : 0] min_cd;
    
    assign min_ab = (a < b) ? a : b;
    assign min_cd = (c < d) ? c : d;
    
    assign min = (min_ab < min_cd) ? min_ab : min_cd;

endmodule
