`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: E.Bharadwaj
// Create Date: 03.04.2026 11:41:53
// Module Name: wallace_multipler
//////////////////////////////////////////////////////////////////////////////////


module wallace_multipler(p,a,b);
input [3:0]a,b;
output [7:0]p;
wire [1:12]s,c;
reg [3:0][3:0]p1;
integer i,j;
always@(*)
begin
for(i=0;i<=3;i=i+1)
begin
    for(j=0;j<=3;j=j+1)
    begin
        p1[i][j]=a[i]&b[j];
    end
end
end
ha h1(s[1],c[1],p1[2][1],p1[3][0]);
ha h2(s[2],c[2],p1[2][2],p1[3][1]);
ha h3(s[3],c[3],p1[1][1],p1[2][0]);
fa f4(s[4],c[4],p1[0][3],p1[1][2],s[1]);
fa f5(s[5],c[5],p1[1][3],s[2],c[1]);
fa f6(s[6],c[6],p1[3][2],p1[2][3],c[2]);
ha h7(s[7],c[7],p1[0][1],p1[1][0]);
fa f8(s[8],c[8],c[7],p1[0][2],s[3]);
fa f9(s[9],c[9],c[8],s[4],c[3]);
fa f10(s[10],c[10],c[9],s[5],c[4]);
fa f11(s[11],c[11],c[10],s[6],c[5]);
fa f12(s[12],c[12],c[11],p1[3][3],c[6]);
assign p[0]=p1[0][0];
assign p[1]=s[7];
assign p[2]=s[8];
assign p[3]=s[9];
assign p[4]=s[10];
assign p[5]=s[11];
assign p[6]=s[12];
assign p[7]=c[12];
endmodule
