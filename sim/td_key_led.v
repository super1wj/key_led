`timescale  1ns/1ns	//单位/精度
module td_key_led();

reg	sys_clk,sys_rst;
reg		[1:0]key;
wire	[1:0]led;

initial begin
	sys_clk <= 1'b0;
	sys_rst <= 1'b0;
	key <= 2'b00;
	#20
	sys_rst <= 1'b1;
	key <= 2'b01;
	#2000
	key <= 2'b10;
	#2000
	key <= 2'b00;
	#2000
	key <= 2'b11;
	#2000
	$finish;
end

always #10 sys_clk <= ~sys_clk;

key_led #(.CNT_MAX	(25'd25)) u_key_led(//参数传递
			.sys_clk	(sys_clk),
			.sys_rst	(sys_rst),
			.key		(key),
			.led		(led)
			);

endmodule