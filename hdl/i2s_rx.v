module i2s_rx #(
    parameter PDATA_WIDTH = 32
) (
    input wire lrck_in,
    input wire sclk_in,

    input wire sdata_in,

    output reg [PDATA_WIDTH - 1 : 0] pldata_out,
    output reg [PDATA_WIDTH - 1 : 0] prdata_out
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

    // Count bits
    reg [5 : 0] cnt_int;

    always @(negedge sclk_in)
        if (lrck_p_int)
            cnt_int <= 6'b0;
        else
            cnt_int <= cnt_int + 6'b1;

    // Get input serial data
    reg [0 : PDATA_WIDTH - 1] pdata_int;

    always @(posedge sclk_in)
        if (lrck_p_int)
            pdata_int <= {PDATA_WIDTH {1'b0}};
        else if (cnt_int < PDATA_WIDTH)
            pdata_int[cnt_int] <= sdata_in;

    // Set output parallel data
    always @(posedge sclk_in)
        if (lrck_p_int)
            if (lrck_d1_int)
                prdata_out <= pdata_int;
            else
                pldata_out <= pdata_int;

endmodule
