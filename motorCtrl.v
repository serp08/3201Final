module motorCtrl(
	input [1:0] state,
	output reg m1F,
	output reg m1B,
	output reg m2F,
	output reg m2B
);
// check state: 00:stop, 01:right, 10:left, 11:fwd

always begin
	m1F = state[0];
	//m1B = ~state[0];
	m2F = state[1];
	//m2B = ~state[1];
	if(~state[0] && ~state[1]) begin // 00
		m1B = state[0]; m2B = state[1]; 
	end
	else begin
		m1B = ~state[0]; m2B = ~state[1]; 
	end
end
//assign m1B = ~state[0];
//assign m2F = state[1];
//assign m2B = ~state[1];
//
//always begin
//	if(~state[0] && ~state[1]) begin // 00
//		m1B <= ~m1B; m2B <= ~m2B; 
//	end
//end
endmodule