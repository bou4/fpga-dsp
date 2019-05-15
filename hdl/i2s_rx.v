module i2s_rx #(
    parameter PDATA_WIDTH = 32
) (
    input wire arstn_in,

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

    always @(posedge sclk_in, negedge arstn_in)
        begin
            if (!arstn_in)
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
    wire lrck_p_int;

    assign lrck_p_int = lrck_d1_int ^ lrck_d2_int;

    // Enable signals of the flip-flops
    reg [PDATA_WIDTH - 1 : 0] enable_int;

    // Set the enable signals


    // Output signals of the flip-flops
    reg [PDATA_WIDTH - 1 : 0] pdata_int;

    genvar i;

    // Generate the flip-flops
    generate

    for (i = 0; i < PDATA_WIDTH - 1; i = i + 1)
        begin
            always @(posedge sclk_in, negedge arstn_in)
                begin
                    if (!arstn_in)
                        pdata_int <= {PDATA_WIDTH {1'b0}};
                    else if (enable_int[i])
                        pdata_int[i] <= sdata_in;
                end
        end

    endgenerate

    // Set output parallel data
    always @(sclk_in)
        begin
            if (lrck_p_int)
                begin
                    if (lrck_d1_int)
                        prdata_out <= pdata_int;
                    else
                        pldata_out <= pdata_int;
                end
        end

endmodule
