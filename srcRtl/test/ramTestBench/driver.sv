
import  transactionPckg::*;

class driver;
// declare virtual interfaces
	virtual memIntf vMemIntf;
// gen2Driver mailbox
	mailbox gen2Driv;

// numberOF transaction
	int noOfTrans;
// constructor
	function new (virtual memIntf vMemIntf, mailbox gen2Driv);
		this.vMemIntf = vMemIntf;
		this.gen2Driv = gen2Driv;
	endfunction

	task reset;
		wait(vMemIntf.reset);
		$display("--- [DRIVER] Reset Starter");
		vMemIntf.cbDriver.iRam.wEn = 0;
		vMemIntf.cbDriver.iRam.en = 0;
		vMemIntf.cbDriver.iRam.data = 0;
		vMemIntf.cbDriver.iRam.addr = 0;
		wait(!vMemIntf.reset);
		$display("--- [DRIVER] Reset Ended");
	endtask : reset


	task drive;
		transaction trans;
		$display("in DRIVE");
		
		while (gen2Driv.num() > 0)
			begin
				$display(" [DRIVER] there is a transaction ");
				vMemIntf.cbDriver.iRam.wEn = 0;
				vMemIntf.cbDriver.iRam.en = 0;
				gen2Driv.get(trans);
				vMemIntf.cbDriver.iRam.addr = trans.iRam.addr;
				vMemIntf.cbDriver.iRam.data = trans.iRam.data;
				vMemIntf.cbDriver.iRam.en = trans.iRam.en;
				vMemIntf.cbDriver.iRam.wEn = trans.iRam.wEn;
				if(trans.iRam.en == 1 & trans.iRam.wEn == 0)
					begin
						@(posedge vMemIntf.clk);
						$display("----------- [DRIVER read Data : at  addr %d, data %d] --------------",vMemIntf.cbDriver.iRam.addr,vMemIntf.cbDriver.iRam.data);
					end
				else if (trans.iRam.en == 1 & trans.iRam.wEn == 1)
					begin
						$display("----------- [DRIVER write Data : at  addr %d, data %d] --------------",vMemIntf.cbDriver.iRam.addr,vMemIntf.cbDriver.iRam.data);
						@(posedge vMemIntf.clk);
					end
				else
					$display("[DRIVER] no transaction");
			end
	endtask: drive
	// forever begin
	// 	transaction trans;
	// 	vMemIntf.cbDriver.iRam.wEn = 0;
	// 	vMemIntf.cbDriver.iRam.en = 0;
	// 	gen2Driv.get(trans);
	// 	$display("----------- [DRIVER tranfers : %d] --------------",noOfTrans);
	// 	@(posedge vMemIntf.clk);
	// 	$display("in drive at posedge");
	// 	vMemIntf.cbDriver.iRam.addr = trans.iRam.addr;
	// 	vMemIntf.cbDriver.iRam.data = trans.iRam.data;
	// 	vMemIntf.cbDriver.iRam.en = trans.iRam.en;
	// 	vMemIntf.cbDriver.iRam.wEn = trans.iRam.wEn;
	// 	if(trans.iRam.en == 1 & trans.iRam.wEn == 0) begin
	// 		@(posedge vMemIntf.clk);
	// 		$display("----------- [DRIVER read Data : at  addr %d, data %d] --------------",vMemIntf.cbDriver.iRam.addr,vMemIntf.cbDriver.iRam.data);
	// 	end
	// 	else if (trans.iRam.en == 1 & trans.iRam.wEn == 1) begin
	// 		$display("----------- [DRIVER write Data : at  addr %d, data %d] --------------",vMemIntf.cbDriver.iRam.addr,vMemIntf.cbDriver.iRam.data);
	// 		@(posedge vMemIntf.clk);
	// 	end
	// 	else
	// 		$display("[DRIVER] no transaction");
	// 	noOfTrans++;
	// end



endclass : driver