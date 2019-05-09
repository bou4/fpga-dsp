`timescale 1ps/1fs

module i2s_tx_tb (

);

    reg rst_int;

    reg sclk_int;
    reg lrck_int;

    reg [31 : 0] pldata_int;
    reg [31 : 0] prdata_int;

    wire sdata_int;

    i2s_tx #(
        .PDATA_WIDTH (32)
    ) i2s_tx_inst (
        .rst_in    (rst_int   ),
        .sclk_in   (sclk_int  ),
        .lrck_in   (lrck_int  ),
        .pldata_in (pldata_int),
        .prdata_in (prdata_int),
        .sdata_out (sdata_int )
    );

    // Generate RESET
    initial
        begin
            rst_int = 1'b1;

            #20833.333 rst_int = 1'b0;
        end

    // Generate SCLK (64 * 48 MHz) and LRCK (48 MHz)
    initial
        begin
            sclk_int = 1'b0;
            lrck_int = 1'b1;
        end

    always
        begin
            #325.521 sclk_int = ~sclk_int;
        end

    always
        begin
            #20833.333 lrck_int = ~lrck_int;
        end

    // Generate PDATA
    initial
        begin
            pldata_int = { 32 { 1'b0 } };
            prdata_int = { 32 { 1'b0 } };

            #41666.688 pldata_int = 32'b11110000111100001111000011110000;
                       prdata_int = 32'b00001111000011110000111100001111;
        end

    always
        begin
            #20833.344 pldata_int = 32'b01010101010101010101010101010101;
                       prdata_int = 32'b10101010101010101010101010101010;

            #20833.344 pldata_int = 32'b11110000111100001111000011110000;
                       prdata_int = 32'b00001111000011110000111100001111;
        end

endmodule
