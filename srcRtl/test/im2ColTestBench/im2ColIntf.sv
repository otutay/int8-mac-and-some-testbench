import im2ColPckg::*;
interface im2ColIntf (input clk,rst);
	tIm2ColIn iData;
	tIm2ColOut oData;


	modport im2Col (input clk,input rst,input iData,output oData);
	modport driver (input clk,input rst,output iData,input oData);
endinterface