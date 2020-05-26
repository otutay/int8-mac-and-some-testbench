// `include "generator.sv"
// `include "driver.sv"
import generatorPckg::*;
import driverPckg::*;

class environment;

// class decleration
generator gen ;
driver    driv;
// mailboxes
mailbox gen2Driv;
// generator ended event
event generatorEnded;

virtual memIntf vMemIntf;

//environment class constructor;
function new (virtual memIntf vMemIntf);
	this.vMemIntf = vMemIntf;
	gen2Driv = new();

	gen = new(gen2Driv,generatorEnded);
	driv = new(vMemIntf,gen2Driv);


endfunction : new


// write pre test and post tasks;

task preTest();
	// in pretest reset the driver
	driv.reset();
	wait(!vMemIntf.reset);
	$display("reset Finished");
	fork
		$display("in processes");
		gen.writeLinear();
		driv.drive();
	join_none
	$display("pretest finished --------------");
endtask : preTest

task test();
	
	wait(generatorEnded.triggered);
	$display("test started");
	fork
		gen.main();
		driv.drive();// different from the example
	join_any

endtask : test

task postTest();
	wait(generatorEnded.triggered);
	wait(gen.repeatCount == driv.noOfTrans);
endtask : postTest

task run();
	preTest();
	test();
	postTest();
endtask: run

endclass