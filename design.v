`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/16/2024 03:14:35 PM
// Design Name: 
// Module Name: design
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// Code your design here
// Code your design here
module buttoncontrol(input clk,input reset,input button, output reg valid_vote);
  reg[30:0]counter;
  always@(posedge clk)
    begin
      if(reset)
        counter<=0;
      else
        begin 
          if(button & counter<11)
            counter<=counter+1;
          else if(button)
            counter<=0;
        end
    end
  always @(posedge clk)
    begin
      if(reset)
        valid_vote <=1'b0;
      else 
        begin
          if(counter ==10)
            valid_vote <=1'b1;
          else
            valid_vote <=1'b0;
        end
    end
endmodule

module votelogger(input clk, input reset, input mode, input cand1_vote_valid, input cand2_vote_valid, input cand3_vote_valid, input cand4_vote_valid, output reg [7:0] cand1_vote_recvd, output reg [7:0] cand2_vote_recvd, output reg [7:0] cand3_vote_recvd, output reg [7:0] cand4_vote_recvd);
  always @(posedge clk) begin
    if (reset) begin
      cand1_vote_recvd <= 0;
      cand2_vote_recvd <= 0;
      cand3_vote_recvd <= 0;
      cand4_vote_recvd <= 0;
    end else begin
      if (cand1_vote_valid & mode == 0)
        cand1_vote_recvd <= cand1_vote_recvd + 1;  // Update internal register
      if (cand2_vote_valid & mode == 0)
        cand2_vote_recvd <= cand2_vote_recvd + 1;  
      if (cand3_vote_valid & mode == 0)
        cand3_vote_recvd <= cand3_vote_recvd + 1;  
      if (cand4_vote_valid & mode == 0)
        cand4_vote_recvd <= cand4_vote_recvd + 1;  
    end
  end
endmodule

module modecontrol(input clk, input reset, input mode, input valid_vote_casted,input [7:0]cand1_vote,input [7:0]cand2_vote,input [7:0]cand3_vote,input [7:0]cand4_vote,input cand1_button_press,input cand2_button_press,input cand3_button_press,input cand4_button_press,output reg [7:0]leds);
   reg[30:0]counter;
  always @(posedge clk)
    begin
      if(reset)
        counter<=0;
      else if(valid_vote_casted)
        counter<=counter+1;
      else if(counter!=0 &counter<=10)
        counter<=counter+1;
      else 
        counter<=0;
    end
  always@(posedge clk)
    begin
      if(reset)
        counter<=0;
      else
        begin
          if(mode==0 & counter>0)
            leds<=8'hFF;
          else if(mode==0)
            leds<=8'h00;
          else if(mode==1)
            begin
              if(cand1_button_press)
                leds<=cand1_vote;
              else if(cand2_button_press)
                leds<=cand2_vote;
              else if(cand3_button_press)
                leds<=cand3_vote;
              else if(cand4_button_press)
                leds<=cand4_vote;
            end
        end
    end
endmodule

module votingmachine(input clk,input reset,input mode,input button1,input button2,input button3,input button4,output[7:0]led);
  wire valid_vote1;
   wire valid_vote2;
   wire valid_vote3;
   wire valid_vote4;
  wire [7:0]cand1_vote_recvd;
  wire [7:0]cand2_vote_recvd;
  wire [7:0]cand3_vote_recvd;
  wire [7:0]cand4_vote_recvd;
  wire anyvalidvote;
  assign anyvalidvote=valid_vote1|valid_vote2|valid_vote3|valid_vote4;
  
  buttoncontrol bc1(.clk(clk),.reset(reset),.button(button1),.valid_vote(valid_vote1));
  buttoncontrol  bc2(.clk(clk),.reset(reset),.button(button2),.valid_vote(valid_vote2));
  buttoncontrol bc3(.clk(clk),.reset(reset),.button(button3),.valid_vote(valid_vote3));
  buttoncontrol bc4(.clk(clk),.reset(reset),.button(button4),.valid_vote(valid_vote4));
  
votelogger vl(
  .clk(clk),
  .reset(reset),
  .mode(mode),
  .cand1_vote_valid(valid_vote1),  
  .cand2_vote_valid(valid_vote2),  
  .cand3_vote_valid(valid_vote3), 
  .cand4_vote_valid(valid_vote4),  
  .cand1_vote_recvd(cand1_vote_recvd),
  .cand2_vote_recvd(cand2_vote_recvd),
  .cand3_vote_recvd(cand3_vote_recvd),
  .cand4_vote_recvd(cand4_vote_recvd)
);

  
  modecontrol mc(.clk(clk),.reset(reset),.mode(mode),.valid_vote_casted(anyvalidvote),.cand1_vote(cand1_vote_recvd),.cand2_vote(cand2_vote_recvd),.cand3_vote(cand3_vote_recvd),.cand4_vote(cand4_vote_recvd),.cand1_button_press(valid_vote1),.cand2_button_press(valid_vote2),.cand3_button_press(valid_vote3),.cand4_button_press(valid_vote4),.leds(led));
  
endmodule
  
  
  
  
                
