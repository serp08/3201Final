/*
motor1 (left: IN1, IN2) - D3, D2
motor2 (right: IN3, IN4) - D5, D4
led + spkr - D6
motion - D7
echo - D8
trig - D9
*/

module LuongMarcoFinal(
	input clk,
	output trig,
	input echo,
	input motion,
	output ledSpkr,
	output m1F, m1B, m2F, m2B,
	output [6:0] HEX0, HEX1, HEX2, HEX3
);

reg [1:0] toggle = 1'b0;
reg [2:0] state = 0, leftRight;
reg [32:0] counter = 0, distCounter = 0;
integer angle = 0;

// Controlling HC-SR04 ultrasonic distance sensor
wire [32:0] dist;
reg [32:0] largestDist = 0;
sonic sn(clk, trig, echo, dist);
sevenSeg one(dist % 10, HEX0); // ones
sevenSeg ten((dist/10) % 10, HEX1); // tens
sevenSeg hun((dist/100) % 10, HEX2); // hundreds
sevenSeg thou((dist/1000) % 10, HEX3); // thousands

// Control the led + spkr
beepBlink bb(clk, toggle, ledSpkr);

// Motor chip control
motorCtrl mc(state, m1F, m1B, m2F, m2B);

always @(posedge motion) begin // if motion sensor detects motion
	if(toggle == 1'b0) begin
		//start program
		toggle <= 1'b1;
	end
end

always @(posedge clk) begin
	if(toggle == 1'b1) begin
		if(dist < 25) begin
			
			// turn right 90 deg (01), left 180 (10),  right 90 (01)
			// keep track of clock of the longest distance recorded + direction
			// turn -direction- until turnduration (--) is zero, proceed
			counter <= counter + 1;
			
			if(dist > largestDist) begin
				largestDist <= dist;
				distCounter <= counter;
				leftRight <= state;
			end
			if(counter % 27500000 == 0) begin
				if(state == 0) begin
					state <= state + 1;
				end
				case(state)
					2'b01: ;
					2'b10: ;
				endcase;
			end
			state <= 2'b11; angle = 0; counter <= 0; distCounter <= 0; // reset
		end
		else if(dist >= 25) begin // fwd
			
		end
		else begin
			//motorCtrl();
		end
	end
end

endmodule