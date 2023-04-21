`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
    
    wire temp_ab;
    wire temp_cd;
    
    assign temp_ab = a & b;
    assign temp_cd = c & d;
    assign out = temp_ab | temp_cd;
    assign out_n = ~(temp_ab | temp_cd);

endmodule
