module LuongMarcoFinal(
	input MAX10_CLK1_50,
	input trig,
	output echo,
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

wire [32:0] dist;

sonic sn(MAX10_CLK1_50, trig, echo, dist);

displayDist dd(MAX10_CLK1_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, dist);

endmodule