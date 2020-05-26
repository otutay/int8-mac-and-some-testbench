
import macPckg::*;

module mac (
	input           iClk , // Clock
	input  tMultIn  iData,
	output tMultOut oData
);
	alias                                      clk       = iClk;
	logic signed [            cPreAddBitW-1:0] ai1             ;
	logic signed [            cPreAddBitW-1:0] di1             ;
	logic signed [             cMult2BitW-1:0] bi1             ;
	logic signed [             cMult2BitW-1:0] bi2             ;
	logic signed [            cPreAddBitW-1:0] preAdd          ;
	logic signed [           cMultOutBitW-1:0] mult            ;
	logic signed [(cWeightBitW+cDataBitW+1):0] out1            ;
	logic signed [(cWeightBitW+cDataBitW+1):0] out2            ;
	logic        [            cMacLatency-1:0] dvShftReg       ;
	// logic signed [cMultOutBitW-1:0] postAddi1       ;
	// logic signed [cMultOutBitW-1:0] postAddi2       ;
	// logic signed [cMultOutBitW-1:0] postAddi3       ;
	// logic signed [cMultOutBitW-1:0] macOut          ;


	always_ff @(posedge clk)
		begin
			ai1 <= {iData.a1[cDataBitW-1],iData.a1,{(cPreAddBitW-cDataBitW-1){1'b0}}};
			di1 <= {{(cPreAddBitW-cDataBitW){iData.a2[cDataBitW-1]}},iData.a2};

			bi1 <= {{(cMult2BitW-cWeightBitW){iData.w[cWeightBitW-1]}},iData.w};
			bi2 <= bi1;

			// postAddi1 <= iData.pSum;
			// postAddi2 <= postAddi1;
			// postAddi3 <= postAddi2;
		end


	always_ff @(posedge clk)
		begin
			preAdd <= ai1 + di1;
			mult   <= preAdd*bi2;

			out2 <= mult[(cWeightBitW + cDataBitW-1):0];
			out1 <= mult[35:18] + mult[17];


		end

	always_ff @(posedge clk)
		begin
			oData. data1  <= out1 ;
			oData. data2  <= out2 ;
			oData.dv <= dvShftReg[cMacLatency-2];
		end


	always_ff @(posedge clk)
		begin
			dvShftReg <= {dvShftReg[cMacLatency-2:0], iData.dv} ;
		end




endmodule : mac