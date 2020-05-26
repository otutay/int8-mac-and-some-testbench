package funcPckg;

	function automatic integer log2(integer depth);
		integer temp = depth;
		integer retVal = 1;
		while(temp>1)
			begin
				retVal = retVal + 1;
				temp = temp/2;
			end
		return retVal;

		endfunction : log2


	endpackage:funcPckg