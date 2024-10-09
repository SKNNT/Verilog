`timescale 1ns / 1ps

module tb_main;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns

    // Signals
    reg clk;
    reg rst;
    wire signed [7:0] out_dds1;
    wire signed [7:0] out_dds2;
    wire signed [7:0] multiplied;
    wire signed [7:0] out_fir;
    // Instantiate the main module
    main dut (
        .clk(clk),
        .rst(rst),
        .out_dds1(out_dds1),
        .out_dds2(out_dds2),
        .multiplied(multiplied),
        .out_fir(out_fir)
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

        
        // Wait for a few clock cycles
        #20;
        // Release reset
        rst = 0;

        #10000; // Wait for some clock cycles

        

        $stop; // Stop simulation
    end

endmodule
