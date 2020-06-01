import im2ColEnvClassPckg::*;

program im2ColTest(im2ColIntf intf);
	im2ColEnvClass env;

	initial begin 
		env = new(intf);
		env.testNum = 10;
		env.run();
	end

endprogram: im2ColTest