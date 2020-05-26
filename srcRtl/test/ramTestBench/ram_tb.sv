
import ramPckg::*;
import  funcPckg::*;
timeunit 1ns;
timeprecision 100ps;

module ram_tb ();
	realtime clkPeriod = 10ns;
	logic    clk       = 0   ;

	// alias iClk=clk;
	logic       iRst                ;
	tRamInData  iRam = {cRamInData} ;
	tRamOutData oRam = {cRamOutData};


	ram i_ram (.iClk(clk), .iRam(iRam), .oRam(oRam));

	enum {writeFirst,readFirst,read,write,randomize} state = writeFirst;

	tRamArray             ourRam              ;
	logic unsigned [31:0] counter = {32{1'b0}};

	logic [log2(cRamDepth-1)-1:0] addr     = 0 ;
	logic [        cRamWidth-1:0] data     = 10;
	logic [                  5:0] shftReg  = 0 ;
	logic                         indicate     ;
	// logic increase = "0";


	always_ff @(posedge clk) begin
		counter <= counter + 1;
	end

	always_ff @(posedge clk) begin : StatePro
		indicate <= "0";
		case (state)
			writeFirst :
				begin
					addr         <= addr + 1;
					data         <= data + 1;
					iRam.data    <= data;
					iRam.addr    <= addr;
					ourRam[addr] <= data;
					iRam.wEn     <= "1";
					iRam.en      <= "1";
					if(counter == 31)
						begin
							state <= readFirst;
							addr  <= 0;
							// iRam.wEn <= "0";
							// iRam.en  <= "0";
						end
				end
			readFirst :
				begin
					iRam.addr <= addr;
					iRam.en   <= "1";
					iRam.wEn  <= "0";
					addr      <= addr + 1;
					if(counter == 63)
						begin
							state = randomize;
						end

				end
			randomize :
				begin
					addr     <= $urandom_range(0,31);
					data     <= $urandom_range(0,255);
					iRam.en  <= "0";
					iRam.wEn <= "0";
					state    <= write;
				end
			write :
				begin
					iRam.addr    <= addr;
					iRam.data    <= data;
					ourRam[addr] <= data;
					iRam.en      <= "1";
					iRam.wEn     <= "1";
					state        <= read;
					indicate     <= "1";

				end
			read :
				begin
					if(indicate)
						begin
							iRam.en  <= "1";
							iRam.wEn <= "0";
						end
					else
						begin
							iRam.en  <= "0";
							iRam.wEn <= "0";
						end
					if(shftReg[5])
						begin
							state <= randomize;

						end
				end
			default : /* default */;
		endcase
	end

	always_ff @(posedge clk) begin : comparePro
		if (oRam.dv)
			begin
				assert(oRam.data == ourRam[oRam.addr]) $display("data is correct at address %d",oRam.addr);
				else $error("data is wrong at address %d",oRam.addr);
			end
	end

	always_ff @(posedge clk) begin : datalatencyPro
		shftReg <= {shftReg[4:0],indicate};
	end


	initial begin
		// state = writeFirst;
		// counter = 0;
		$display("------------------------------------------- \n");
		$display("first write a mon increasing to ram \n");
		$display("Second read and compare \n");
		$display("then write random read random \n");
		$display("do it as simulation goes \n");

	end

	always begin
		#(clkPeriod/2) clk =~clk;
	end

endmodule