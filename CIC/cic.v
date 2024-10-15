`timescale 1ns / 1ps

module cic(
    input clk,
    input rst,
    input [7:0] data_in,
    output reg[15:0] data_out//Is 15 enough?
    );
    parameter Delay = 4;//delay comb 
    parameter R = 4;//Decimation factor
    parameter N = 3;// order 
    
    reg [15:0]integrator[0:N-1];//Is 15 enough?
    reg [15:0]comb[0:N-1];//Is 15 enough?
    reg [log2(R)-1:0] counter;
    reg [15:0] delay_line1 [0:Delay-1];
    reg [15:0] delay_line2 [0:Delay-1];
    reg [15:0] delay_line3 [0:Delay-1];
    integer i;
    
    function integer log2;
        input integer value;
        begin
            log2 = 0;
            while (2**log2 < value) begin
                log2 = log2 + 1;
            end
        end
    endfunction    
    
    
    always@(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            data_out <= 0;
            counter <= 0;
            for (i = 0; i < N; i = i + 1) 
            begin
                integrator[i] <= 0;
                comb[i] <= 0;
            end 
            for (i = 0; i < Delay; i = i + 1) begin
                delay_line1[i] <=0;
                delay_line2[i] <=0;
                delay_line3[i] <=0;
            end
            data_out <= 0;
        end else
        //integrator:
        begin
            integrator[0] = integrator[0] + data_in;//the current state is equal to the previous + date
            for (i = 1; i < N; i = i + 1) begin
                integrator[i] = integrator[i] + integrator[i-1];
            end
            
            //Decimation:
            if(counter != R-1)
            begin
                counter = counter +1;
            end else
            //comb:
            begin 
                comb[0] = integrator[N-1] - delay_line1[Delay-1];
                comb[1] = comb[0] - delay_line2[Delay-1];
                comb[2] = comb[1] - delay_line3[Delay-1];
                
                delay_line1[0] = integrator[N-1];
                delay_line2[0] = comb[0];
                delay_line3[0] = comb[1];
                
                for (i = Delay-1; i > 0; i = i - 1) begin
                    delay_line1[i] = delay_line1[i-1];
                    delay_line2[i] = delay_line2[i-1];
                    delay_line3[i] = delay_line3[i-1];
                end

                counter = 0;
                data_out = comb[2];
            end

        end
    end
    
endmodule
