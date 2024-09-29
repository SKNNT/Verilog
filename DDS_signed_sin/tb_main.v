`timescale 1ns / 1ps

module tb_main;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns
    
    // Inputs
    reg clk;
    reg rst;
    reg [5:0] freq_res;
    reg [7:0] phase;

    // Outputs
    wire signed [7:0] out;

    // Instantiate the DDS module
    main uut (
        .clk(clk),
        .rst(rst),
        .freq_res(freq_res),
        .phase(phase),
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
        freq_res = 6'b000000; // Initial frequency resolution
        phase = 8'b00000000;  // Initial phase
        
        // Wait for a few clock cycles
        #20;

        // Release reset
        rst = 0;
        
        // Test case 1: Change frequency resolution and observe output
        freq_res = 6'b001000; // Small frequency increment
        #10000; // Wait for some clock cycles

        

        $stop; // Stop simulation
    end

endmodule
