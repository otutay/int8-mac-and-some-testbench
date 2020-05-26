
// `include "transaction.sv"
import transactionPckg::*;
import ramPckg::*;

class generator;
	transaction trans;

// share the transaction variable with driver and other stuff
	mailbox gen2Driv   ;
	int     repeatCount;
	event generatorEnded;
	function new(mailbox gen2Driv,event ended);
		this.gen2Driv = gen2Driv;
		this.generatorEnded = ended;
	endfunction


	task writeLinear;
		for (int i = 0; i < cRamDepth; i++) begin
			trans = new();
			if(!trans.randomize())
				begin
					$fatal("Gen :: trans randomization error");
				end
			else
				begin
					trans.iRam.addr = i;
					trans.iRam.wEn = 1'b1;
					trans.iRam.en = 1'b1;
					$display("[GENERATOR] is writing random data [%d] to given addr [%d] ,wen %b , en %b",trans.iRam.data,trans.iRam.addr,
						trans.iRam.wEn , trans.iRam.en);
					gen2Driv.put(trans);
				end
		end
		-> generatorEnded;
	endtask: writeLinear

	task main();
		repeat(repeatCount) begin
			trans = new();
			if(!trans.randomize())
				begin
					$fatal("Gen :: trans randomization error");
				end
			else
				begin
					$display(" [GENERATOR] addr = %d,data = %d, wEn = %b, en = %b",trans.iRam.addr,trans.iRam.data,
						trans.iRam.wEn,trans.iRam.en);
					gen2Driv.put(trans);
				end// if else
		end // repeat
		-> generatorEnded;
	endtask// main task


endclass : generator;
