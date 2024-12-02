module motion(
	input clk,
	input sense
);

reg [20:0] counter = 0;

always @(posedge clk) begin
	counter <= counter + 1;
	/*
	if(counter % 2500000 == 0 && sense && ~out) begin // check distance every 50ms, trigger HIGH
		out <= 1'b1;
	end
	else if (counter % 2500000 == 0 && ~sense && out) begin // if triggered & 2us passed
		//out <= 1'b0;
	end*/
end
endmodule