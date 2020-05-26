// `include "environment.sv"
import environmentPckg::*;
program test(memIntf intf);
	environment env;

	initial begin
		env = new(intf);

		env.gen.repeatCount = 10;

		env.run();
	end

endprogram: test