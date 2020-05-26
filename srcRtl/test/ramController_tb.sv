// `include "ramControllerPckg.vhd";
module ramController_tb ();
	timeunit 1ns;
	timeprecision 100ps;

	logic    clk       = 0  ;
	logic    rst       = 0  ;
	realtime clkPeriod = 5ns;

	always
		begin
			# (clkPeriod/2) clk=~clk;
		end

	ramController u1 (
		.iClk(clk),
		.iRst(rst)
	);




// always_ff @(posedge clk)
// begin

// 	end






endmodule