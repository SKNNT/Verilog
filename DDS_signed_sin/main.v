module main (
    input clk,
    input rst,
    input [5:0] freq_res, 
    input [7:0] phase,    
    output reg signed [7:0] out 
);

reg [7:0] phase_acc = 0; 
reg signed [7:0] lut [0:63]; 

initial begin
    $readmemb("I:/FPGA/Vivado/dds_signed/main/main.srcs/sources_1/new/lut_values.txt", lut);
    /*
     lut[0] = 0;
     lut[1] = 12;
     lut[2] = 25;
     lut[3] = 37;
     lut[4] = 49;
     lut[5] = 60;
     lut[6] = 71;
     lut[7] = 81;
     lut[8] = 90;
     lut[9] = 98;
     lut[10] = 106;
     lut[11] = 112;
     lut[12] = 117;
     lut[13] = 122;
     lut[14] = 125;
     lut[15] = 126;
     lut[16] = 127;
     lut[17] = 126;
     lut[18] = 125;
     lut[19] = 122;
     lut[20] = 117;
     lut[21] = 112;
     lut[22] = 106;
     lut[23] = 98;
     lut[24] = 90;
     lut[25] = 81;
     lut[26] = 71;
     lut[27] = 60;
     lut[28] = 49;
     lut[29] = 37;
     lut[30] = 25;
     lut[31] = 12;
     lut[32] = 0;
     lut[33] = -12;
     lut[34] = -25;
     lut[35] = -37;
     lut[36] = -49;
     lut[37] = -60;
     lut[38] = -71;
     lut[39] = -81;
     lut[40] = -90;
     lut[41] = -98;
     lut[42] = -106;
     lut[43] = -112;
     lut[44] = -117;
     lut[45] = -122;
     lut[46] = -125;
     lut[47] = -126;
     lut[48] = -127;
     lut[49] = -126;
     lut[50] = -125;
     lut[51] = -122;
     lut[52] = -117;
     lut[53] = -112;
     lut[54] = -106;
     lut[55] = -98;
     lut[56] = -90;
     lut[57] = -81;
     lut[58] = -71;
     lut[59] = -60;
     lut[60] = -49;
     lut[61] = -37;
     lut[62] = -25;
     lut[63] = -12;
     */
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        phase_acc <= 0;
        out <= 0;
    end else begin
        phase_acc <= phase_acc + freq_res; // Инкрементируем фазовый аккумулятор
        out <= lut[phase_acc[7:2]]; // Получаем значение из LUT
        // Преобразование в знаковый формат
       // if (out > 127) out <= out - 256; // Приводим к диапазону -128..127
    end
end

endmodule
