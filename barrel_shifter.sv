`timescale 1ns / 1ps
module barrel_shifter(y, a, s, m, dir);
output [3:0] y;
input [3:0] a;
input [1:0] s, m;
input dir;
wire [3:0] p;
reg [3:0] in1, in2;
always @(*)
begin
    case(m)
    2'b00:
    begin
        if(dir == 0)
        begin
            in1 = {a[2:0], 1'b0};
            in2 = {p[2:0], 2'b00};
        end
        else
        begin
            in1 = {1'b0, a[3:1]};
            in2 = {2'b00, p[3:2]};
        end
    end
    2'b01:
    begin
        if(dir == 0)
        begin
            in1 = {a[2:0], 1'b0};
            in2 = {p[2:0], 2'b00};
        end
        else
        begin
            in1 = {a[3], a[3:1]};
            in2 = {{2{p[3]}}, p[3:2]};
        end
    end
    2'b10:
    begin
        in1 = {a[2:0], a[3]};
        in2 = {p[1:0], p[3:2]};
    end
    2'b11:
    begin
        in1 = {a[0], a[3:1]};
        in2 = {p[1:0], p[3:2]};
    end
    endcase
end
mux2 m0(p[0], a[0], in1[0], s[0]);
mux2 m1(p[1], a[1], in1[1], s[0]);
mux2 m2(p[2], a[2], in1[2], s[0]);
mux2 m3(p[3], a[3], in1[3], s[0]);
mux2 m4(y[0], p[0], in2[0], s[1]);
mux2 m5(y[1], p[1], in2[1], s[1]);
mux2 m6(y[2], p[2], in2[2], s[1]);
mux2 m7(y[3], p[3], in2[3], s[1]);
endmodule