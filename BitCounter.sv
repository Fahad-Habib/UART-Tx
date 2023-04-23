module BitCounter(input logic clk, reset, count,
                  output logic counter_of);
    logic [3:0] counter;
    always_ff @(posedge clk) begin
        if (counter >= 9) begin
            counter_of <= 1;
            counter <= 0;
        end else begin
            counter_of <= 0;
        end
        if (reset) begin
            counter_of <= 0; 
            counter <= 0;
        end else if (count) begin
            counter <= counter + 1;
        end
    end
endmodule