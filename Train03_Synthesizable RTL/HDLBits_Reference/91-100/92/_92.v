module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    
    wire temp1 = E ? w : Q;
    wire temp2 = L ? R : temp1;
    
    always@(posedge clk)
        Q <= temp2;

endmodule
