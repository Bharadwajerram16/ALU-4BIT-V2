`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: E.Bharadwaj
// Create Date: 03.04.2026 12:23:52
// Module Name: non_restoring_divider
//////////////////////////////////////////////////////////////////////////////////


module non_restoring_divider(
    input wire clk,
    input wire rst,
    input wire signed [3:0]dividend,
    input wire signed [3:0]divisor,
    output reg signed [3:0]q,
    output reg signed [3:0]rem,
    output reg d
);
reg signed [3:0]a;
reg signed [3:0]m;
reg [3:0]qreg;
reg [2:0]c;
reg signed [3:0]an;
always@(*)
begin
    if(a[3]==1'b0)
        an=a-m;
    else
        an=a+m;
end
always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        a<=4'b0000;
        qreg<=dividend;
        m<=divisor;
        c<=3'd4;
        q<=4'b0;
        rem<=4'b0;
        d<=1'b0;
    end
    else if(c>0)
    begin
        {a,qreg}<={an[2:0],qreg,~an[3]};
        c<=c-1'b1;
        d<=1'b0;
    end
    else
    begin
        if(a[3]==1'b1)
            rem<=a+m;
        else
            rem<=a;
        q<=qreg;
        d<=1'b1;
    end
end
endmodule
