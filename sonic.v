// Inspiration from: https://github.com/borisfba
module sonic(
   input clk,
	output trig,
	input echo,
	output reg [32:0] distance
);

reg [32:0] counter = 0;
reg [32:0] distCounter = 0;
reg trigAlt = 1'b0;

assign trig = trigAlt;

always @(posedge clk) begin
	counter <= counter + 1;
	
	if(counter % 2500000 == 0) begin // check distance every 50ms, trigger HIGH
		trigAlt <= 1'b1;
	end
		
	if (counter % 100 == 0 && trigAlt) begin // if triggered & 2us passed
		trigAlt <= 1'b0;
	end
	
	if (counter % 50 == 0) begin	
		if (echo) begin
			distCounter <= distCounter + 1; // count how long it takes for the signal to bounce back
		end
		else if (distCounter) begin
			distance <= distCounter / 58; // conversion to cm
			distCounter <= 0;
		end
	end
end

endmodule