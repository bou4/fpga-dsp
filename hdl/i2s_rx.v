module i2s_rx #(
    parameter WIDTH = 32
) (
    input wire lrck,
    input wire sclk,

    input wire sdin,

    output reg [WIDTH - 1 : 0] pldout,
    output reg [WIDTH - 1 : 0] prdout
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

    // Count bits
    reg [5 : 0] cnt;

    always @(negedge sclk) begin
        if (lrck_p) begin
            cnt <= 6'b0;
        end else begin
            cnt <= cnt + 6'b1;
        end
    end

    // Get input serial data
    reg [WIDTH - 1 : 0] pdata;

    always @(posedge sclk) begin
        if (lrck_p) begin
            pdata <= {WIDTH {1'b0}};
        end else if (cnt < WIDTH) begin
            pdata[(WIDTH - 1) - cnt] <= sdin;
        end
    end

    // Set output parallel data
    always @(negedge sclk) begin
        if (lrck_p) begin
            if (lrck_d1) begin
                prdout <= pdata;
            end else begin
                pldout <= pdata;
            end
        end
    end

endmodule
