import im2ColPckg::*;
import tilePckg::*;
import funcPckg::*;
import im2ColTransClassPckg::*;

class im2ColDrivClass;
	virtual im2ColIntf vIm2ColIntf;
	mailbox im2ColGen2Driv;
	int     drivenNum     ;

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

	task drive();
		im2ColTransClass trans;
		while(im2ColGen2Driv.num()> 0)
			begin
				$display("[Driver ] initiated new transfer  ----> ");
				vIm2ColIntf.iData.dv = 1'b0;
				im2ColGen2Driv.get(trans);
				@(posedge vIm2ColIntf.clk);
				vIm2ColIntf.iData.dv = 1'b1;
				vIm2ColIntf.iData.kerWidth = trans.iData.kerWidth;
				vIm2ColIntf.iData.startAddrX = trans.iData.startAddrX;
				vIm2ColIntf.iData.startAddrY = trans.iData.startAddrY;
				$display("[Driver  ] data sent is %p",trans.iData);
				@(posedge vIm2ColIntf.clk);
				vIm2ColIntf.iData.dv = 1'b0;
				vIm2ColIntf.iData.kerWidth = '{default:'0};
				vIm2ColIntf.iData.startAddrX = '{default:'0};
				vIm2ColIntf.iData.startAddrY = '{default:'0};
				if(trans.iData.kerWidth > 0)
					begin
						for (int i = 0; i < trans.iData.kerWidth; i++)
							begin
								@(posedge vIm2ColIntf.clk);
							end
					end
				$display("[Driver ] transfer done and waited enough ");
				drivenNum ++;
			end
	endtask : drive


endclass : im2ColDrivClass