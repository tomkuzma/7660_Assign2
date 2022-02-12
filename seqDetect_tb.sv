// seqDetect_tb.sv
// testbench for seqDetect.sv
// Tom Kuzma
// Feb 11, 2022

module seqDetect_tb();

parameter N = 3;
logic valid;
logic a;
logic [N-1:0] seq;
logic clk, reset_n;

seqDetect #(.N(3)) dut_0(.*);

initial begin
    clk = 0;
    a = 0;
    seq = 3'b000; // test 000 as sequence

    // load in new data on negedge since a is asserted on posedge of dut
    reset_n = 0; // hold reset for 4 clocks
    repeat(3) @(negedge clk);
    reset_n = 1;

    repeat(3) @(negedge clk); // load in 3 0's to test for assertion after N clks after reset
    a = 1;
    repeat(3) @(negedge clk); // load in 3 1's
    a = 0;
    repeat(3) @(negedge clk); // load in 3 0's again
    

    @(posedge clk);seq = 3'b010; // test 010 sequence
    repeat(9) @(negedge clk) a = ~a; // toggle a for 9 clocks

    $stop;
end


// generate clock
always
	#1us clk = ~clk;

endmodule
