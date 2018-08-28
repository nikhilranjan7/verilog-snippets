module syncCount(EN, in, CLK, Q);
	parameter n = 4;
	input EN;
	input in;
	input CLK;
	output [n-1:0] Q;
	reg [n-1:0] Q;
	initial
	Q=4'b0000;
	always @(posedge CLK)
		begin
		if (EN)
		Q[0] <= ~Q[0];
		Q[1] <= (Q[0]&~Q[1])|(~Q[0]&Q[1]);
		Q[2] <= ((Q[1]&Q[0])&(~Q[2]))|((~(Q[1]&Q[0]))&Q[2]);
		Q[3] <= ((Q[2]&Q[1])&(~Q[3]))|((~(Q[2]&Q[1]))&Q[3]);
		end
endmodule

module shiftregtest;
	parameter n= 4;
	reg EN,in , CLK;
	wire [n-1:0] Q;
	//reg [n-1:0] Q;
	syncCount sc(EN,in,CLK,Q);
	initial
	begin
	CLK=0;
	end
	always
	#2 CLK=~CLK;
	initial
	$monitor($time,"EN=%b in= %b Q=%b\n",EN,in,Q);
	initial
	begin
	in=1;EN=1;
	#4 in=1;EN=1;
	#4 in=1;EN=1;
	#4 in=1;EN=1;
	#4 in=1;EN=1;
	#4 in=1;EN=1;
	#4 in=1;EN=1;
	#4 in=1;EN=1;
	#5 $finish;
	end
endmodule