`timescale 1ns / 1ps

module main(
    input wire reset,
    input wire code,
    output reg y,  
    input wire clock
);
    localparam S0 = 1'b0;
    localparam S1 = 1'b1;

    reg state;
    reg next_state;

 
    always @(*) begin
        case(state)
            S0: next_state = code ? S0 : S1;
            S1: next_state = code ? S0 : S1;
            default: next_state = S0;
        endcase
    end
    
    
    always @(posedge clock or posedge reset) begin
        if(reset) begin
            state <= S0;
            y <= 0; //
        end else begin
            state <= next_state;
            y <= state & code; //
        end
    end
// if we use this-> assign y = state & code; its will be not correct
endmodule
