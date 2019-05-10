module i2s_trx #(
    parameter MCLK_DIV_LRCK = 256,
    parameter MCLK_DIV_SCLK = 4,
    parameter PDATA_WIDTH = 32
) (
    input wire rst_in,

    input wire mclk_in,

    output wire lrck_out,
    output wire sclk_out,

    input wire [PDATA_WIDTH - 1 : 0] pldata_in,
    input wire [PDATA_WIDTH - 1 : 0] prdata_in,

    output wire sdata_out
);

    wire lrck_int;
    assign lrck_out = lrck_int;

    wire sclk_int;
    assign sclk_out = sclk_int;

    i2s_clk #(
        .MCLK_DIV_LRCK (MCLK_DIV_LRCK),
        .MCLK_DIV_SCLK (MCLK_DIV_SCLK)
    ) i2s_clk_inst (
    	.rst_in (rst_in),
        .mclk_in (mclk_in),
        .lrck_out (lrck_int),
        .sclk_out (sclk_int)
    );

    i2s_tx #(
        .PDATA_WIDTH (PDATA_WIDTH)
    ) i2s_tx_inst (
    	.rst_in (rst_in),
        .lrck_in (lrck_int),
        .sclk_in (sclk_int),
        .pldata_in (pldata_in),
        .prdata_in (prdata_in),
        .sdata_out (sdata_out)
    );

    i2s_rx i2s_rx_inst ();

endmodule
