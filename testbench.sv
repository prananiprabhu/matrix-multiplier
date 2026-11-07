

module tb_matrix_multiplier;

logic signed [7:0] a00, a01, a10, a11;
logic signed [7:0] b00, b01, b10, b11;

wire signed [16:0] c00, c01, c10, c11;

// Instantiate the design
matrix_multiplier DUT (
    .a00(a00), .a01(a01),
    .a10(a10), .a11(a11),

    .b00(b00), .b01(b01),
    .b10(b10), .b11(b11),

    .c00(c00), .c01(c01),
    .c10(c10), .c11(c11)
);

// Reference model
integer r00, r01, r10, r11;

task automatic check_result;

begin
    #10;

    // Software reference calculation
    r00 = (a00*b00) + (a01*b10);
    r01 = (a00*b01) + (a01*b11);

    r10 = (a10*b00) + (a11*b10);
    r11 = (a10*b01) + (a11*b11);

    $display("--------------------------------");
    $display("Output Matrix:");
    $display("%0d  %0d", c00, c01);
    $display("%0d  %0d", c10, c11);

    if ((c00 == r00) && (c01 == r01) &&
        (c10 == r10) && (c11 == r11))
        $display("TEST PASSED");
    else
        $display("TEST FAILED");

end
endtask

initial begin

    $dumpfile("matrix.vcd");
    $dumpvars(0, tb_matrix_multiplier);

    // Test 1: Normal matrix multiplication
    $display("TEST 1: Normal Matrix");

    a00=1; a01=2;
    a10=3; a11=4;

    b00=5; b01=6;
    b10=7; b11=8;

    check_result();

    // Test 2: Identity matrix
    $display("TEST 2: Identity Matrix");

    a00=1; a01=2;
    a10=3; a11=4;

    b00=1; b01=0;
    b10=0; b11=1;

    check_result();

    // Test 3: Zero matrix
    $display("TEST 3: Zero Matrix");

    a00=1; a01=2;
    a10=3; a11=4;

    b00=0; b01=0;
    b10=0; b11=0;

    check_result();

    // Test 4: Signed values
    $display("TEST 4: Signed Matrix");

    a00=-1; a01=2;
    a10=3; a11=-4;

    b00=5; b01=-6;
    b10=-7; b11=8;

    check_result();

    $display("--------------------------------");
    $display("All tests completed.");

    $finish;

end


endmodule