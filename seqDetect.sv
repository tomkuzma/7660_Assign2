// seqDetect.sv
// Shift register that detects if N bits match an N bit sequence
// Tom Kuzma
// Feb 11, 2022

module seqDetect #(parameter N=6)
    (output logic valid,
    input logic a, 
    input logic [N-1:0] seq,
    input logic clk, reset_n);

    logic [N-1:0] buffer, nextBuff; // buffer to hold last N a bits
    logic [$clog2(N)-1:0] count, nextCount; // calculate number of bits needed for counter

    // FF logic for reset, count and buffer
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            count <= '0;
            buffer <= '0;
        end
        else begin
            buffer <= nextBuff;
            count <= nextCount;
        end 
    end

    // comb logic for loading buffer and validating sequence
    always_comb begin
        nextBuff = {buffer[N-2:0],a}; // shift in a on pos clk

        if (count == N) begin // wait for N bits to be input after reset
            // check sequence
            if (buffer == seq)
                valid = 1'b1;
            else
                valid = 1'b0;
            nextCount = count; // hold count if at N
        end
        else begin // load buffer and count up
            nextCount = count + 1'b1;
            valid = 1'b0;
        end
    end

endmodule