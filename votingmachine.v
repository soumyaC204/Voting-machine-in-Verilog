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
  
  
  
