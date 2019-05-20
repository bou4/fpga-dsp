module i2s_tx #(
    parameter PDATA_WIDTH = 32
) (
    input wire lrck_in,
    input wire sclk_in,

    output wire sdata_out,

    input wire [PDATA_WIDTH - 1 : 0] pldata_in,
    input wire [PDATA_WIDTH - 1 : 0] prdata_in
);
    // LRCK delayed by 1 SCLK cyle
    reg lrck_d1_int;
    // LRCK delayed by 2 SCLK cycles
    reg lrck_d2_int;

    always @(posedge sclk_in)
        begin
            lrck_d1_int <= lrck_in;
            lrck_d2_int <= lrck_d1_int;
        end

    // LRCK pulse
    wire lrck_p_int;

    assign lrck_p_int = lrck_d1_int ^ lrck_d2_int;

    // Get input parallel data
    reg [PDATA_WIDTH - 1 : 0] pdata_int;

    always @(lrck_d1_int, pldata_in, prdata_in)
        if (lrck_d1_int)
            pdata_int = prdata_in;
        else
            pdata_int = pldata_in;

    // Shift input parallel data
    reg [PDATA_WIDTH - 1 : 0] piso_int;

    always @(negedge sclk_in)
        if (lrck_p_int)
            piso_int <= pdata_int;
        else
            piso_int <= {piso_int[PDATA_WIDTH - 2 : 0], 1'b0};

    // Set output serial data
    assign sdata_out = piso_int[PDATA_WIDTH - 1 : PDATA_WIDTH - 1];

endmodule
