module MUX(input logic start, A, B,
           output logic Tx);
    always_comb begin
        if (start) begin
            Tx = A;
        end else begin
            Tx = B;
        end
    end
endmodule