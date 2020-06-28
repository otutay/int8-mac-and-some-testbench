`include "im2ColIntf.sv";
// import im2ColTestClassPckg::*;
module im2ColTb ();



	logic clk,rst;

	logic [31:0] counter ='{default:'0};


	initial
		begin
			clk <= 0;
			// rst <= 0;
		end

	always #5 clk =~clk;


	always_ff @(posedge clk) begin 
	 	counter <=  counter + 1;
	end
	
	always_ff @(posedge clk) begin  
	 	if(counter > 30 & counter < 50)
	 		rst<= 1'b1 ;
	 	else
	 		rst<= 1'b0 ;
	end
	



	im2ColIntf intf (clk,rst);

	im2ColTest test (intf);

	im2Col DUT (
		.iClk (intf.clk  ),
		.iRst (intf.rst  ),
		.iData(intf.iData),
		.oData(intf.oData)
	);

endmodule