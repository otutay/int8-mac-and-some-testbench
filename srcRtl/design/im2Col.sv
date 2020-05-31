import im2ColPckg::*;
import funcPckg::*;
module im2Col (
	input  logic      iClk , // Clock
	input  logic      iRst ,
	input  tIm2ColIn  iData,
	output tIm2ColOut oData
);

	tIm2ColState                     state    = idle;
	logic [log2(cMaxKerWidth-1)-1:0] kerWidth       ;
	// tIm2ColIn                      dataIn        ;
	tIm2ColOut                     dataOut    ;
	logic [log2(cMaxKerWidth-1):0] count   = 1;

	always_ff @(posedge iClk)
		begin
			if(iRst)
				begin
					state <= idle;
				end
			else
				begin
					case (state)
						idle :
							begin
								dataOut <= {0,0,0,0};
								count   <= 0;
								if(iData.dv)
									begin
										dataOut.xAddr <= calcAddr(iData.startAddrX);
										dataOut.yAddr <= iData.startAddrY;
										dataOut.dv    <= validAddr(iData.kerWidth);
										kerWidth      <= iData.kerWidth;
										state         <= calc;
									end
								else
									state <= idle;
							end
						calc :
							begin
								dataOut.xAddr <= dataOut.xAddr;
								dataOut.yAddr <= dataOut.yAddr + 1;
								dataOut.dv    <= dataOut.dv;
								count         <= count + 1;
								if(count == kerWidth)
									begin
										dataOut. dv <= {cMaxKerWidth{1'b0}};
										state        <= idle;
										dataOut.done <= 1'b1;
									end
							end
					endcase
				end
		end

	assign oData = dataOut;


endmodule