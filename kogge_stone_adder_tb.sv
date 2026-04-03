`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author :E.Bharadwaj
// Create Date: 03.04.2026 14:02:05
// Module Name: kogge_stone_adder_tb
//////////////////////////////////////////////////////////////////////////////////

module kogge_stone_adder_tb();
reg [3:0]a,b;
reg cin;
wire [3:0]s;
wire cout;
wire [4:0]sum;
assign sum={cout,s};
kogge_stone_adder x1(s,cout,a,b,cin);
initial
begin
a=4'b0011;b=4'b0101;cin=1'b0;
#10 a=4'b1010;b=4'b0011;cin=1'b0;
#10 a=4'b1111;b=4'b0001;cin=1'b0;
#10 a=4'b0111;b=4'b0111;cin=1'b0;
#10 a=4'b1100;b=4'b0011;cin=1'b0;
#10 a=4'b1010;b=4'b0101;cin=1'b0;
#10 a=4'b0001;b=4'b0001;cin=1'b0;
#10 a=4'b1111;b=4'b1111;cin=1'b0;
#10 a=4'b1010;b=4'b0011;cin=1'b1;
#10 a=4'b1111;b=4'b0001;cin=1'b1;
#10 a=4'b1100;b=4'b0101;cin=1'b1;
#10 a=4'b0111;b=4'b0011;cin=1'b1;
#10 a=4'b1000;b=4'b0011;cin=1'b1;
#10 a=4'b1111;b=4'b1111;cin=1'b1;
#10 a=4'b0101;b=4'b0101;cin=1'b1;
#10 a=4'b1010;b=4'b1010;cin=1'b1;
#10 $stop;
end
endmodule