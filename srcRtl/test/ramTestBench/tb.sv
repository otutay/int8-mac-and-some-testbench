`include "memIntf.sv"
`include "test.sv"

module tb;


	logic clk ;
	logic reset;



	always #5 clk =~clk;

	initial begin 
		clk = 0;
		reset  = 1;
		#5 reset = 0;
	end

	memIntf intf(clk,reset);

	test t1(intf);

	ram DUT(.iClk(intf.clk), // Clock
	.iRam(intf.iRam),
	.oRam(intf.oRam));
	
endmodule