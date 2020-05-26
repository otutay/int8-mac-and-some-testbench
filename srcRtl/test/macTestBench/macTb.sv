`include "macIntf.sv"
import macTestEnvClassPckg::*;
module macTb ();

	logic clk;
	// macTestEnvClass macTestEnv;




	initial
	begin
		clk =0;
	end

	always #5 clk =~clk;

	macIntf intf(clk);	
	macTest test(intf);

	mac DUT(.iClk(intf.clk),
		.iData(intf.iData),
		.oData(intf.oData));

endmodule: macTb