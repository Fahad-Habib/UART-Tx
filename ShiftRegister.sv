module ShiftRegister(input logic [7:0] data, input logic clk, load_byte, shift, reset,
                     output logic serial_out);
    integer counter = 0;
    logic [7:0] temp;

    always_ff @(posedge clk) begin
        if (load_byte) begin
            counter <= 1;
            temp <= data;
        end if (reset) begin
            serial_out <= 1'b0;
            temp <= data;
            counter <= 1;
        end else if (shift) begin
            serial_out <= temp[0];
            counter <= counter + 1;
            temp <= data >> counter;
        end
    end
endmodule