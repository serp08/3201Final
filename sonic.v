// Credit to https://github.com/borisfba
module sonic(
   input clock,
	output trig,
	input echo,
	output reg [32:0] distance
);

reg [20:0] counter = 0;
reg [32:0] us_counter = 0;
reg _trig = 1'b0;

assign trig = _trig;

always @(posedge clock) begin
	counter <= counter + 1;
	
	if(counter % 2500000 == 0) begin // check distance every 50ms, trigger HIGH
		_trig <= 1'b1;
	end
		
	if (counter % 100 == 0 && _trig) begin // if triggered & 2us passed
		_trig <= 1'b0;
	end
	
	if (counter % 50 == 0) begin	
		if (echo) begin
			us_counter <= us_counter + 1; // count how long it takes for the signal to bounce back
		end
		else if (us_counter) begin
			distance <= us_counter / 58; 
			us_counter <= 0;
		end
	end
end

endmodule