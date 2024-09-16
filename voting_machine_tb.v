
`timescale 1ns / 1ps
module votingmachine_tb;

  reg clk;
  reg reset;
  reg mode; 
  reg button1, button2, button3, button4;
  wire [7:0] led;
  
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
  always #5 clk = ~clk; 
  initial begin
 
    clk = 0;
    reset = 1;
    mode = 0;
    button1 = 0;
    button2 = 0;
    button3 = 0;
    button4 = 0;
#100
    $dumpfile("votingmachine_tb.vcd"); 
    $dumpvars(0, votingmachine_tb); 
  
    #10 reset = 0;

    #10 button1 = 1; 
    #20 button1 = 0;
    #10 button2 = 1;
    #20 button2 = 0;
    #10 button3 = 1;
    #20 button3 = 0;
    #10 button4 = 1;
    #20 button4 = 0;

    #10 mode = 1; 
    #10 button1 = 1; 
    #10 button1 = 0;
    #10 button2 = 1; 
    #10 button2 = 0;
    #10 button3 = 1;
    #10 button3 = 0;
    #10 button4 = 1; 
    #10 button4 = 0;


    #10 mode = 0; 
    #10 button1 = 1; 
    #20 button1 = 0;
    #10 button4 = 1;
    #20 button4 = 0;

  
    #100 $finish;
  end
  initial begin
    $monitor("Time = %0t | Reset = %b | Mode = %b | Buttons: [%b %b %b %b] | LED = %h", 
             $time, reset, mode, button1, button2, button3, button4, led);
  end
endmodule
