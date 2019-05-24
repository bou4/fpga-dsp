module i2s_tx #(
    parameter WIDTH = 32
) (
    input wire lrck,
    input wire sclk,

    output wire sdout,

    input wire [WIDTH - 1 : 0] pldin,
    input wire [WIDTH - 1 : 0] prdin
);
    // LRCK delayed by 1 SCLK cyle
    reg lrck_d1;
    // LRCK delayed by 2 SCLK cycles
    reg lrck_d2;

    always @(posedge sclk) begin
        lrck_d1 <= lrck;
        lrck_d2 <= lrck_d1;
    end

    // LRCK pulse
    wire lrck_p;

    assign lrck_p = lrck_d1 ^ lrck_d2;

    // Get input parallel data
    reg [WIDTH - 1 : 0] pdata;

    always @(*) begin
        if (lrck_d1) begin
            pdata = prdin;
        end else begin
            pdata = pldin;
        end
    end

    // Shift input parallel data
    reg [WIDTH - 1 : 0] piso;

    always @(negedge sclk) begin
        if (lrck_p) begin
            piso <= pdata;
        end else begin
            piso <= {piso[WIDTH - 2 : 0], 1'b0};
        end
    end

    // Set output serial data
    assign sdout = piso[WIDTH - 1 : WIDTH - 1];

endmodule
