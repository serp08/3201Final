module displayDist(
	input clk,
	output [3:0] ones,
	output [3:0] tens,
	output [3:0] hundreds,
	output [3:0] thous,
	output [3:0] tenthous,
	output [3:0] hunthous,
	input [32:0] num
);

wire [3:0] d0 = num % 10;
wire [3:0] d1 = (num/10) % 10;
wire [3:0] d2 = (num/100) % 10;
wire [3:0] d3 = (num/1000) % 10;
wire [3:0] d4 = (num/10000) % 10;
wire [3:0] d5 = (num/100000) % 10;

sevenSeg one(d0, ones);
sevenSeg ten(d1, tens);
sevenSeg hun(d2, hundreds);
sevenSeg thou(d3, thous);
sevenSeg tthou(d4, tenthous);
sevenSeg hthou(d5, hunthous);

endmodule