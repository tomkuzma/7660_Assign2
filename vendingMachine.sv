// vendingMachine.sv
// sums "coins" input into machine and validates once $1 is reached
// Tom Kuzma
// Feb 11, 2022

module vendingMachine (
    output logic valid,
    input logic nickel, dime, quarter,
    input logic clk, reset_n
    );

    logic [5:0] tally; // coin count. max val = 25 + 10 + 5 = 40, so only need 6 bits.
    logic [7:0] sum; // rolling sum max val = 95 + 40 = 135 so only need 8 bits. 


    // read stable coin inputs on pos clk edge
    always_ff @(posedge clk, negedge reset_n) begin
        if (!reset_n) begin
            sum <= '0;
        end
        // rolling total of coins if less than a dollar
        else if (sum < 100) begin
            sum <= sum + tally;
        end
        // reset total and resume counting coins
        else 
            sum <= tally;
    end

    // validate coin total if > 100
    always_comb begin
        tally = (quarter*25) + (dime*10) + (nickel*5);

        if (sum >= 100)
            valid = 1'b1;
        else
            valid = 1'b0;
    end

endmodule