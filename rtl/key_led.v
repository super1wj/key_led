module key_led(sys_clk,sys_rst,key,led);

input 	sys_clk,sys_rst;
input	[1:0]key;
output	[1:0]led;

reg	[1:0]led;
reg	[24:0]cnt;
reg flag;

parameter	CNT_MAX = 25'd25000000;

//计数器计时0.5s
always@(posedge sys_clk or negedge sys_rst)
begin 
	if(!sys_rst)begin
		cnt <= 25'd0;
		flag <= 1'b0;
		end
	else if(cnt < (CNT_MAX - 25'd1))
		cnt <= cnt + 25'd1;
	else if(cnt == (CNT_MAX - 25'd1))begin
		cnt <= 25'd0;
		flag <= ~flag;
		end
	else begin
		cnt <= 25'd0;
		flag <= 1'b0;
		end
end

//LED控制
always@(posedge sys_clk or negedge sys_rst)
begin
	if(!sys_rst)
		led <= 2'b00;
	else case({key,flag})
			3'b010:led <= 2'b00;
			3'b011:led <= 2'b11;
			3'b100:led <= 2'b01;
			3'b101:led <= 2'b10;
			default:;
		 endcase
end

endmodule