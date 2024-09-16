`timescale 1ns / 1ps
module votelogger(input clk, input reset, input mode, input cand1_vote_valid, input cand2_vote_valid, input cand3_vote_valid, input cand4_vote_valid, output reg [7:0] cand1_vote_recvd, output reg [7:0] cand2_vote_recvd, output reg [7:0] cand3_vote_recvd, output reg [7:0] cand4_vote_recvd);
  always @(posedge clk) begin
    if (reset) begin
      cand1_vote_recvd <= 0;
      cand2_vote_recvd <= 0;
      cand3_vote_recvd <= 0;
      cand4_vote_recvd <= 0;
    end else begin
      if (cand1_vote_valid & mode == 0)
        cand1_vote_recvd <= cand1_vote_recvd + 1;  
      if (cand2_vote_valid & mode == 0)
        cand2_vote_recvd <= cand2_vote_recvd + 1;  
      if (cand3_vote_valid & mode == 0)
        cand3_vote_recvd <= cand3_vote_recvd + 1;  
      if (cand4_vote_valid & mode == 0)
        cand4_vote_recvd <= cand4_vote_recvd + 1;  
    end
  end
endmodule
