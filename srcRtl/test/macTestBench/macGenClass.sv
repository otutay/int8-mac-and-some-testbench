import macTransClassPckg::*;
import macPckg::*;
class macGenClass;
	macTransClass trans;
	mailbox macGen2Driv;

	int genNum = 10;
	event genFinished;

	function new (mailbox macGen2Driv);
		this.macGen2Driv = macGen2Driv;
	endfunction
	
	function tMultIn dataArranger (logic [2:0] boundarySelect);
		tMultIn retIData;
		if(boundarySelect[0])
			retIData.a1 = -127;
		else
			retIData.a1 = 127;

		if(boundarySelect[1])
			retIData.a2 = -127;
		else
			retIData.a2 = 127;
		
		if(boundarySelect[2])
			retIData.w = -127;
		else
			retIData.w = 127;
		return retIData;
	endfunction : dataArranger

	function void printData (tMultIn iData);
			$display("[MAC GEN ] data are %p",iData);	
	endfunction : printData

	task boundaryCheck();
		// there are 3! boundary to check write it cleverly. more data in.
		logic [2:0] boundarySelect = 3'b0;
		
		for (int i = 0; i < 8; i++) begin
			trans = new();
			trans.iData = dataArranger(boundarySelect);
			trans.iData.dv = 1'b0;
			printData(trans.iData);
			macGen2Driv.put(trans);
			boundarySelect ++;	
		end	
		-> genFinished;
	endtask : boundaryCheck

	task randomTest();
		for (int i = 0; i < genNum; i++) begin
			trans = new();
			if(!trans.randomize())
				begin 
					$fatal("[MAC GEN -> randomTest] randomization error. ");
				end
			else
				begin 
					printData(trans.iData);
					macGen2Driv.put(trans);
				end
		end
		-> genFinished;
	endtask: randomTest





endclass : macGenClass;




