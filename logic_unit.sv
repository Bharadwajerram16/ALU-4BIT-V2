`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: E.Bharadwaj
// Create Date: 03.04.2026 19:25:03 
// Module Name: logic_unit
//////////////////////////////////////////////////////////////////////////////////

module logic_unit(r,s,a,b);
input [3:0]a;
input [3:0]b;
input [2:0]s;
output reg [3:0]r;
always@(*)
begin
case(s)
3'b000:r=a&b;
3'b001:r=a|b;
3'b010:r=a^b;
3'b011:r=~a;
3'b100:r=~(a&b);
3'b101:r=~(a|b);
3'b110:r=~(a^b);
default:r=4'b0000;
endcase
end
endmodule
