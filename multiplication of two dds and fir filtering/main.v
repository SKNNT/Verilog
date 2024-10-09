`timescale 1ns / 1ps

module main(
    input wire clk,
    input wire rst,
    output wire signed [7:0] out_dds1,//5 МГц
    output wire signed [7:0] out_dds2,//10 МГц
    output wire signed [7:0] multiplied,
    output wire signed [7:0] out_fir
    );
dds dds_1
(
    .out(out_dds1),
    .clk(clk),
    .rst(rst),
    .phase(8'b0100_0000),
    .phase_increment(8'd13)//freq_out*2^N/freq_clock, N-Разрядность lut(256=2^8)
);

dds dds_2
(
    .out(out_dds2),
    .clk(clk),
    .rst(rst),
    .phase(8'b0100_0000),
    .phase_increment(8'd26)//freq_out*2^N/freq_clock, N-Разрядность lut(256=2^8)
);   

wire signed [15:0] multiplied_temp;
multiplier multiplier (
    .in1(out_dds1),
    .in2(out_dds2),
    .out(multiplied_temp)
);
assign multiplied = multiplied_temp[15:8];

wire signed [15:0] out_fir_temp;
fir fir_1
(
    .clk(clk),
    .rst(rst),
    .x(multiplied),
    .y(out_fir_temp)
);
assign out_fir = out_fir_temp[15:8];

endmodule



module dds
(
    output wire signed [7:0] out, 
    input clk,
    input rst,
    input [7:0] phase,
    input [7:0] phase_increment  
);
parameter CLOCK_FREQUENCY = 100_000_000;

reg [7:0] phase_acc = 0; 
reg signed [7:0] lut [0:255];
reg [7:0] phase_increment_internal; 
reg signed [7:0] out_internal;//чтобы использовать out как wire


initial begin
   $readmemb("I:/FPGA/Vivado/dds_signed/main/main.srcs/sources_1/new/lut_values.txt", lut); 
end
always @(posedge clk or posedge rst) begin
    if (rst) begin
        phase_acc <= phase;
        out_internal <= 0;
        phase_increment_internal <= phase_increment;
    end else begin
        phase_acc <= phase_acc + phase_increment_internal; 
        out_internal <= lut[phase_acc[7:0]]; 
    end
end
assign out = out_internal;
endmodule

module multiplier (
    input signed [7:0] in1,
    input signed [7:0] in2,
    output signed [15:0] out
);
    assign out = in1 * in2;
endmodule

module fir (
    input clk,
    input rst,
    input signed [7:0] x,
    output signed [15:0] y 
);
parameter N = 15;
reg signed [15:0] coeffs [0:N-1];
initial begin
    coeffs[0] = 0;
    coeffs[1] = 3;
    coeffs[2] = 0;
    coeffs[3] = -10;
    coeffs[4] = -15;
    coeffs[5] = -6;
    coeffs[6] = 14;
    coeffs[7] = 29;
    coeffs[8] = 14;
    coeffs[9] = -6;
    coeffs[10] = -15;
    coeffs[11] = -10;
    coeffs[12] = 0;
    coeffs[13] = 3;
    coeffs[14] = 0;
end

integer i;
reg signed [15:0] delay_line [0:N-1]; 
reg signed [15:0] y_internal;
initial begin
    for (i = 0; i < N; i = i + 1) begin
        delay_line[i] = 0;
    end
end

always @(posedge clk or posedge rst) begin
////////////////////////////////////////////////
    if (rst) begin
        for (i = 0; i < N; i = i + 1) begin
            delay_line[i] <= 0;
        end
        y_internal <= 0;
//////////////////////////////////////////////// 
    end else begin
        for (i = N-1; i > 0; i = i - 1) begin
            delay_line[i] = delay_line[i-1];//{1,2,3,0}->{0,1,2,3}
        end
        delay_line[0] = x; //{x,1,2,3}
        y_internal = 0;
        for (i = 0; i < N; i = i + 1) begin
            y_internal = y_internal + (delay_line[i] * coeffs[i]);
        end
    end
end
assign y = y_internal;
endmodule
