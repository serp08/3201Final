module beepBlink(
	input clk,
	input sysActive,
	output ledSpkr
);

reg [32:0] counter = 0;
reg [1:0] on = 1'b0;

reg ledSpkrAlt = 1'b0;
assign ledSpkr = ledSpkrAlt;

always @(posedge clk) begin
	if(sysActive == 1'b1) begin
		counter <= counter + 1;
		
		if(counter % 100000000 == 0) begin // toggle every 2s
			if(on == 1'b0) begin
				ledSpkrAlt <= 1'b1;
				on <= 1'b1;
			end
			else begin
				ledSpkrAlt <= 1'b0;
				on <= 1'b0;
			end
		end
	end
end
endmodule