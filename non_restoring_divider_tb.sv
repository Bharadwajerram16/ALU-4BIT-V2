`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: E.Bharadwaj
// Create Date: 03.04.2026 12:23:52
// Module Name: non_restoring_divider_tb
//////////////////////////////////////////////////////////////////////////////////


module non_restoring_divider_tb();
reg clk,rst;
reg signed [3:0]dividend,divisor;
wire signed [3:0]q,rem;
wire d;
non_restoring_divider x1(clk,rst,dividend,divisor,q,rem,d);
always #5 clk=~clk;
initial
begin
clk=0;rst=1;dividend=4'd7;divisor=4'd2;
#10 rst=0;
#50 rst=1;dividend=4'd9;divisor=4'd3;
#10 rst=0;
#50 rst=1;dividend=4'd6;divisor=4'd2;
#10 rst=0;
#50 rst=1;dividend=4'd7;divisor=4'd3;
#10 rst=0;
#50 rst=1;dividend=4'sd6;divisor=4'sd2;
#10 rst=0;
#50 rst=1;dividend=-4'd6;divisor=4'd2;
#10 rst=0;
#50 rst=1;dividend=4'd4;divisor=4'd3;
#10 rst=0;
#50 rst=1;dividend=4'd1;divisor=4'd1;
#10 rst=0;
#50 $stop;
end
endmodule
