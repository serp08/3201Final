module displayDist(
	input clk,
	output [3:0] ones,
	output [3:0] tens,
	output [3:0] hundreds,
	output [3:0] thous,
	input [32:0] num
);

wire [3:0] d0 = num % 10;
wire [3:0] d1 = (num/10) % 10;
wire [3:0] d2 = (num/100) % 10;
wire [3:0] d3 = (num/1000) % 10;

always @(posedge clk) begin
	sevenSeg one(d0, ones);
	sevenSeg ten(d1, tens);
	sevenSeg hun(d2, hundreds);
	sevenSeg thou(d3, thous);
end

endmodule