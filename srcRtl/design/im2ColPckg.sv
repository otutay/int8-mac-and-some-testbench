
package im2ColPckg;
	import funcPckg::*;
	import ramPckg::*;
	import tilePckg::*;

	parameter cMaxKerWidth = 4;

	typedef enum {idle,calc} tIm2ColState;

	typedef struct packed {
		logic [log2(cMaxKerWidth-1)-1:0] kerWidth  ;
		logic [   log2(cNumOfRam-1)-1:0] startAddrX;
		logic [   log2(cRamDepth-1)-1:0] startAddrY;
		logic                            dv        ;

	} tIm2ColIn;

	typedef logic [(cMaxKerWidth-1):0][log2(cNumOfRam-1)-1:0] tAddrArray;


	typedef struct packed{
		tAddrArray                    xAddr;
		logic [log2(cRamDepth-1)-1:0] yAddr;
		logic [   (cMaxKerWidth-1):0] dv   ;
		logic                         done ;
	}tIm2ColOut;

	function automatic logic[(cMaxKerWidth-1):0] validAddr (logic [log2(cMaxKerWidth-1)-1:0] kerWidth);
		logic [(cMaxKerWidth-1):0] retVal;
		case (kerWidth)
			2'b00 : retVal = 4'b1000;
			2'b01 : retVal = 4'b1100;
			2'b10 : retVal = 4'b1110;
			2'b11 : retVal = 4'b1111;
		endcase
		return retVal;
	endfunction : validAddr

	function automatic tAddrArray calcAddr (logic [   log2(cNumOfRam-1)-1:0] startAddrX);
		tAddrArray xLocArray;
		for (int i = 0; i < cMaxKerWidth; i++) begin
			xLocArray[i] = startAddrX + i;
		end
		
		return xLocArray;
		// tIm2ColOut retVal;
		// retVal.yAddr = addr.startAddrY + 1;
		// for (int i = 0; i < cMaxKerWidth; i++) begin
		// 	retVal.xAddr[i] = addr.startAddrX + i;
		// end

		// retVal.dv = validAddr(addr.kerWidth);
		// return retVal;
	endfunction : calcAddr



endpackage:im2ColPckg