module i2s_clk #(
    parameter MCLK_DIV_LRCK = 256,
    parameter MCLK_DIV_SCLK = 4
) (
    input wire rst_in,

    input wire mclk_in,

    output wire lrck_out,
    output wire sclk_out
);

endmodule
