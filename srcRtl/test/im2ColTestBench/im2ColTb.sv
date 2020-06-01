`include "im2ColIntf.sv";
import im2ColTestClassPckg::*;
module im2ColTb ();



	logic clk,rst;


	initial
		begin
			clk = 0;
			rst = 0;
		end

	always #5 clk =~clk;

	im2ColIntf intf (clk,rst);

	im2ColTest test (intf);

	im2Col DUT (
		.iClk (intf.clk  ),
		.iRst (intf.rst  ),
		.iData(intf.iData),
		.oData(intf.oData)
	);

endmodule