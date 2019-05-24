module i2s #(
    parameter MCLK_DIV_LRCK = 256,
    parameter MCLK_DIV_SCLK = 4,
    parameter WIDTH = 32
) (
    input wire arstn,

    input wire mclk,

    output wire lrck,
    output wire sclk,

    input wire sdin,

    output wire [WIDTH - 1 : 0] pldout,
    output wire [WIDTH - 1 : 0] prdout,

    output wire sdout,

    input wire [WIDTH - 1 : 0] pldin,
    input wire [WIDTH - 1 : 0] prdin
);

    wire lrck_b;
    assign lrck = lrck_b;

    wire sclk_b;
    assign sclk = sclk_b;

    i2s_clk #(
        .MCLK_DIV_LRCK (MCLK_DIV_LRCK),
        .MCLK_DIV_SCLK (MCLK_DIV_SCLK)
    ) i2s_clk_inst (
    	.arstn (arstn),
        .mclk  (mclk),
        .lrck  (lrck_b),
        .sclk  (sclk_b)
    );

   i2s_rx #(
        .WIDTH (WIDTH)
   ) i2s_rx_inst (
        .lrck   (lrck_b),
        .sclk   (sclk_b),
        .sdin   (sdin),
        .pldout (pldout),
        .prdout (prdout)
   );

    i2s_tx #(
        .WIDTH (WIDTH)
    ) i2s_tx_inst (
        .lrck  (lrck_b),
        .sclk  (sclk_b),
        .sdout (sdout),
        .pldin (pldin),
        .prdin (prdin)
    );

endmodule
