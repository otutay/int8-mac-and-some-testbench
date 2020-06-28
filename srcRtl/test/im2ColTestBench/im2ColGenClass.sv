import im2ColTransClassPckg::*;

class im2ColGenClass;
	im2ColTransClass trans;

	mailbox im2ColGen2Driv;

	int genNum;

	function new (mailbox im2ColGen2Driv, int genNum);
		this.im2ColGen2Driv = im2ColGen2Driv;
		this.genNum = genNum;
	endfunction : new

	task randomTrans();

		for (int i = 0; i < genNum; i++)
			begin
				trans = new();
				if(!trans.randomize())
					begin
						$display("[im2ColGenClass -> randomization] randomization error");
					end
				else
					begin
						im2ColGen2Driv.put(trans);
						$display("[im2ColGenClass -> randomization] data is %p",trans.iData);
					end
			end
	endtask: randomTrans




endclass : im2ColGenClass