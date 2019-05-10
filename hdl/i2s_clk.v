module i2s_clk #(
    parameter MCLK_DIV_LRCK = 256,
    parameter MCLK_DIV_SCLK = 4
) (
    input wire rst_in,

    input wire mclk_in,

    output wire lrck_out,
    output wire sclk_out
);

    // MCLK_DIV_LRCK is maximally 2 ** 10
    reg [10 : 0] lrck_cnt_int;

    always @(posedge mclk_in)
        begin
            if (rst_in)
                lrck_cnt_int <= 0;
            else
                begin
                    if (lrck_cnt_int == MCLK_DIV_LRCK - 1)
                        lrck_cnt_int <= 0;
                    else
                        lrck_cnt_int <= lrck_cnt_int + 1;
                end
        end

    assign lrck_out = (lrck_cnt_int < MCLK_DIV_LRCK / 2) ? 1'b0 : 1'b1;

    // MCLK_DIV_SCLK is maximally 2 ** 10
    reg [10 : 0] sclk_cnt_int;

    always @(posedge mclk_in)
        begin
            if (rst_in)
                sclk_cnt_int <= 0;
            else
                begin
                    if (sclk_cnt_int == MCLK_DIV_SCLK - 1)
                        sclk_cnt_int <= 0;
                    else
                        sclk_cnt_int <= sclk_cnt_int + 1;
                end
        end

    assign sclk_out = (sclk_cnt_int < MCLK_DIV_SCLK / 2) ? 1'b0 : 1'b1;

endmodule
