module i2s_trx #(
    parameter MCLK_DIV_LRCK = 256,
    parameter MCLK_DIV_SCLK = 4,
    parameter PDATA_WIDTH = 32
) (
    input wire arstn_in,

    input wire mclk_in,

    output wire lrck_out,
    output wire sclk_out,

    input wire sdata_in,

    output wire [PDATA_WIDTH - 1 : 0] pldata_out,
    output wire [PDATA_WIDTH - 1 : 0] prdata_out,

    output wire sdata_out,

    input wire [PDATA_WIDTH - 1 : 0] pldata_in,
    input wire [PDATA_WIDTH - 1 : 0] prdata_in
);

    wire lrck_int;
    assign lrck_out = lrck_int;

    wire sclk_int;
    assign sclk_out = sclk_int;

    i2s_clk #(
        .MCLK_DIV_LRCK (MCLK_DIV_LRCK),
        .MCLK_DIV_SCLK (MCLK_DIV_SCLK)
    ) i2s_clk_inst (
    	.arstn_in (arstn_in),
        .mclk_in (mclk_in),
        .lrck_out (lrck_int),
        .sclk_out (sclk_int)
    );

   i2s_rx #(
        .PDATA_WIDTH (PDATA_WIDTH)
   ) i2s_rx_inst (
        .lrck_in (lrck_int),
        .sclk_in (sclk_int),
        .sdata_in (sdata_in),
        .pldata_out (pldata_out),
        .prdata_out (prdata_out)
   );

    i2s_tx #(
        .PDATA_WIDTH (PDATA_WIDTH)
    ) i2s_tx_inst (
        .lrck_in (lrck_int),
        .sclk_in (sclk_int),
        .sdata_out (sdata_out),
        .pldata_in (pldata_in),
        .prdata_in (prdata_in)
    );

endmodule
