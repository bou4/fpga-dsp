`timescale 1ns / 1ns

module i2s_trx_tb #(
    parameter PDATA_WIDTH = 32
) ();

    reg arstn_int;

    reg mclk_int;

    wire lrck_int;
    wire sclk_int;

    wire rx_sdata_int;

    wire [PDATA_WIDTH - 1 : 0] rx_pldata_int;
    wire [PDATA_WIDTH - 1 : 0] rx_prdata_int;

    wire tx_sdata_int;

    reg [PDATA_WIDTH - 1 : 0] tx_pldata_int;
    reg [PDATA_WIDTH - 1 : 0] tx_prdata_int;

    i2s_trx #(
        .MCLK_DIV_LRCK (256),
        .MCLK_DIV_SCLK (4),
        .PDATA_WIDTH (32)
    ) i2s_trx_inst (
        .arstn_in (arstn_int),
        .mclk_in (mclk_int),
        .lrck_out (lrck_int),
        .sclk_out (sclk_int),
        .sdata_in (rx_sdata_int),
        .pldata_out (rx_pldata_int),
        .prdata_out (rx_prdata_int),
        .sdata_out (tx_sdata_int),
        .pldata_in (tx_pldata_int),
        .prdata_in (tx_prdata_int)
    );

    // Generate RST
    initial
        begin
            arstn_int = 1'b0;

            #20 arstn_int = 1'b1;
        end

    // Generate MCLK
    initial
        begin
            mclk_int = 1'b0;
        end

    always
        begin
            #10 mclk_int = ~mclk_int;
        end

    // Loopback
    assign rx_sdata_int = tx_sdata_int;

    // Assign TX parallel data
    initial
        begin
            tx_pldata_int = 32'b0;
            tx_prdata_int = 32'b0;
        end

    always @(posedge lrck_int)
        tx_pldata_int <= tx_pldata_int + 32'b1;

endmodule
