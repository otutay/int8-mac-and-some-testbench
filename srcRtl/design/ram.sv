import ramPckg::*;
import funcPckg::*;

module ram #(parameter tPerfEnum cRamPerformance = highPerf) (
	input  logic       iClk, // Clock
	input  tRamInData  iRam,
	output tRamOutData oRam
);

	alias clk = iClk;
	// in data
	logic [        cRamWidth-1:0] data = {cRamWidth{1'b0}}        ;
	logic [log2(cRamDepth-1)-1:0] addr = {log2(cRamDepth-1){1'b0}};
	logic                         en   = {1'b0}                   ;
	logic                         wEn  = {1'b0}                   ;

	// data buffer
	logic [        cRamWidth-1:0] ramData = {cRamWidth{1'b0}}        ;
	logic [log2(cRamDepth-1)-1:0] ramAddr = {log2(cRamDepth-1){1'b0}};
	logic                         ramEn   = {1'b0}                   ;

	// ram array
	tRamArray ramBlock;

	//outBuffer
	// logic [        cRamWidth-1:0] dataOutBuf = {cRamWidth{1'b0}}        ;
	// logic [log2(cRamDepth-1)-1:0] addrOutBuf = {log2(cRamDepth-1){1'b0}};
	// logic                         dvBuf      = 1'b0                     ;

	// out Data
	logic [        cRamWidth-1:0] dataOut = {cRamWidth{1'b0}}        ;
	logic [log2(cRamDepth-1)-1:0] addrOut = {log2(cRamDepth-1){1'b0}};
	logic                         dv      = 1'b0                     ;

	always_ff @(posedge clk) begin : inputRegPro
		data <= iRam.data;
		addr <= iRam.addr;
		en   <= iRam.en;
		wEn  <= iRam.wEn;
	end


	always_ff @(posedge clk) begin : readWritePro
		if (en) begin
			if (wEn)
				begin
					ramBlock[addr] <= data;
				end
			else
				begin
					ramData <= ramBlock[addr];
				end
		end
	end


	always_ff @(posedge clk) begin : dataRegPro
		ramAddr <= addr ;
		ramEn   <= en & (~wEn);
	end


	generate
		if (cRamPerformance == lowLatency) begin
			always_comb
				begin
					dataOut <= ramData;
					addrOut <= ramAddr;
					dv      <= ramEn;
				end


			end
			if (cRamPerformance == highPerf) begin
				always_ff @(posedge clk) begin
					// dataOut <= ramData;
					addrOut <= ramAddr;
					dataOut <= ramData;
					dv      <= ramEn;
				end

			end

		endgenerate

		always_comb
		begin
			oRam.data <= dataOut;
			oRam.addr <= addrOut;
			oRam.dv   <= dv;
		end

endmodule: ram