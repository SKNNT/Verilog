`timescale 1ns / 1ps

module main(
    input wire reset,
    input wire code,
    output wire y,
    input wire clock
    );
    localparam [1:0]s0 = 2'b00;
    localparam [1:0]s1 = 2'b01;
    localparam [1:0]s2 = 2'b10;
    
    reg [1:0]state;
    reg [1:0]next_state;
    
    
    //this->
    always @(*) begin
        case (state)
            s0: next_state = code ? s0 : s1; // Переход из s0
            s1: next_state = code ? s2 : s1; // Переход из s1
            s2: next_state = code ? s0 : s1; // Переход из s2
            default: next_state = s0; // По умолчанию
        endcase
    end
    //or this->
    /*always @(posedge clock, posedge reset) 
    begin
        if(reset) next_state=s0;
        else
            begin
            next_state[0]=~code;
            next_state[1]=code&state[0];
            end
    end
    */
    
    
    always @(posedge clock or posedge reset)
    begin
        if(reset) state<=s0;
        else state<=next_state;
    end
    
    assign y = state[1];//or this->assign y = (state == s2);
endmodule
