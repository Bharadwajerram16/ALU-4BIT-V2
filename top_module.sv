`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: E.Bharadwaj
// Create Date: 03.04.2026 19:25:03 
// Module Name: top_module
//////////////////////////////////////////////////////////////////////////////////

module top_module(
input clk,
input rst,
input [3:0]a,
input [3:0]b,
input [2:0]op,
input [1:0]sel_shift,
input [1:0]mode_shift,
output reg [7:0]result,
output Z,C,S,V,
output reg done
);
wire [3:0]logic_out;
wire [3:0]shift_out;
wire [3:0]sum;
wire cout;
wire [7:0]mul_out;
wire [3:0]div_q,div_r;
wire div_done;
reg cin_msb;
kogge_stone_adder ksa(sum,cout,a,b,1'b0);
logic_unit lu1(logic_out,op,a,b);
barrel_shifter sh1(shift_out,a,sel_shift,mode_shift);
wallace_multipler mul1(mul_out,a,b);
non_restoring_divider div1(clk,rst,a,b,div_q,div_r,div_done);
always@(*)
begin
case(op)
3'b000:result={4'b0000,sum};
3'b001:result={4'b0000,logic_out};
3'b010:result={4'b0000,shift_out};
3'b011:result=mul_out;
3'b100:result={4'b0000,div_q};
3'b101:result={4'b0000,div_r};
default:result=8'b00000000;
endcase
end
always@(*)begin
case(op)
3'b100:done=div_done;
3'b101:done=div_done;
default:done=1'b1;
endcase
end
always@(*)begin
case({a[3],b[3],sum[3]})
3'b110:cin_msb=1'b1;
3'b101:cin_msb=1'b1;
3'b011:cin_msb=1'b1;
default:cin_msb=1'b0;
endcase
end
flag_generator fg1(result[3:0],cout,cin_msb,Z,C,S,V);
endmodule