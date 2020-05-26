import macPckg::*;

timeunit 1ns;
timeprecision 100ps;
module mac_tb ();

	realtime clkPeriod = 10ns;
	logic    clk       = 0   ;
	logic    dv        = 0   ;

	tMultIn  iData;
	tMultOut oData;
	mac i_mac (.iClk(clk), .iData(iData), .oData(oData)); 


	logic signed [cDataBitW-1:0] a1 = -127;
	logic signed [  cDataBitW-1:0]       a2    = -127;
	logic signed [cWeightBitW-1:0]       w     = -127;
	logic signed [0:cMacLatency-1][15:0] mult1       ;
	logic signed [0:cMacLatency-1][15:0] mult2       ;

	enum {reset, boundaryCheck,random} state = reset;

	logic          [ 5:0] shftReg = 6'b000001;
	logic unsigned [0:31] counter = 0        ;

	always_ff @(posedge clk)
		begin
			case (state)
				reset :
					begin
						dv      <= "0";
						counter <= counter + 1;
						if(counter == 100) begin
							state <= boundaryCheck;
						end
					end

				boundaryCheck :
					begin
						dv      <= "1";
						shftReg <= {shftReg[4:0], shftReg[5]};
						if(shftReg == 6'b000001)
							begin
								a1 <= 127;
								a2 <= 127;
								w  <= 127;
							end
						else if (shftReg == 6'b000010)
							begin
								a1 <= 127;
								a2 <= 127;
								w  <= -127;
							end
						else if (shftReg == 6'b000100)
							begin
								a1 <= 127;
								a2 <= -127;
								w  <= -127;
							end
						else if (shftReg == 6'b001000)
							begin
								a1 <= -127;
								a2 <= -127;
								w  <= -127;
							end
						else if (shftReg == 6'b010000)
							begin
								a1 <= -127;
								a2 <= -127;
								w  <= 127;
							end
						else if (shftReg == 6'b100000)
							begin
								a1    <= -127;
								a2    <= 127;
								w     <= 127;
								state <= random;
							end
					end
				random :
					begin
						a1 <= $urandom_range(0,(2**cDataBitW-1));
						a2 <= $urandom_range(0,(2**cDataBitW-1));
						w  <= $urandom_range(0,(2**cWeightBitW-1));
					end
				default : /* default */;
			endcase
		end
	always_ff @(posedge clk)
		begin
			mult1[0] <= a1*w;
			mult2[0] <= a2*w;
			for (int i = 1; i < cMacLatency; i++) begin
				mult1[i] <= mult1[i-1];
				mult2[i] <= mult2[i-1];
			end
		end


	always_ff @(posedge clk) 
	begin 
		if(oData.dv)
		begin
			assert(mult1[cMacLatency-1] == oData.data1)  $display("data is correct for mult1");
			else $error("data is wrong mult1");

			assert(mult2[cMacLatency-1] == oData.data2)  $display("data is correct for mult2");
			else $error("data is wrong for mult2");
		end
		
		
	end
	



	always_ff @(posedge clk)
		begin
			iData.a1 <= a1;
			iData.a2 <= a2;
			iData.w  <= w;
			iData.dv <= dv;

			// iData.psum <= postAdd;


		end




	always
		begin
			#(clkPeriod/2) clk =~clk;
		end





endmodule