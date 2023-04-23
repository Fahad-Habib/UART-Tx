`timescale 1ns / 1ps

module UART_Tx(input logic [7:0] data, input logic clk, byte_ready, t_byte, reset,
               output logic Tx);
    logic serial_out;
    logic clear_baud, clear, load_xmt_dreg, load_xmt_shftreg, start, shift, counter_baud_of, counter_of;

    ShiftRegister sr(data, clk, load_xmt_shftreg, shift, reset, serial_out);
    FSM fsm(clk, reset, byte_ready, counter_baud_of, counter_of, t_byte, 
            load_xmt_dreg, load_xmt_shftreg, start, clear, clear_baud, shift);
    BaudCounter bac(clk, clear_baud, counter_baud_of);
    BitCounter bic(clk, clear, shift, counter_of);
    MUX mux(start, serial_out, 1, Tx);
endmodule