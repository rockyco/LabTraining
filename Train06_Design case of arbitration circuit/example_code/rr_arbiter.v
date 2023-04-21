// Round-robin arbiter
module rr_arbiter #(
    parameter N = 5
)(
    input   logic           clk,
    input   logic           rstn,
    input   logic [N-1:0]   req,
    output  logic [N-1:0]   grant
);

    logic [N-1:0]   nxt_grant;
    logic [N-1:0]   nxt_req;
    logic [N-1:0]   mask_h;
    logic [N-1:0]   mask_l;
    logic [N-1:0]   req_h;
    logic [N-1:0]   req_l;

    always @(posedge clk or negedge rstn)
        if(!rstn)
            grant <= {N{1'b0}};
        else 
            grant <= nxt_grant;

    assign mask_l = {grant[N-2:0],1'b0} - 1'b1;
    assign mask_h = ~mask_l;
    assign req_h  = req & mask_h;
    assign req_l  = req & mask_l;
    assign nxt_req = |req_h ? req_h : req_l;
    assign nxt_grant = nxt_req & (~nxt_req + 1'b1);

endmodule