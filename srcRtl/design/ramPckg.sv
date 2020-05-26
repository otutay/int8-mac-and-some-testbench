
package ramPckg;
	import  funcPckg::*;

	parameter integer cRamWidth = 8 ;
	parameter integer cRamDepth = 32;


	typedef enum  {highPerf,lowLatency} tPerfEnum;

	typedef logic [0:cRamDepth-1][cRamWidth-1:0] tRamArray;

	typedef struct packed{
		logic [log2(cRamDepth-1)-1:0] addr;
		logic [        cRamWidth-1:0] data;
		logic                         wEn ;
		logic                         en  ;
	} tRamInData;
	// const tRamInData cRamInData = {0,0,"0","0"};

	typedef struct packed{
		logic [log2(cRamDepth-1)-1:0]   addr;
		logic [        cRamWidth-1:0]   data;
		logic                           dv  ;
	} tRamOutData;
	// const tRamOutData cRamOutData = {0,0,"0"};



endpackage : ramPckg