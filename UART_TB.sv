`timescale 1ns / 1ps

module UART_TB;
	logic clk, reset, byte_ready, t_byte, Tx;
    logic [7:0] data;
	UART_Tx UUT (data, clk, byte_ready, t_byte, reset, Tx);
    initial
        begin
            clk = 0;
            forever #1 clk = ~clk;
        end
	initial
		begin
            reset = 1; byte_ready = 0; t_byte = 0; data = 8'b01000101;
            #10417;
            reset = 1; byte_ready = 1;
            #10417;
            reset = 0; t_byte = 1;
            #2;
            t_byte = 0;
            #312510;
            $stop;
		end
endmodule
