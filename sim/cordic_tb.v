`timescale 1ns / 1ns

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
            #10 z_0 = z_0 + 32'b10000000000000000000000000;
        end

endmodule
