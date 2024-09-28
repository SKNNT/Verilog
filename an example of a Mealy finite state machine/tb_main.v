`timescale 1ns / 1ps

module tb_main;

    // Testbench signals
    reg reset;
    reg code;
    reg clock;
    wire y;

    // Instantiate the main module
    main uut (
        .reset(reset),
        .code(code),
        .clock(clock),
        .y(y)
    );

    // Generate clock signal
    initial begin
        clock = 0;
        forever #5 clock = ~clock; // 10 ns period
    end

    // Test sequence
    initial begin
        // Initialize signals
        reset = 1; 
        code = 0; 
        #10; // Wait for 10 ns

        reset = 0; // Release reset
        #10; // Wait for 10 ns

        // Extended test cases
        // Test case 1: code = 0 for multiple cycles
        code = 0; 
        #50; // Wait for 50 ns
        $display("Time: %t | code: %b | y: %b", $time, code, y);

        // Test case 2: code transitions to 1
        code = 1; 
        #50; // Wait for 50 ns
        $display("Time: %t | code: %b | y: %b", $time, code, y);

        // Test case 3: code transitions back to 0
        code = 0; 
        #50; // Wait for 50 ns
        $display("Time: %t | code: %b | y: %b", $time, code, y);

        // Test case 4: Continuous toggling of code
        repeat(5) begin
            code = ~code; 
            #20; // Wait for 20 ns before toggling again
            $display("Time: %t | code: %b | y: %b", $time, code, y);
        end

        // Test case 5: Assert reset again
        reset = 1; 
        #10; // Wait for reset duration
        reset = 0; 
        #30; // Wait to observe behavior after reset

        // Final state check after reset
        $display("Final Time after Reset: %t | Final y: %b", $time, y);
        
        // End simulation after a total of 500 ns elapsed time.
        #100;
        $finish;
    end

endmodule
