module DECODER(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);
	input x,y,z;
	output d0,d1,d2,d3,d4,d5,d6,d7;
	wire x0,y0,z0;
	not n1(x0,x);
	not n2(y0,y);
	not n3(z0,z);
	and a0(d0,x0,y0,z0);
	and a1(d1,x0,y0,z);
	and a2(d2,x0,y,z0);
	and a3(d3,x0,y,z);
	and a4(d4,x,y0,z0);
	and a5(d5,x,y0,z);
	and a6(d6,x,y,z0);
	and a7(d7,x,y,z);
endmodule

module FADDER(s,c,x,y,z);
	input x,y,z;
	wire d0,d1,d2,d3,d4,d5,d6,d7;
	output s,c;
	DECODER dec(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);
	assign s = d1 | d2 | d4 | d7,
		   c = d3 | d5 | d6 | d7;
endmodule

module eightbit(f,cout, a,b,cin);
	input [0:7]a, b; 
	input cin;
	output [0:7]f;
	output cout;
	wire [0:6]w;
	
	FADDER n0(f[0], w[0], a[0], b[0], cin);
	FADDER n1(f[1], w[1], a[1], b[1], w[0]);
	FADDER n2(f[2], w[2], a[2], b[2], w[1]);
	FADDER n3(f[3], w[3], a[3], b[3], w[2]);
	FADDER n4(f[4], w[4], a[4], b[4], w[3]);
	FADDER n5(f[5], w[5], a[5], b[5], w[4]);
	FADDER n6(f[6], w[6], a[6], b[6], w[5]);
	FADDER n7(f[7], cout, a[7], b[7], w[6]);

endmodule

module testbench;
	wire [0:7]f;
	wire cout;
	reg [0:7]a, b;
	reg cin;
	eightbit fn(f,cout, a,b,cin);
		initial
				begin
					$monitor(,$time," %b %b || %b" ,a, b, f);
					#0 a = 8'd4; b = 8'd2; cin = 0; 
					#5 $finish;
				end
		initial 
			begin
				$dumpfile("test.vcd");
				$dumpvars();
			end
endmodule