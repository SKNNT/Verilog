module main(output [1:0]y, input [2:0]A,input [15:0]x);
	

	MUX #(.N(3),.B(2)) MX(.y(y),.A(A),.x(x));

endmodule 


module MUX #(parameter N, B)(output [B-1:0]y, input [N-1:0]A,input [(2**N)*B-1:0]x);

	wire [(2**N)*B-1:0]temp = x >> A*B;
	assign y = temp[B-1:0];
	
endmodule 