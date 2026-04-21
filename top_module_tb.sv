`timescale 1ns/1ps
module top_module_tb();

reg clk,rst;
reg [3:0]a,b;
reg [2:0]op,op1;
reg [1:0]sel_shift,mode_shift;
reg dir;
wire [7:0]result;
wire Z,C,S,V,done;

top_module x1(clk,rst,a,b,op,op1,sel_shift,mode_shift,dir,result,Z,C,S,V,done);

always #5 clk=~clk;

initial
begin
    clk=0;rst=1;
    a=0;b=0;op=0;op1=0;
    sel_shift=0;mode_shift=0;dir=0;
    #10 rst=0;

    #10 op=3'b000;a=4'b0000;b=4'b0000;
    #10 a=4'b0100;b=4'b0010;
    #10 a=4'b0111;b=4'b1000;
    #10 a=4'b1111;b=4'b0001;
    #10 a=4'b1000;b=4'b1000;

    #10 op=3'b110;a=4'b0100;b=4'b0010;
    #10 a=4'b0101;b=4'b0101;
    #10 a=4'b1111;b=4'b0001;
    #10 a=4'b0010;b=4'b1001;

    #10 op=3'b001;op1=3'b000;a=4'b1010;b=4'b1100;
    #10 op1=3'b001;
    #10 op1=3'b010;
    #10 op1=3'b011;
    #10 op1=3'b100;
    #10 op1=3'b101;
    #10 op1=3'b110;
    #10 op1=3'b111;

    #10 op=3'b010;a=4'b0001;sel_shift=2'd1;mode_shift=2'b00;dir=0;
    #10 a=4'b0011;sel_shift=2'd2;
    #10 a=4'b1000;sel_shift=2'd1;mode_shift=2'b01;dir=1;
    #10 a=4'b1000;sel_shift=2'd1;mode_shift=2'b10;dir=1;
    #10 a=4'b0001;sel_shift=2'd1;mode_shift=2'b11;dir=0;
    #10 a=4'b1000;sel_shift=2'd1;dir=1;

    #10 op=3'b011;a=4'b0011;b=4'b0010;
    #10 a=4'b0101;b=4'b0011;
    #10 a=4'b0111;b=4'b0111;
    #10 a=4'b1111;b=4'b1111;
    #10 a=4'b0000;b=4'b1001;

    op=3'b100;rst=1;#10 rst=0;
    a=4'b0110;b=4'b0011;
    wait(done);#10;

    rst=1;#10 rst=0;
    a=4'b1001;b=4'b0100;
    wait(done);#10;

    rst=1;#10 rst=0;
    a=4'b1111;b=4'b0100;
    wait(done);#10;

    op=3'b101;rst=1;#10 rst=0;
    a=4'b0111;b=4'b0011;
    wait(done);#10;

    rst=1;#10 rst=0;
    a=4'b1001;b=4'b0011;
    wait(done);#10;

    rst=1;#10 rst=0;
    a=4'b0101;b=4'b0100;
    wait(done);#10;

    #20 $stop;
end

endmodule