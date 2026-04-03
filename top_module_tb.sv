`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: E.Bharadwaj
// Create Date: 03.04.2026 19:25:03 
// Module Name: top_module_tb
//////////////////////////////////////////////////////////////////////////////////

module top_module_tb();
reg clk;
reg rst;
reg [3:0]a;
reg [3:0]b;
reg [2:0]op;
reg [1:0]sel_shift;
reg [1:0]mode_shift;
wire [7:0]result;
wire Z,C,S,V;
wire done;
top_module x1(clk,rst,a,b,op,sel_shift,mode_shift,result,Z,C,S,V,done);
always #5 clk=~clk;
initial
begin
clk=0;
rst=1;
#10 rst=0;
#10 op=3'b000;a=4'b1010;b=4'b0101;
#10 op=3'b001;a=4'b1100;b=4'b1010;
#10 op=3'b010;a=4'b1011;sel_shift=2'b01;mode_shift=2'b00;
#10 op=3'b010;a=4'b1011;sel_shift=2'b01;mode_shift=2'b01;
#10 op=3'b010;a=4'b1011;sel_shift=2'b01;mode_shift=2'b10;
#10 op=3'b011;a=4'b1010;b=4'b0011;
#10 op=3'b100;a=4'd10;b=4'd3;
wait(done);
#10 op=3'b101;a=4'd15;b=4'd4;
wait(done);
#10 $stop;
end
endmodule
