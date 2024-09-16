`timescale 1ns / 1ps
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
