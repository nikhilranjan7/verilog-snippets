module reg_32bit(Q, in, CLK, EN);

parameter n = 32;
input EN;
input [31:0] in;
input CLK;
output [n-1:0] Q;
reg [n-1:0] Q;

initial
Q=32'd11111;
always @(posedge CLK)
begin
if (EN)
Q={in,Q[n-1:1]};
end
endmodule

module tb32reg;
reg [31:0] d;
reg clk,reset;
wire [31:0] q;
reg_32bit R(q,d,clk,reset);
always @(clk)
#5 clk<=~clk;
initial
$monitor($time,"q=%h",q);
initial
begin
clk= 1'b1;
reset=1'b0;//reset the register
#20 reset=1'b1;
#20 d=32'hAFAFAFAF;
#200 $finish;
end
endmodule

/*
module shiftregtest;
parameter n= 32;
reg EN,in , CLK;
wire [n-1:0] Q;
//reg [n-1:0] Q;
shiftreg shreg(EN,in,CLK,Q);
initial
begin
CLK=0;
end
always
#1 CLK=~CLK;
initial
$monitor($time,"EN=%b in= %b Q=%b\n",EN,in,Q);
initial
begin
in=0;EN=0;
#4 in=1;EN=1;
#4 in=1;EN=0;
#4 in=0;EN=1;
#5 $finish;
end
endmodule
*/