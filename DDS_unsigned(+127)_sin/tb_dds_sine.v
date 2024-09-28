`timescale 1ns / 1ps

module tb_dds_sine;

    // Параметры
    reg clk;
    reg reset;
    reg [7:0] fcw; // Контрольное слово частоты
    wire signed [7:0] audio_out; // Выход синусоиды

    // Инстанцирование модуля DDS
    dds_sine uut (
        .clk(clk),
        .reset(reset),
        .fcw(fcw),
        .audio_out(audio_out)
    );

    // Генерация тактового сигнала
    initial begin
        clk = 0;
        forever #0.1 clk = ~clk; // Тактовая частота 100 МГц (10 нс период)
    end

    // Начальные условия и тестирование
    initial begin
        // Инициализация сигналов
        reset = 1;
        fcw = 8'b01; // Пример значения для контрольного слова частоты

        // Сброс системы
        #10;
        reset = 0;

        // Запуск симуляции на 1 мс
        #10000;

        // Завершение симуляции
        $finish;
    end

    // Отображение выходных значений
    initial begin
        $monitor("Time: %t | Sine Output: %d", $time, audio_out);
    end

endmodule
