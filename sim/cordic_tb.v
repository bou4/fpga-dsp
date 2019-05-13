`timescale 1ns / 1ps

module cordic_tb #(
    parameter WIDTH = 32,
    parameter ITERATIONS = 31
) (

);

    wire signed [WIDTH - 1 : 0] x_0;
    wire signed [WIDTH - 1 : 0] y_0;

    reg signed [WIDTH - 1 : 0] z_0;

    wire signed [WIDTH - 1 : 0] x_n;
    wire signed [WIDTH - 1 : 0] y_n;

    wire signed [WIDTH - 1 : 0] z_n;

    cordic #(
        .WIDTH (WIDTH),
        .ITERATIONS (ITERATIONS)
    ) cordic_inst (
    	.x_0 (x_0),
        .y_0 (y_0),
        .z_0 (z_0),
        .x_n (x_n),
        .y_n (y_n),
        .z_n (z_n)
    );

    assign x_0 = 32'b01000000000000000000000000000000;
    assign y_0 = 32'b00000000000000000000000000000000;

    initial
        begin
            z_0 = 0;
        end

    always
        begin
            // Sample rate of 48 kHz results in sine of 440 Hz
            #20833.333 z_0 = z_0 + 32'b00000010010110001011111100100101;
        end

endmodule
