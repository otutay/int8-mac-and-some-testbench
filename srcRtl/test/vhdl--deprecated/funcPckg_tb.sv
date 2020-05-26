import funcPckg::*;


module funcPckg_tb ();
	integer          a;
	initial begin
		$display("fun pckg will be tested --- \n");
		$display("log2 of %d is %d",8,log2(8),$clog2(8+1));
		$display("some random numbers \n");
		for (int i = 0; i < 10000; i++) begin
			a =  $urandom_range(1,4096);
			assert(log2(a)== $clog2(a+1)) 
			else $error("its wrong for %d",a,log2(a),$clog2(a+1));
		end

	end


endmodule