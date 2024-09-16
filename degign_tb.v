// Code your testbench here
// or browse Examples
`timescale 1ns / 1ps
module votingmachine_tb;
  // Testbench signals
  reg clk;
  reg reset;
  reg mode; // Mode: 0 = Voting Mode, 1 = Display Mode
  reg button1, button2, button3, button4;
  wire [7:0] led;

  // Instantiate the voting machine
  votingmachine vm (
    .clk(clk),
    .reset(reset),
    .mode(mode),
    .button1(button1),
    .button2(button2),
    .button3(button3),
    .button4(button4),
    .led(led)
  );

  // Clock generation
  always #5 clk = ~clk; // 10 ns clock period

  // Stimulus process
  initial begin
    // Initialize signals
    clk = 0;
    reset = 1;
    mode = 0; // Start in voting mode
    button1 = 0;
    button2 = 0;
    button3 = 0;
    button4 = 0;
#100
    // Generate waveform file for debugging
    $dumpfile("votingmachine_tb.vcd"); // Create dumpfile
    $dumpvars(0, votingmachine_tb);     // Dump all variables in the testbench

    // Apply reset
    #10 reset = 0;

    // Simulate voting
    #10 button1 = 1; // Press button1 for candidate 1
    #20 button1 = 0;
    #10 button2 = 1; // Press button2 for candidate 2
    #20 button2 = 0;
    #10 button3 = 1; // Press button3 for candidate 3
    #20 button3 = 0;
    #10 button4 = 1; // Press button4 for candidate 4
    #20 button4 = 0;

    // Switch to display mode
    #10 mode = 1; // Display vote count for candidates

    // Simulate pressing candidate buttons in display mode
    #10 button1 = 1; // Display votes for candidate 1
    #10 button1 = 0;
    #10 button2 = 1; // Display votes for candidate 2
    #10 button2 = 0;
    #10 button3 = 1; // Display votes for candidate 3
    #10 button3 = 0;
    #10 button4 = 1; // Display votes for candidate 4
    #10 button4 = 0;

    // Back to voting mode
    #10 mode = 0;

    // Test a few more votes
    #10 button1 = 1; // Press button1 again
    #20 button1 = 0;
    #10 button4 = 1; // Press button4 again
    #20 button4 = 0;

    // End of simulation
    #100 $finish;
  end

  // Display signals for debug purposes
  initial begin
    $monitor("Time = %0t | Reset = %b | Mode = %b | Buttons: [%b %b %b %b] | LED = %h", 
             $time, reset, mode, button1, button2, button3, button4, led);
  end
endmodule
