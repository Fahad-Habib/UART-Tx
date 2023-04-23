module BaudCounter(input logic clk, reset,
                   output logic counter_baud_of);
    logic [15:0] counter;
    always_ff @(posedge clk) begin
        if (counter >= (10417 - 2)) begin
            counter_baud_of <= 1;
            counter <= 0;
        end else begin
            counter_baud_of <= 0;
        end
        if (reset) begin
            counter_baud_of <= 0;
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end
endmodule