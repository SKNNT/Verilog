module dds_sine (
    input wire clk,
    input wire reset,
    input wire [7:0] fcw,
    output signed [7:0] audio_out//для безнакового хватает 8,а для знакового нет, нужно 16
);
    wire [7:0] phase;
    wire signed [7:0] sine_value;

    phase_accumulator pa (
        .clk(clk),
        .reset(reset),
        .fcw(fcw),
        .phase(phase)
    );

    sine_lut lut (
        .phase(phase),
        .sine_out(sine_value)
    );

    assign audio_out = sine_value; 
endmodule




module sine_lut (
    input wire [7:0] phase,
    output reg signed [7:0] sine_out
);
    always @(*) begin
        case(phase[7:0]) // LUT, синус имеет постоянную составляющую на уровне 127
							// создание LUT таблицы осуществляет py-скрипт
							 8'b00000000: sine_out = 8'b01111111; // 0.00 degrees
							 8'b00000001: sine_out = 8'b10000010; // 1.41 degrees
							 8'b00000010: sine_out = 8'b10000101; // 2.81 degrees
							 8'b00000011: sine_out = 8'b10001000; // 4.22 degrees
							 8'b00000100: sine_out = 8'b10001011; // 5.62 degrees
							 8'b00000101: sine_out = 8'b10001110; // 7.03 degrees
							 8'b00000110: sine_out = 8'b10010001; // 8.44 degrees
							 8'b00000111: sine_out = 8'b10010100; // 9.84 degrees
							 8'b00001000: sine_out = 8'b10010111; // 11.25 degrees
							 8'b00001001: sine_out = 8'b10011010; // 12.66 degrees
							 8'b00001010: sine_out = 8'b10011101; // 14.06 degrees
							 8'b00001011: sine_out = 8'b10100000; // 15.47 degrees
							 8'b00001100: sine_out = 8'b10100011; // 16.88 degrees
							 8'b00001101: sine_out = 8'b10100110; // 18.28 degrees
							 8'b00001110: sine_out = 8'b10101001; // 19.69 degrees
							 8'b00001111: sine_out = 8'b10101100; // 21.09 degrees
							 8'b00010000: sine_out = 8'b10101111; // 22.50 degrees
							 8'b00010001: sine_out = 8'b10110010; // 23.91 degrees
							 8'b00010010: sine_out = 8'b10110101; // 25.31 degrees
							 8'b00010011: sine_out = 8'b10111000; // 26.72 degrees
							 8'b00010100: sine_out = 8'b10111010; // 28.12 degrees
							 8'b00010101: sine_out = 8'b10111101; // 29.53 degrees
							 8'b00010110: sine_out = 8'b11000000; // 30.94 degrees
							 8'b00010111: sine_out = 8'b11000010; // 32.34 degrees
							 8'b00011000: sine_out = 8'b11000101; // 33.75 degrees
							 8'b00011001: sine_out = 8'b11001000; // 35.16 degrees
							 8'b00011010: sine_out = 8'b11001010; // 36.56 degrees
							 8'b00011011: sine_out = 8'b11001101; // 37.97 degrees
							 8'b00011100: sine_out = 8'b11001111; // 39.38 degrees
							 8'b00011101: sine_out = 8'b11010001; // 40.78 degrees
							 8'b00011110: sine_out = 8'b11010100; // 42.19 degrees
							 8'b00011111: sine_out = 8'b11010110; // 43.59 degrees
							 8'b00100000: sine_out = 8'b11011000; // 45.00 degrees
							 8'b00100001: sine_out = 8'b11011010; // 46.41 degrees
							 8'b00100010: sine_out = 8'b11011101; // 47.81 degrees
							 8'b00100011: sine_out = 8'b11011111; // 49.22 degrees
							 8'b00100100: sine_out = 8'b11100001; // 50.62 degrees
							 8'b00100101: sine_out = 8'b11100011; // 52.03 degrees
							 8'b00100110: sine_out = 8'b11100101; // 53.44 degrees
							 8'b00100111: sine_out = 8'b11100110; // 54.84 degrees
							 8'b00101000: sine_out = 8'b11101000; // 56.25 degrees
							 8'b00101001: sine_out = 8'b11101010; // 57.66 degrees
							 8'b00101010: sine_out = 8'b11101011; // 59.06 degrees
							 8'b00101011: sine_out = 8'b11101101; // 60.47 degrees
							 8'b00101100: sine_out = 8'b11101111; // 61.88 degrees
							 8'b00101101: sine_out = 8'b11110000; // 63.28 degrees
							 8'b00101110: sine_out = 8'b11110001; // 64.69 degrees
							 8'b00101111: sine_out = 8'b11110011; // 66.09 degrees
							 8'b00110000: sine_out = 8'b11110100; // 67.50 degrees
							 8'b00110001: sine_out = 8'b11110101; // 68.91 degrees
							 8'b00110010: sine_out = 8'b11110110; // 70.31 degrees
							 8'b00110011: sine_out = 8'b11110111; // 71.72 degrees
							 8'b00110100: sine_out = 8'b11111000; // 73.12 degrees
							 8'b00110101: sine_out = 8'b11111001; // 74.53 degrees
							 8'b00110110: sine_out = 8'b11111010; // 75.94 degrees
							 8'b00110111: sine_out = 8'b11111010; // 77.34 degrees
							 8'b00111000: sine_out = 8'b11111011; // 78.75 degrees
							 8'b00111001: sine_out = 8'b11111100; // 80.16 degrees
							 8'b00111010: sine_out = 8'b11111100; // 81.56 degrees
							 8'b00111011: sine_out = 8'b11111101; // 82.97 degrees
							 8'b00111100: sine_out = 8'b11111101; // 84.38 degrees
							 8'b00111101: sine_out = 8'b11111101; // 85.78 degrees
							 8'b00111110: sine_out = 8'b11111101; // 87.19 degrees
							 8'b00111111: sine_out = 8'b11111101; // 88.59 degrees
							 8'b01000000: sine_out = 8'b11111110; // 90.00 degrees
							 8'b01000001: sine_out = 8'b11111101; // 91.41 degrees
							 8'b01000010: sine_out = 8'b11111101; // 92.81 degrees
							 8'b01000011: sine_out = 8'b11111101; // 94.22 degrees
							 8'b01000100: sine_out = 8'b11111101; // 95.62 degrees
							 8'b01000101: sine_out = 8'b11111101; // 97.03 degrees
							 8'b01000110: sine_out = 8'b11111100; // 98.44 degrees
							 8'b01000111: sine_out = 8'b11111100; // 99.84 degrees
							 8'b01001000: sine_out = 8'b11111011; // 101.25 degrees
							 8'b01001001: sine_out = 8'b11111010; // 102.66 degrees
							 8'b01001010: sine_out = 8'b11111010; // 104.06 degrees
							 8'b01001011: sine_out = 8'b11111001; // 105.47 degrees
							 8'b01001100: sine_out = 8'b11111000; // 106.88 degrees
							 8'b01001101: sine_out = 8'b11110111; // 108.28 degrees
							 8'b01001110: sine_out = 8'b11110110; // 109.69 degrees
							 8'b01001111: sine_out = 8'b11110101; // 111.09 degrees
							 8'b01010000: sine_out = 8'b11110100; // 112.50 degrees
							 8'b01010001: sine_out = 8'b11110011; // 113.91 degrees
							 8'b01010010: sine_out = 8'b11110001; // 115.31 degrees
							 8'b01010011: sine_out = 8'b11110000; // 116.72 degrees
							 8'b01010100: sine_out = 8'b11101111; // 118.12 degrees
							 8'b01010101: sine_out = 8'b11101101; // 119.53 degrees
							 8'b01010110: sine_out = 8'b11101011; // 120.94 degrees
							 8'b01010111: sine_out = 8'b11101010; // 122.34 degrees
							 8'b01011000: sine_out = 8'b11101000; // 123.75 degrees
							 8'b01011001: sine_out = 8'b11100110; // 125.16 degrees
							 8'b01011010: sine_out = 8'b11100101; // 126.56 degrees
							 8'b01011011: sine_out = 8'b11100011; // 127.97 degrees
							 8'b01011100: sine_out = 8'b11100001; // 129.38 degrees
							 8'b01011101: sine_out = 8'b11011111; // 130.78 degrees
							 8'b01011110: sine_out = 8'b11011101; // 132.19 degrees
							 8'b01011111: sine_out = 8'b11011010; // 133.59 degrees
							 8'b01100000: sine_out = 8'b11011000; // 135.00 degrees
							 8'b01100001: sine_out = 8'b11010110; // 136.41 degrees
							 8'b01100010: sine_out = 8'b11010100; // 137.81 degrees
							 8'b01100011: sine_out = 8'b11010001; // 139.22 degrees
							 8'b01100100: sine_out = 8'b11001111; // 140.62 degrees
							 8'b01100101: sine_out = 8'b11001101; // 142.03 degrees
							 8'b01100110: sine_out = 8'b11001010; // 143.44 degrees
							 8'b01100111: sine_out = 8'b11001000; // 144.84 degrees
							 8'b01101000: sine_out = 8'b11000101; // 146.25 degrees
							 8'b01101001: sine_out = 8'b11000010; // 147.66 degrees
							 8'b01101010: sine_out = 8'b11000000; // 149.06 degrees
							 8'b01101011: sine_out = 8'b10111101; // 150.47 degrees
							 8'b01101100: sine_out = 8'b10111010; // 151.88 degrees
							 8'b01101101: sine_out = 8'b10111000; // 153.28 degrees
							 8'b01101110: sine_out = 8'b10110101; // 154.69 degrees
							 8'b01101111: sine_out = 8'b10110010; // 156.09 degrees
							 8'b01110000: sine_out = 8'b10101111; // 157.50 degrees
							 8'b01110001: sine_out = 8'b10101100; // 158.91 degrees
							 8'b01110010: sine_out = 8'b10101001; // 160.31 degrees
							 8'b01110011: sine_out = 8'b10100110; // 161.72 degrees
							 8'b01110100: sine_out = 8'b10100011; // 163.12 degrees
							 8'b01110101: sine_out = 8'b10100000; // 164.53 degrees
							 8'b01110110: sine_out = 8'b10011101; // 165.94 degrees
							 8'b01110111: sine_out = 8'b10011010; // 167.34 degrees
							 8'b01111000: sine_out = 8'b10010111; // 168.75 degrees
							 8'b01111001: sine_out = 8'b10010100; // 170.16 degrees
							 8'b01111010: sine_out = 8'b10010001; // 171.56 degrees
							 8'b01111011: sine_out = 8'b10001110; // 172.97 degrees
							 8'b01111100: sine_out = 8'b10001011; // 174.38 degrees
							 8'b01111101: sine_out = 8'b10001000; // 175.78 degrees
							 8'b01111110: sine_out = 8'b10000101; // 177.19 degrees
							 8'b01111111: sine_out = 8'b10000010; // 178.59 degrees
							 8'b10000000: sine_out = 8'b01111111; // 180.00 degrees
							 8'b10000001: sine_out = 8'b01111011; // 181.41 degrees
							 8'b10000010: sine_out = 8'b01111000; // 182.81 degrees
							 8'b10000011: sine_out = 8'b01110101; // 184.22 degrees
							 8'b10000100: sine_out = 8'b01110010; // 185.62 degrees
							 8'b10000101: sine_out = 8'b01101111; // 187.03 degrees
							 8'b10000110: sine_out = 8'b01101100; // 188.44 degrees
							 8'b10000111: sine_out = 8'b01101001; // 189.84 degrees
							 8'b10001000: sine_out = 8'b01100110; // 191.25 degrees
							 8'b10001001: sine_out = 8'b01100011; // 192.66 degrees
							 8'b10001010: sine_out = 8'b01100000; // 194.06 degrees
							 8'b10001011: sine_out = 8'b01011101; // 195.47 degrees
							 8'b10001100: sine_out = 8'b01011010; // 196.88 degrees
							 8'b10001101: sine_out = 8'b01010111; // 198.28 degrees
							 8'b10001110: sine_out = 8'b01010100; // 199.69 degrees
							 8'b10001111: sine_out = 8'b01010001; // 201.09 degrees
							 8'b10010000: sine_out = 8'b01001110; // 202.50 degrees
							 8'b10010001: sine_out = 8'b01001011; // 203.91 degrees
							 8'b10010010: sine_out = 8'b01001000; // 205.31 degrees
							 8'b10010011: sine_out = 8'b01000101; // 206.72 degrees
							 8'b10010100: sine_out = 8'b01000011; // 208.12 degrees
							 8'b10010101: sine_out = 8'b01000000; // 209.53 degrees
							 8'b10010110: sine_out = 8'b00111101; // 210.94 degrees
							 8'b10010111: sine_out = 8'b00111011; // 212.34 degrees
							 8'b10011000: sine_out = 8'b00111000; // 213.75 degrees
							 8'b10011001: sine_out = 8'b00110101; // 215.16 degrees
							 8'b10011010: sine_out = 8'b00110011; // 216.56 degrees
							 8'b10011011: sine_out = 8'b00110000; // 217.97 degrees
							 8'b10011100: sine_out = 8'b00101110; // 219.38 degrees
							 8'b10011101: sine_out = 8'b00101100; // 220.78 degrees
							 8'b10011110: sine_out = 8'b00101001; // 222.19 degrees
							 8'b10011111: sine_out = 8'b00100111; // 223.59 degrees
							 8'b10100000: sine_out = 8'b00100101; // 225.00 degrees
							 8'b10100001: sine_out = 8'b00100011; // 226.41 degrees
							 8'b10100010: sine_out = 8'b00100000; // 227.81 degrees
							 8'b10100011: sine_out = 8'b00011110; // 229.22 degrees
							 8'b10100100: sine_out = 8'b00011100; // 230.62 degrees
							 8'b10100101: sine_out = 8'b00011010; // 232.03 degrees
							 8'b10100110: sine_out = 8'b00011000; // 233.44 degrees
							 8'b10100111: sine_out = 8'b00010111; // 234.84 degrees
							 8'b10101000: sine_out = 8'b00010101; // 236.25 degrees
							 8'b10101001: sine_out = 8'b00010011; // 237.66 degrees
							 8'b10101010: sine_out = 8'b00010010; // 239.06 degrees
							 8'b10101011: sine_out = 8'b00010000; // 240.47 degrees
							 8'b10101100: sine_out = 8'b00001110; // 241.88 degrees
							 8'b10101101: sine_out = 8'b00001101; // 243.28 degrees
							 8'b10101110: sine_out = 8'b00001100; // 244.69 degrees
							 8'b10101111: sine_out = 8'b00001010; // 246.09 degrees
							 8'b10110000: sine_out = 8'b00001001; // 247.50 degrees
							 8'b10110001: sine_out = 8'b00001000; // 248.91 degrees
							 8'b10110010: sine_out = 8'b00000111; // 250.31 degrees
							 8'b10110011: sine_out = 8'b00000110; // 251.72 degrees
							 8'b10110100: sine_out = 8'b00000101; // 253.12 degrees
							 8'b10110101: sine_out = 8'b00000100; // 254.53 degrees
							 8'b10110110: sine_out = 8'b00000011; // 255.94 degrees
							 8'b10110111: sine_out = 8'b00000011; // 257.34 degrees
							 8'b10111000: sine_out = 8'b00000010; // 258.75 degrees
							 8'b10111001: sine_out = 8'b00000001; // 260.16 degrees
							 8'b10111010: sine_out = 8'b00000001; // 261.56 degrees
							 8'b10111011: sine_out = 8'b00000000; // 262.97 degrees
							 8'b10111100: sine_out = 8'b00000000; // 264.38 degrees
							 8'b10111101: sine_out = 8'b00000000; // 265.78 degrees
							 8'b10111110: sine_out = 8'b00000000; // 267.19 degrees
							 8'b10111111: sine_out = 8'b00000000; // 268.59 degrees
							 8'b11000000: sine_out = 8'b00000000; // 270.00 degrees
							 8'b11000001: sine_out = 8'b00000000; // 271.41 degrees
							 8'b11000010: sine_out = 8'b00000000; // 272.81 degrees
							 8'b11000011: sine_out = 8'b00000000; // 274.22 degrees
							 8'b11000100: sine_out = 8'b00000000; // 275.62 degrees
							 8'b11000101: sine_out = 8'b00000000; // 277.03 degrees
							 8'b11000110: sine_out = 8'b00000001; // 278.44 degrees
							 8'b11000111: sine_out = 8'b00000001; // 279.84 degrees
							 8'b11001000: sine_out = 8'b00000010; // 281.25 degrees
							 8'b11001001: sine_out = 8'b00000011; // 282.66 degrees
							 8'b11001010: sine_out = 8'b00000011; // 284.06 degrees
							 8'b11001011: sine_out = 8'b00000100; // 285.47 degrees
							 8'b11001100: sine_out = 8'b00000101; // 286.88 degrees
							 8'b11001101: sine_out = 8'b00000110; // 288.28 degrees
							 8'b11001110: sine_out = 8'b00000111; // 289.69 degrees
							 8'b11001111: sine_out = 8'b00001000; // 291.09 degrees
							 8'b11010000: sine_out = 8'b00001001; // 292.50 degrees
							 8'b11010001: sine_out = 8'b00001010; // 293.91 degrees
							 8'b11010010: sine_out = 8'b00001100; // 295.31 degrees
							 8'b11010011: sine_out = 8'b00001101; // 296.72 degrees
							 8'b11010100: sine_out = 8'b00001110; // 298.12 degrees
							 8'b11010101: sine_out = 8'b00010000; // 299.53 degrees
							 8'b11010110: sine_out = 8'b00010010; // 300.94 degrees
							 8'b11010111: sine_out = 8'b00010011; // 302.34 degrees
							 8'b11011000: sine_out = 8'b00010101; // 303.75 degrees
							 8'b11011001: sine_out = 8'b00010111; // 305.16 degrees
							 8'b11011010: sine_out = 8'b00011000; // 306.56 degrees
							 8'b11011011: sine_out = 8'b00011010; // 307.97 degrees
							 8'b11011100: sine_out = 8'b00011100; // 309.38 degrees
							 8'b11011101: sine_out = 8'b00011110; // 310.78 degrees
							 8'b11011110: sine_out = 8'b00100000; // 312.19 degrees
							 8'b11011111: sine_out = 8'b00100011; // 313.59 degrees
							 8'b11100000: sine_out = 8'b00100101; // 315.00 degrees
							 8'b11100001: sine_out = 8'b00100111; // 316.41 degrees
							 8'b11100010: sine_out = 8'b00101001; // 317.81 degrees
							 8'b11100011: sine_out = 8'b00101100; // 319.22 degrees
							 8'b11100100: sine_out = 8'b00101110; // 320.62 degrees
							 8'b11100101: sine_out = 8'b00110000; // 322.03 degrees
							 8'b11100110: sine_out = 8'b00110011; // 323.44 degrees
							 8'b11100111: sine_out = 8'b00110101; // 324.84 degrees
							 8'b11101000: sine_out = 8'b00111000; // 326.25 degrees
							 8'b11101001: sine_out = 8'b00111011; // 327.66 degrees
							 8'b11101010: sine_out = 8'b00111101; // 329.06 degrees
							 8'b11101011: sine_out = 8'b01000000; // 330.47 degrees
							 8'b11101100: sine_out = 8'b01000011; // 331.88 degrees
							 8'b11101101: sine_out = 8'b01000101; // 333.28 degrees
							 8'b11101110: sine_out = 8'b01001000; // 334.69 degrees
							 8'b11101111: sine_out = 8'b01001011; // 336.09 degrees
							 8'b11110000: sine_out = 8'b01001110; // 337.50 degrees
							 8'b11110001: sine_out = 8'b01010001; // 338.91 degrees
							 8'b11110010: sine_out = 8'b01010100; // 340.31 degrees
							 8'b11110011: sine_out = 8'b01010111; // 341.72 degrees
							 8'b11110100: sine_out = 8'b01011010; // 343.12 degrees
							 8'b11110101: sine_out = 8'b01011101; // 344.53 degrees
							 8'b11110110: sine_out = 8'b01100000; // 345.94 degrees
							 8'b11110111: sine_out = 8'b01100011; // 347.34 degrees
							 8'b11111000: sine_out = 8'b01100110; // 348.75 degrees
							 8'b11111001: sine_out = 8'b01101001; // 350.16 degrees
							 8'b11111010: sine_out = 8'b01101100; // 351.56 degrees
							 8'b11111011: sine_out = 8'b01101111; // 352.97 degrees
							 8'b11111100: sine_out = 8'b01110010; // 354.38 degrees
							 8'b11111101: sine_out = 8'b01110101; // 355.78 degrees
							 8'b11111110: sine_out = 8'b01111000; // 357.19 degrees
							 8'b11111111: sine_out = 8'b01111011; // 358.59 degrees
            default: sine_out = 8'b01111111; // Значение по умолчанию
        endcase
    end
endmodule


module phase_accumulator (
    input wire clk,
    input wire reset,
    input wire [7:0] fcw, // Контрольное слово частоты, 8 разрядность для гибкой настройки шага фазы
    output reg [7:0] phase
);
    always @(posedge clk or posedge reset)//Асинхронный сброс 
	 begin
        if (reset)
            phase <= 8'b0;
        else
            phase <= phase + fcw; // Увеличиваем фазу на FCW
    end
endmodule
