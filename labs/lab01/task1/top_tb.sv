module top_tb; 

    logic clk;
    logic reset_n;

    top DUT (
        .*
    );

    // generate clk 
    initial clk = 0;
    always #5 clk = ~clk;

    // generate reset 
    initial begin 
        reset_n = 0;          // raise reset (it's active low)
        repeat(2) @(negedge clk);  // wait for some time
        reset_n = 1;          // drop reset;
    end


    // Intializing the instruction memory 
    initial $readmemb("/home/it/Documents/cx-204/labs/lab01/task1/support_files/fib_im.mem",DUT.imem_inst.imem);

    // initialize register file, make sure to do that after reset 
    initial begin 
        wait(reset_n); // wait until reset drops;
        $readmemb("/home/it/Documents/cx-204/labs/lab01/task1/support_files/fib_rf.mem",DUT.reg_file_inst.reg_file);
    end
endmodule : top_tb  