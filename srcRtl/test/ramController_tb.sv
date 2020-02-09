module ramController_tb;
timeunit 1ns;
timeprecision 100ps;

logic clk = 0;
realtime  clkPeriod = 5ns;

always 
	begin
		# (clkPeriod/2) clk=~clk;
	end







endmodule