import macPckg::*;
import macTransClassPckg::*;
class macDriverClass;

	virtual macIntf vMacIntf;

	mailbox macGen2Driv;

	event driverFinished;

	int driverNum;

	function new (virtual macIntf vMacIntf,mailbox macGen2Driv);
		this.macGen2Driv = macGen2Driv;
		this.vMacIntf = vMacIntf;
	endfunction


	function void printData (tMultIn iData);
		$display("[MAC Driver ] data are %p",iData);
	endfunction : printData

	// drive the dut as soon as the data available
	task drive();
		macTransClass trans;
		$display("in [MAC DRIVE]");
		vMacIntf.iData.dv = 0;

		while(macGen2Driv.num() > 0)
			begin
				@(posedge vMacIntf.clk);
				driverNum ++;
				$display("[MAC DRIVE Num %d] transaction will occur",driverNum);
				macGen2Driv.get(trans);
				printData(trans.iData);
				vMacIntf.iData = trans.iData;
				vMacIntf.iData.dv = 1;
				@(posedge vMacIntf.clk);
				vMacIntf.iData.dv = 0;				
			end
		-> driverFinished;
	endtask : drive


endclass : macDriverClass