import im2ColPckg::*;
import ramPckg::*;

class im2ColTransClass;
	rand tIm2ColIn iData;
	tIm2ColOut oData;

	// start of kernel needs to be smaller then max length not to overflow
	constraint  startAddrXCons{ iData.startAddrX < (cNumOfRam - iData.kerWidth - 1)};
	constraint  startAddrYCons{ iData.startAddrY < (cNumOfRam - iData.kerWidth - 1)};

endclass : im2ColTransClas