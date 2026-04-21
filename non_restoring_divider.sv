`timescale 1ns/1ps
module non_restoring_divider
(
    input wire clk,
    input wire rst,
    input wire signed [3:0]dividend,
    input wire signed [3:0]divisor,
    output reg signed [3:0]q,
    output reg signed [3:0]rem,
    output reg d
);

reg sign_q;
reg sign_r;
reg [3:0]dvd_mag;
reg [3:0]dvs_mag;
reg [3:0]qreg;
reg signed [4:0]a;
reg [2:0]c;
reg started;

wire [2:0]bit_idx=c-1'b1;
wire dvd_bit=dvd_mag[bit_idx];
wire signed [4:0]a_sh={a[3:0],dvd_bit};
wire signed [4:0]a_nxt=a_sh[4]?(a_sh+{1'b0,dvs_mag}):(a_sh-{1'b0,dvs_mag});
wire q_bit=~a_nxt[4];

always@(posedge clk or posedge rst)
begin
    if(rst)
    begin
        a<=5'sb0;
        dvd_mag<=4'b0;
        dvs_mag<=4'b0;
        qreg<=4'b0;
        c<=3'b0;
        q<=4'b0;
        rem<=4'b0;
        d<=1'b0;
        sign_q<=1'b0;
        sign_r<=1'b0;
        started<=1'b0;
    end
    else if(c==0&&started==0)
    begin
        dvd_mag<=dividend[3]?(-dividend):dividend;
        dvs_mag<=divisor[3]?(-divisor):divisor;
        sign_q<=dividend[3]^divisor[3];
        sign_r<=dividend[3];
        a<=5'sb0;
        qreg<=4'b0;
        c<=3'd4;
        d<=1'b0;
        started<=1'b1;
    end
    else if(c>0)
    begin
        a<=a_nxt;
        qreg<={qreg[2:0],q_bit};
        c<=c-1'b1;
    end
    else
    begin
        reg [3:0]mag_r;
        if(a[4])
            mag_r=a[3:0]+dvs_mag;
        else
            mag_r=a[3:0];
        rem<=sign_r?(-mag_r):mag_r;
        q<=sign_q?(-qreg):qreg;
        d<=1'b1;
        started<=1'b0;
    end
end

endmodule