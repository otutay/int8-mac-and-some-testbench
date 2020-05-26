import macTransClassPckg::*;
import macPckg::*;
import macScoreClassPckg::*;

class macMonitorClass;

	virtual macIntf vMacIntf;

	
	mailbox inData2Score  = new();
	mailbox outData2Score = new();

	macScoreClass score = new(inData2Score,outData2Score);

	int inNum , outNum;

	function new(virtual macIntf vMacIntf);
		this.vMacIntf = vMacIntf;
	endfunction : new

	task inCollection();
		forever
			begin
				@(posedge vMacIntf.clk);
				if(vMacIntf.iData.dv ==1'b1)
				begin 
					inNum ++;
					inData2Score.put(vMacIntf.iData);
					$display("[MONITOR <------ inNum %d] inData %p size %d",inNum,vMacIntf.iData,inData2Score.num());
					end
					
			end
	endtask: inCollection

	task outCollection();
		// while(vMacIntf.oData.dv)
		forever
			begin
				@(posedge vMacIntf.clk);
				if(vMacIntf.oData.dv ==1'b1)
					begin 
						outNum ++;	
						outData2Score.put(vMacIntf.oData);
						$display("[MONITOR  -----> outnum %d] outData %p size %d",outNum,vMacIntf.oData,outData2Score.num());
					end
					

			end
	endtask: outCollection

	task collection();
		fork
		inCollection();
		outCollection();
		join;
	endtask: collection

	task control();
		score.main();
	endtask: control


endclass : macMonitorClass