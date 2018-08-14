module bcdtogray(bcd, gray);
	input [0:3]bcd;
	output [0:3]gray;
	
	buf n1(gray[0], bcd[0]);
	xor n2(gray[1], bcd[1], bcd[0]);
	xor n3(gray[2], bcd[2], bcd[1]);
	xor n4(gray[3], bcd[3], bcd[2]);
endmodule

module testbench;
	wire [0:3]gray;
	reg [0:3]bcd;
	bcdtogray fn(bcd, gray);
		initial
			begin
				$monitor(,$time," %b || %b",bcd,gray);
				#0 bcd = 4'd0;
				#5 bcd = 4'd1;
				#5 bcd = 4'd2;
				#5 bcd = 4'd3;
				#5 bcd = 4'd4;
				
				#5 bcd = 4'd5;
				#5 bcd = 4'd6;
				#5 bcd = 4'd7;
				#5 bcd = 4'd8;
				#5 bcd = 4'd9;
				#5 $finish;
			end
	
		initial 
			begin
				$dumpfile("test.vcd");
				$dumpvars();
			end
endmodule
	