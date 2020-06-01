import im2ColGenClassPckg::*;
import im2ColDrivClassPckg::*;

class im2ColEnvClass;
	im2ColGenClass im2ColGen;
	im2ColDrivClass im2ColDriv;
	virtual im2ColIntf vIm2ColIntf;

	mailbox im2ColGen2Driv;
	int testNum = 10;
	function new (virtual im2ColIntf vIm2ColIntf);
		// build interface
		this.vIm2ColIntf = vIm2ColIntf;
		//build mailbox
		im2ColGen2Driv = new();

		// build gen and driv obj
		im2ColGen = new(im2ColGen2Driv,testNum);
		im2Driv = new(vIm2ColIntf,im2ColGen2Driv);
	endfunction : new

	task reset();
		$display("[im2ColEnv ] reset is about the start");
		im2ColDriv.reset();
		$display("[im2ColEnv ] reset is issued");
	endtask : reset


	task test();
		$display("[im2ColEnv ] test is about the start");
		fork 
			im2ColGen.randomize();
			im2ColDriv.drive();
		join
		$display("[im2ColEnv ] test is issued");
	endtask : test


	task run();
		reset();
		test();
	endtask: run

endclass : im2ColEnvClass