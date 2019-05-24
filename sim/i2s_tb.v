`timescale 1ns / 1ns

module i2s_tb ();
    reg arstn;

    reg mclk;

    wire lrck;
    wire sclk;

    wire sdin;

    wire [31 : 0] pldout;
    wire [31 : 0] prdout;

    wire sdout;

    reg [31 : 0] pldin;
    reg [31 : 0] prdin;

    i2s #(
        .MCLK_DIV_LRCK (256),
        .MCLK_DIV_SCLK (4),
        .WIDTH         (32)
    ) i2s_inst (
        .arstn  (arstn),
        .mclk   (mclk),
        .lrck   (lrck),
        .sclk   (sclk),
        .sdin   (sdin),
        .pldout (pldout),
        .prdout (prdout),
        .sdout  (sdout),
        .pldin  (pldin),
        .prdin  (prdin)
    );

    // Generate RST
    initial begin
        arstn = 1'b0;

        #20 arstn = 1'b1;
    end

    // Generate MCLK
    initial begin
        mclk = 1'b0;
    end

    always begin
        #10 mclk = ~mclk;
    end

    // Loopback
    assign sdin = sdout;

    // Assign TX parallel data
    initial begin
        pldin = 32'b0;
        prdin = 32'b0;
    end

    always @(posedge lrck) begin
        pldin <= pldin + 32'b1;
    end

endmodule
