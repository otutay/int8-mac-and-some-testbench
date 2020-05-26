import macTestEnvClassPckg::*;

program macTest(macIntf intf);
	macTestEnvClass env;

	initial begin
		env = new(intf);
		env.setRandomTestSize(10);
		env.run();
	end

endprogram : macTest