module i2s_clk #(
    parameter MCLK_DIV_LRCK = 256,
    parameter MCLK_DIV_SCLK = 4
) (
    input wire arstn,

    input wire mclk,

    output wire lrck,
    output wire sclk
);

    // MCLK_DIV_LRCK is maximally 2 ** 10
    reg [10 : 0] lrck_cnt;

    always @(posedge mclk, negedge arstn)
        if (arstn == 1'b0)
            lrck_cnt <= 0;
        else
            if (lrck_cnt == MCLK_DIV_LRCK - 1)
                lrck_cnt <= 0;
            else
                lrck_cnt <= lrck_cnt + 1;

    assign lrck = (lrck_cnt < MCLK_DIV_LRCK / 2) ? 1'b0 : 1'b1;

    // MCLK_DIV_SCLK is maximally 2 ** 10
    reg [10 : 0] sclk_cnt;

    always @(posedge mclk, negedge arstn)
        if (arstn == 1'b0)
            sclk_cnt <= 0;
        else
            if (sclk_cnt == MCLK_DIV_SCLK - 1)
                sclk_cnt <= 0;
            else
                sclk_cnt <= sclk_cnt + 1;

    assign sclk = (sclk_cnt < MCLK_DIV_SCLK / 2) ? 1'b0 : 1'b1;

endmodule
