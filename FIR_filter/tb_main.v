`timescale 1ns / 1ps

module tb_main;



    // Inputs
    reg clk;
    reg nreset;
    reg signed [11:0] x;

    // Outputs
    wire signed [31:0] y;

    // Instantiate the FIR filter module
    main uut (
        .clk(clk),
        .nreset(nreset),
        .x(x),
        .y(y)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 time units clock period
    end

    // Test sequence
    initial begin
        // Initialize inputs
        nreset = 0;
        x = 0;

        // Apply reset
        #10;
        nreset = 1; // Release reset

        // Test input values
        #10 x = 12;   // First input value
        #10 x = -5;   // Second input value
        #10 x = 7;    // Third input value
        #10 x = -3;   // Fourth input value
        #10 x = 0;    // Fifth input value

        // More test inputs to observe behavior
        #10 x = 15;   // Sixth input value
        #10 x = -10;  // Seventh input value
        #10 x = 8;    // Eighth input value

        // Finish simulation after some time
        #50 $finish;
    end

    // Monitor output changes
        initial begin
        $monitor("Time: %0t | Input: %d | Output: %d", $time, x, y);
    end

endmodule