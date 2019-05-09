module i2s_tx #(
    parameter pdata_width = 32
) (
    input wire rst,

    input wire sclk_in,
    input wire lrck_in,

    input wire [pdata_width - 1 : 0] pldata_in,
    input wire [pdata_width - 1 : 0] prdata_in,

    output reg sdata_out
);

    // LRCK delayed by 1 SCLK cyle
    reg lrck_d1_int;
    // LRCK delayed by 2 SCLK cycles
    reg lrck_d2_int;

    always @(posedge sclk_in)
        begin
            if (rst)
                begin
                    lrck_d1_int <= 1'b0;
                    lrck_d2_int <= 1'b0;
                end
            else
                begin
                    lrck_d1_int <= lrck_in;
                    lrck_d2_int <= lrck_d1_int;
                end
        end

    // LRCK pulse
    wire lrck_p_int = lrck_d1_int ^ lrck_d2_int;

    // Select channel
    reg pdata_int;

    always @(lrck_d1_int, pldata_in, prdata_in)
        begin
            if (lrck_d1_int)
                pdata_int <= prdata_in;
            else
                pdata_int <= pldata_in;
        end

endmodule
