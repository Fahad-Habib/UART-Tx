`timescale 1ns / 1ps

module FSM(input logic clk, reset, byte_ready, counter_baud, counter, t_byte,
           output logic load_xmt_dreg, load_xmt_shftreg, start, clear, clear_baud, shift);

    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;
    logic [1:0] current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    always_comb begin
        case (current_state)
            S0: if (byte_ready) begin
                    clear <= 1;
                    clear_baud <= 1;
                    shift <= 0;
                    start <= 0;
                    load_xmt_dreg <= 0;
                    load_xmt_shftreg <= 0;
                    next_state <= S1;
                end else if (~byte_ready) begin
                    clear <= 1;
                    clear_baud <= 1;
                    load_xmt_dreg <= 1;
                    shift <= 0;
                    start <= 0;
                    load_xmt_shftreg <= 0;
                end
            S1: if (t_byte) begin
                    clear <= 1;
                    clear_baud <= 1;
                    shift <= 0;
                    start <= 0;
                    load_xmt_dreg <= 0;
                    load_xmt_shftreg <= 0;
                    next_state <= S2;
                end else if (~t_byte) begin
                    clear <= 1;
                    clear_baud <= 1;
                    load_xmt_shftreg <= 1;
                    shift <= 0;
                    start <= 0;
                    load_xmt_dreg <= 0;
                end
            S2: if (counter) begin
                    start <= 0;
                    shift <= 0;
                    clear <= 0;
                    clear_baud <= 0;
                    load_xmt_dreg <= 0;
                    load_xmt_shftreg <= 0;
                    next_state <= S0;
                end else if ((counter & ~counter_baud) | (~counter & ~counter_baud)) begin
                    start <= 1;
                    shift <= 0;
                    clear <= 0;
                    clear_baud <= 0;
                    load_xmt_dreg <= 0;
                    load_xmt_shftreg <= 0;
                end else if (~counter & counter_baud) begin
                    start <= 1;
                    shift <= 1;
                    clear_baud <= 1;
                    clear <= 0;
                    load_xmt_dreg <= 0;
                    load_xmt_shftreg <= 0;
                end
            default: next_state <= S0;
        endcase
    end

endmodule