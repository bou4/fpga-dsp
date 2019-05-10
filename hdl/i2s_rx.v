module i2s_rx #(
    parameter PDATA_WIDTH = 32
) (
    input wire rst_in,

    input wire lrck_in,
    input wire sclk_in,

    input wire sdata_in,

    output wire [PDATA_WIDTH - 1 : 0] pldata_out,
    output wire [PDATA_WIDTH - 1 : 0] prdata_out
);

    // TODO

endmodule
