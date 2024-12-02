module motorCtrl(
	input [2:0] state,
	output m1F,
	output m1B,
	output m2F,
	output m2B
);
// check state: 00:stop, 01:right, 10:left, 11:fwd

reg m1FReg = 1'b0;
reg m1BReg = 1'b0;
reg m2FReg = 1'b0;
reg m2BReg = 1'b0;

assign m1F = m1FReg;
assign m1B = m1BReg;
assign m2F = m2FReg;
assign m2B = m2BReg;

always begin
	if(state[0] == 1'b1) begin
		m1FReg <= 1'b1; m1BReg <= 1'b0;
	end
	else begin
		m1FReg <= 1'b0; m1BReg <= 1'b1;
	end
	
	
	if(state[1] == 1'b1) begin
		m2FReg <= 1'b1; m2BReg <= 1'b0;
	end
	else if(state[0] == 1'b1) begin
		m2FReg <= 1'b0; m2BReg <= 1'b1;
	end
	
	
	if(~(state[0] & state[1])) begin
		m1BReg <= 0; m2BReg <= 0; // stop the rover
	end
end
endmodule