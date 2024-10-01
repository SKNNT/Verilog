module main (
    input wire clk,
    input wire nreset,
    input wire signed [11:0] x, 
    output reg signed [31:0] y 
);
parameter N = 15;
reg signed [15:0] coeffs [0:N-1];//поидее 8 разрядов хватит?
//массив коэффициентов:
initial begin
    coeffs[0] = 0;
    coeffs[1] = -2;
    coeffs[2] = 2;
    coeffs[3] = 18;
    coeffs[4] = -8;
    coeffs[5] = -62;
    coeffs[6] = 6;
    coeffs[7] = 90;
    coeffs[8] = 6;
    coeffs[9] = -62;
    coeffs[10] = -8;
    coeffs[11] = 18;
    coeffs[12] = 2;
    coeffs[13] = -2;
    coeffs[14] = 0;
end

integer i;
reg signed [31:0] delay_line [0:N-1]; // линия задержки
initial begin//хоть массив по дефолту заполнен нулями, обьявим это явно(т.е. это необязательно)
    for (i = 0; i < N; i = i + 1) begin
        delay_line[i] = 0;
    end
end

always @(posedge clk or negedge nreset) begin
////////////////////////////////////////////////просто сброс 
    if (!nreset) begin
        for (i = 0; i < N; i = i + 1) begin
            delay_line[i] <= 0;
        end
        y <= 0;
////////////////////////////////////////////////  главная логика 
    end else begin
        for (i = N-1; i > 0; i = i - 1) begin
            delay_line[i] <= delay_line[i-1];//элемент с индексом 0 переходит на индекс 1 и так далее:{1,2,3,0}->{0,1,2,3}
        end
        delay_line[0] <= x; // Запись нового значения:{x,1,2,3}
        y <= 0;
        for (i = 0; i < N; i = i + 1) begin
            y <= y + (delay_line[i] * coeffs[i]); // Суммирование произведений
        end
    end
end
endmodule