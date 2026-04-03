`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author :E.Bharadwaj
// Create Date: 03.04.2026 14:02:05
// Module Name: kogge_stone_adder
//////////////////////////////////////////////////////////////////////////////////

module kogge_stone_adder(s,cout,a,b,cin);
input [3:0]a,b;
input cin;
output [3:0]s;
output cout;
wire [3:0]b1;
wire [3:0]p,g;
wire [3:0]p1,g1;
wire [3:0]p2,g2;
wire [4:0]c;
assign b1[0]=b[0]^cin;
assign b1[1]=b[1]^cin;
assign b1[2]=b[2]^cin;
assign b1[3]=b[3]^cin;

assign p[0]=a[0]^b1[0];
assign p[1]=a[1]^b1[1];
assign p[2]=a[2]^b1[2];
assign p[3]=a[3]^b1[3];

assign g[0]=a[0]&b1[0];
assign g[1]=a[1]&b1[1];
assign g[2]=a[2]&b1[2];
assign g[3]=a[3]&b1[3];

assign p1[0]=p[0];
assign g1[0]=g[0];
assign p1[1]=p[1]&p[0];
assign g1[1]=g[1]|(p[1]&g[0]);
assign p1[2]=p[2]&p[1];
assign g1[2]=g[2]|(p[2]&g[1]);
assign p1[3]=p[3]&p[2];
assign g1[3]=g[3]|(p[3]&g[2]);

assign p2[0]=p1[0];
assign g2[0]=g1[0];
assign p2[1]=p1[1];
assign g2[1]=g1[1];
assign p2[2]=p1[2]&p1[0];
assign g2[2]=g1[2]|(p1[2]&g1[0]);
assign p2[3]=p1[3]&p1[1];
assign g2[3]=g1[3]|(p1[3]&g1[1]);

assign c[0]=cin;
assign c[1]=g2[0]|(p2[0]&cin);
assign c[2]=g2[1]|(p2[1]&cin);
assign c[3]=g2[2]|(p2[2]&cin);
assign c[4]=g2[3]|(p2[3]&cin);

assign s[0]=p[0]^c[0];
assign s[1]=p[1]^c[1];
assign s[2]=p[2]^c[2];
assign s[3]=p[3]^c[3];
assign cout=c[4];
endmodule
