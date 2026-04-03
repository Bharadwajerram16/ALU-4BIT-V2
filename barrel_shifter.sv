`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: E.Bharadwaj
// Create Date: 03.04.2026 19:11:21
// Module Name: barrel_shifter
//////////////////////////////////////////////////////////////////////////////////

module barrel_shifter(y,a,s,m);
output [3:0]y;
input [3:0]a;
input [1:0]s,m;
wire [3:0]p;
reg [3:0]in1,in2;
always@(*)
begin
case(m)
2'b00:
begin
in1[3]=1'b0;
in1[2]=1'b0;
in1[1]=1'b0;
in1[0]=1'b0;
in2[3]=1'b0;
in2[2]=1'b0;
in2[1]=1'b0;
in2[0]=1'b0;
end
2'b01:
begin
in1[3]=a[3];
in1[2]=a[3];
in1[1]=a[3];
in1[0]=a[3];
in2[3]=a[3];
in2[2]=a[3];
in2[1]=a[3];
in2[0]=a[3];
end
2'b10:
begin
in1[3]=a[2];
in1[2]=a[1];
in1[1]=a[0];
in1[0]=a[3];
in2[3]=a[1];
in2[2]=a[0];
in2[1]=a[3];
in2[0]=a[2];
end
2'b11:
begin
in1[3]=a[0];
in1[2]=a[3];
in1[1]=a[2];
in1[0]=a[1];
in2[3]=a[1];
in2[2]=a[0];
in2[1]=a[3];
in2[0]=a[2];
end
endcase
end
mux2 m0(p[0],a[0],in1[0],s[0]);
mux2 m1(p[1],a[1],in1[1],s[0]);
mux2 m2(p[2],a[2],in1[2],s[0]);
mux2 m3(p[3],a[3],in1[3],s[0]);
mux2 m4(y[0],p[0],in2[0],s[1]);
mux2 m5(y[1],p[1],in2[1],s[1]);
mux2 m6(y[2],p[2],in2[2],s[1]);
mux2 m7(y[3],p[3],in2[3],s[1]);
endmodule