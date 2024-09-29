`timescale 1ns / 1ps

module tb_main;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns
    parameter DESIRED_FREQ = 5_000_000;
    // Inputs
    reg clk;
    reg rst;
    reg [7:0] phase;

    // Outputs
    wire signed [7:0] out;

    // Instantiate the DDS module
    main uut (
        .clk(clk),
        .rst(rst),
        .phase(phase),
        .desired_freq(DESIRED_FREQ),
        .out(out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk; // Toggle clock every half period
    end


    // Test sequence
    initial begin
        // Initialize inputs
        rst = 1;
        phase = 8'b0100_0000;  // Initial phase
        
        // Wait for a few clock cycles
        #20;
        // Release reset
        rst = 0;

        #10000; // Wait for some clock cycles

        

        $stop; // Stop simulation
    end

endmodule
