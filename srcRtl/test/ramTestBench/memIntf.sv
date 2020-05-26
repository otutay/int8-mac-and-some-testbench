import ramPckg::*;
// `include "ramPckg.sv"
interface memIntf (input logic clk,reset);

	tRamInData iRam;
	tRamOutData oRam;

	clocking cbDriver @(posedge clk);
		default input #1ns output #1ns;
		output iRam;
		input  oRam;
	endclocking

	clocking cbMonitor @(posedge clk);
		default input #1ns output #1ns;
		input iRam;
		output oRam;
	endclocking

	modport  Driver (clocking cbDriver, input clk,reset);

	modport  Monitor (clocking cbMonitor, input iRam, oRam);

endinterface