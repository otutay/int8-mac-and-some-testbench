import im2ColPckg::*;

class im2ColDrivClass;
	virtual im2ColIntf vIm2ColIntf;
	mailbox im2ColGen2Driv;
	int drivenNum;

	function new (virtual im2ColIntf vIm2ColIntf,mailbox im2ColGen2Driv);
		this.vIm2ColIntf = vIm2ColIntf;
		this.im2ColGen2Driv = im2ColGen2Driv;
	endfunction : new

	task reset();
		wait(vIm2ColIntf.rst);
		$display("[im2ColDriver ] reset is issued");
		vIm2ColIntf.iData <= {{log2(cMaxKerWidth-1){1'b0}},{ log2(cNumOfRam-1){1'b0}},{log2(cNumOfRam-1){1'b0}},{1'b0}};
		wait(!vIm2ColIntf.rst);
		$display("[im2ColDriver ] reset ended");
	endtask : reset

	// task drive();
		


endclass : im2ColDrivClass