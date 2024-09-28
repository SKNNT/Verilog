`timescale 1ns / 1ps

module tb_main;

    // Parameters
    parameter CLOCK_PERIOD = 10; // Clock period in ns

    // Inputs
    reg reset;
    reg code;
    reg clock;

    // Outputs
    wire y;

    // Instantiate the main module
    main uut (
        .reset(reset),
        .code(code),
        .y(y),
        .clock(clock)
    );

    // Clock generation
    initial begin
        clock = 0;
        forever #(CLOCK_PERIOD / 2) clock = ~clock; // Toggle clock every half period
    end

    // Test procedure
    initial begin
        // Initialize inputs
        reset = 1;
        code = 0;

        // Wait for a few clock cycles
        #(CLOCK_PERIOD * 2);
        
        // Release reset
        reset = 0;
        
        // Test sequence
        // State transitions with different code values
        $display("Time\tReset\tCode\tState\tOutput");
        $monitor("%g\t%b\t%b\t%d\t%b", $time, reset, code, uut.state, y);

        // Test Case 1: Transition from s0 to s1 (code = 0)
        #CLOCK_PERIOD;
        code = 0; // Expecting transition to s1

        #CLOCK_PERIOD;
        code = 1; // Staying in s1

        #CLOCK_PERIOD;
        code = 1; // Transition to s2

        #CLOCK_PERIOD;
        code = 0; // Transition back to s1

        #CLOCK_PERIOD;
        code = 0; // Staying in s1
        
        // Test Case 2: Transition from s1 to s2 (code = 1)
        #CLOCK_PERIOD;
        code = 1; // Transition to s2
        
        #CLOCK_PERIOD;
        code = 0; // Transition back to s1
        
        // Test Case 3: Transition from s2 to s0 (code = 0)
        #CLOCK_PERIOD;
        code = 0; // Expecting transition to s1
        
        #CLOCK_PERIOD;
        code = 1; // Transition to s2
        
        #CLOCK_PERIOD;
        reset = 1; // Assert reset
        
        #CLOCK_PERIOD;
        reset = 0; // Release reset, should go back to state s0
        
        //#CLOCK_PERIOD * 5; // Wait for a while before finishing
        
        $finish; // End simulation
    end

endmodule
