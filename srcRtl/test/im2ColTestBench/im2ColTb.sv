import im2ColPckg::*;
module im2ColTb ();



	logic        clk        ;
	logic        rst        ;
	tIm2ColIn    iData      ;
	tIm2ColOut   oData      ;
	logic [31:0] counter = 0;

	initial
		begin
			clk <= 0;
			rst <= 1;
			#100 rst <= 0;
			// counter <= 0;
		end




	im2Col DUT(
		.iClk (clk),
		.iRst (rst),
		.iData(iData),
		.oData(oData)

	);



	always #5 clk =~clk;

	always_ff @(posedge clk)
		begin
			counter <= counter + 1;
		end


	always_ff @(posedge clk)
		begin
			if(counter == 105)
				begin
					iData.kerWidth   <= 0;
					iData.startAddrX <= 2;
					iData.startAddrY <= 3;
					iData.dv         <= 1;
				end
			else
				iData.dv <= 0;
		end

endmodule