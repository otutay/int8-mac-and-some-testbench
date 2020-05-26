

package macPckg;
	parameter integer cDataBitW    = 8 ;
	parameter integer cWeightBitW  = 8 ;
	// parameter integer cSumBitW     = 48;
	parameter integer cMultOutBitW = 48;
	parameter integer cPreAddBitW  = 27;
	parameter integer cMult2BitW   = 18;
	parameter integer cMacLatency = 6;


	typedef struct packed {
	   logic signed [cDataBitW-1:0] a1;
	   logic signed [cDataBitW-1:0] a2;
	   logic signed [cWeightBitW-1:0] w;
	   // logic signed [cSumBitW-1:0] pSum;
	   // logic is8Bit;
	   logic dv;
	} tMultIn;
	// const tMultIn cMultIn = {{cDataBitW{1'b0}},{cDataBitW{1'b0}},{cWeightBitW{1'b0}},{cSumBitW{1'b0}},"0","0"};
	const tMultIn cMultIn = {{cDataBitW{1'b0}},{cDataBitW{1'b0}},{cWeightBitW{1'b0}},"0"};


	typedef struct packed{
	   // logic signed [cMultOutBitW-1:0] data;
	   logic signed [(cDataBitW + cWeightBitW-1):0] data1;
	   logic signed [(cDataBitW + cWeightBitW-1):0] data2;
	   logic dv;
	}tMultOut;
	const tMultOut cMultOut = {{(cDataBitW + cWeightBitW){1'b0}},{(cDataBitW + cWeightBitW){1'b0}},"0"};


endpackage : macPckg