import macPckg::*;
interface macIntf (input clk);
	tMultIn iData;
	tMultOut oData;


	modport mac (input clk, input iData, output oData);
	modport driver (input clk, output iData, input oData);
	
endinterface