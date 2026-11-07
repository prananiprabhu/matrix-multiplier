module matrix_multiplier (
    input  logic signed [7:0] a00, a01,
    input  logic signed [7:0] a10, a11,

    input  logic signed [7:0] b00, b01,
    input  logic signed [7:0] b10, b11,

    output logic signed [16:0] c00, c01,
    output logic signed [16:0] c10, c11
);

always_comb begin

    c00 = (a00 * b00) + (a01 * b10);
    c01 = (a00 * b01) + (a01 * b11);

    c10 = (a10 * b00) + (a11 * b10);
    c11 = (a10 * b01) + (a11 * b11);

end

endmodule
