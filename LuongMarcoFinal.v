module LuongMarcoFinal(
	input clk,
	output trig,
	input echo,
	output [6:0] HEX0, HEX1, HEX2, HEX3
);

/*
echo - D8
trig - D9
*/

wire [32:0] dist;

// Controlling HC-SR04 ultrasonic distance sensor
sonic sn(clk, trig, echo, dist);
sevenSeg one(dist % 10, HEX0); // ones
sevenSeg ten((dist/10) % 10, HEX1); // tens
sevenSeg hun((dist/100) % 10, HEX2); // hundreds
sevenSeg thou((dist/1000) % 10, HEX3); // thousands





endmodule