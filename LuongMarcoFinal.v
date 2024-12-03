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

reg [1:0] toggle = 0, scanning = 0, adjusting = 0;
reg [2:0] state = 0, leftRight; // keep track of orientation of the rover
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
	if(toggle == 0) begin
		//start program
		toggle <= 1;
	end
end

always @(posedge clk) begin
	if(toggle == 1'b1) begin
		if(dist < 25 || scanning == 1) begin 
			if(scanning == 0) scanning <= 1;
			
			// turn right 90 deg (01), left 180 (10),  right 90 (01)
			// turn -direction- until turnduration (--) is zero, proceed
			counter <= counter + 1;
			
			// keep track of clock of the longest distance recorded + direction
			if(dist > largestDist) begin
				largestDist <= dist;
				distCounter <= counter % 27500000;
				leftRight <= state;
			end
			
			// increment state > turn right, set angle 90 > increment state > turn left 90 (back to fwd) > turn left 90 again > set to -90 > decrement state > turn right 90 (back to fwd)
			if(counter % 27500000 == 0 && adjusting != 1) begin
				case(state)
					2'b01: begin
						angle <= angle + 90;
						if(angle == 0) begin // finished scanning
							adjusting <= 1;
						end
					end
					2'b10: begin 
						angle <= angle - 90;
					end
				endcase
				
				if(state != 2 || angle != 0) begin
					state <= state + 1;
					if(state == 3) begin
						state <= 1;
					end
				end
			end
			
			if(distCounter > 0 && adjusting == 1) begin
				state <= leftRight; // set the state to turn in the direction of the longest distance recorded
				distCounter <= distCounter - 1; // keep turning until direction reached
				if(distCounter == 0) begin // at the end, reset all parameters
					counter <= 0; distCounter <= 0; scanning <= 0; adjusting <= 0;
				end
			end
		end
		else if(dist >= 25 && scanning == 0) begin // fwd
			state = 3; // 11 both motors on
		end
		else begin // stop
			state = 0; // 00 both motors off
		end
	end
end

endmodule