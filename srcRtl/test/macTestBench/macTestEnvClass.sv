import macDriverClassPckg::*;
import macGenClassPckg::*;
import macMonitorClassPckg::*;

class macTestEnvClass;

	macGenClass   macGen ;
	macDriverClass macDriv;
	macMonitorClass macMon;

	mailbox macGen2Driv;


	virtual macIntf vMacIntf;

	function new (virtual macIntf vMacIntf);
		this.vMacIntf = vMacIntf;
		
		macGen2Driv = new();
		macGen = new(macGen2Driv);
		macDriv = new(vMacIntf,macGen2Driv);
		macMon = new(vMacIntf);
	endfunction


	function void setRandomTestSize(int testSize);
		macGen.genNum = testSize;
	endfunction : setRandomTestSize


	task wait4SomeTime();
		repeat(100)
		@(posedge vMacIntf.clk);
	endtask : wait4SomeTime

	task stimGen();
		macGen.boundaryCheck();
		macGen.randomTest();
	endtask: stimGen

	task driveAndMonitor();
		fork
			macDriv.drive();
			macMon.collection();
		join_any

	endtask: driveAndMonitor

	task run();
		stimGen();
		driveAndMonitor();
		wait(macDriv.driverNum == (macGen.genNum)+8); // 8 comes from boundary check;
		wait(macDriv.driverNum == macMon.inNum);
		wait(macDriv.driverNum == macMon.outNum);
		macMon.control();

	endtask: run


endclass : macTestEnvClass