import macPckg::*;

class macScoreClass;

	mailbox                                    inDataMail ;
	mailbox                                    outDataMail;
	tMultIn                                    inData     ;
	tMultOut                                   outData    ;
	logic signed [(cDataBitW+cWeightBitW-1):0] dummy1     ;
	logic signed [(cDataBitW+cWeightBitW-1):0] dummy2     ;

	function new (mailbox inData,outData);
		this.inDataMail = inData;
		this.outDataMail = outData;
	endfunction : new



	task main();
		while(outDataMail.num() > 0)
			begin
				// $display("->>>>>>>>>>>>>>>>> inMailbox %d outMailbox %d",inDataMail.num(),outDataMail.num());
				inDataMail.get(inData);
				dummy1 = inData.a1 * inData.w;
				dummy2 = inData.a2 * inData.w;
				outDataMail.get(outData);
				if(dummy1 == outData.data1 & dummy2 == outData.data2 )
					$display("data are correct a1 %d , a2 %d w1 %d result1 %d,result2 %d",inData.a1,inData.a2,inData.w,outData.data1,outData.data2 );
				else
					$display("data are WRONG a1 %d , a2 %d w1 %d result1 %d,result2 %d, calc1 %d,calc2 %d",inData.a1,inData.a2,inData.w,outData.data1,outData.data1,dummy1,dummy2 );
			end
	endtask : main

endclass : macScoreClass
