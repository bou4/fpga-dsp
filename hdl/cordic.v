module cordic #(
    parameter WIDTH = 32,
    parameter ITERATIONS = 31
) (
    input wire signed [WIDTH - 1 : 0] x_0,
    input wire signed [WIDTH - 1 : 0] y_0,
    input wire signed [WIDTH - 1 : 0] z_0,

    output wire signed [WIDTH - 1 : 0] x_n,
    output wire signed [WIDTH - 1 : 0] y_n,
    output wire signed [WIDTH - 1 : 0] z_n
);

    reg [WIDTH - 1 : 0] arctan [0 : ITERATIONS - 1];

    initial
        begin
            $readmemb("arctan.mem", arctan);
        end

    reg signed [WIDTH - 1 : 0] x [0 : ITERATIONS - 1];
    reg signed [WIDTH - 1 : 0] y [0 : ITERATIONS - 1];
    reg signed [WIDTH - 1 : 0] z [0 : ITERATIONS - 1];

    wire [1 : 0] quadrant;

    assign quadrant = z_0[WIDTH - 1 : WIDTH - 2];

    always @(x_0, y_0, z_0)
        begin
            case(quadrant)
                2'b00, 2'b11:
                    begin
                        x[0] = x_0;
                        y[0] = y_0;
                        z[0] = z_0;
                    end
                2'b01:
                    begin
                        x[0] = -y_0;
                        y[0] = x_0;
                        z[0] = {2'b00, z_0[WIDTH - 3 : 0]};
                    end
                2'b10:
                    begin
                        x[0] = y_0;
                        y[0] = -x_0;
                        z[0] = {2'b11, z_0[WIDTH - 3 : 0]};
                    end
            endcase
        end

    genvar i;

    generate

    for (i = 0; i < ITERATIONS - 1; i = i + 1)
        begin
            wire z_sign;

            assign z_sign = z[i][WIDTH - 1];

            wire signed [WIDTH - 1 : 0] x_shr, y_shr;

            assign x_shr = x[i] >>> i;
            assign y_shr = y[i] >>> i;

            always @(x[i], y[i], z[i])
                begin
                    x[i + 1] = z_sign ? x[i] + y_shr : x[i] - y_shr;
                    y[i + 1] = z_sign ? y[i] - x_shr : y[i] + x_shr;
                    z[i + 1] = z_sign ? z[i] + arctan[i] : z[i] - arctan[i];
                end
        end

    endgenerate

    assign x_n = x[ITERATIONS - 1];
    assign y_n = y[ITERATIONS - 1];
    assign z_n = z[ITERATIONS - 1];

endmodule
