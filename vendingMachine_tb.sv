// vendingMachine_tb.sv
// testbench for vendingMachine module
// Tom Kuzma
// Feb 11, 2022

module vendingMachine_tb();

    logic valid;
    logic nickel, dime, quarter;
    logic clk = 1, reset_n;

    vendingMachine dut_0(.*);

    initial begin

        quarter = 0;
        dime = 0;
        nickel = 0;

        // test reset
        reset_n = 0;
        repeat(2) @(negedge clk);
        reset_n = 1;

        // do 4 quarters
        repeat(8) @(negedge clk) quarter = ~quarter;
        quarter = 0;

        // do 10 dimes
        repeat(20) @(negedge clk) dime = ~dime;
        dime = 0;

        // do 20 nickels
        repeat(40) @(negedge clk) nickel = ~nickel;
        nickel = 0;

        // do 7 of nickel+dime
        repeat(14) @(negedge clk) begin
            nickel = ~nickel;
            dime = ~dime;
        end
        dime = 0;

        // do 4 of quarter and nickel
        repeat(8) @(negedge clk) begin
            nickel = ~nickel;
            quarter = ~quarter;
        end
        nickel = 0;
        quarter = 0;

        // do 3 of quarter and dime
        repeat(6) @(negedge clk) begin
            dime = ~dime;
            quarter = ~quarter;
        end
        dime = 0;
        quarter = 0;

        // do 3 of all 3
        repeat(6) @(negedge clk) begin
            dime = ~dime;
            quarter = ~quarter;
            nickel = ~nickel;
        end
        dime = 0;
        quarter = 0;
        nickel = 0;

        repeat(1) @(negedge clk);

        $stop;
    end

    // generate clock
    always
        #1us clk = ~clk;

endmodule