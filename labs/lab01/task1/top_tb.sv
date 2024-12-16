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

    // dumping the content of register file into the memory 
    integer fd; // File descriptor
    integer i;  // Loop index

    initial begin
        // Open a new file for writing (overwrite if exists)
        fd = $fopen("regfile.dump", "w");
        if (fd == 0) begin
            $display("Error: Unable to open file regfile.dump.");
            $finish;
        end
    end

    always @(posedge clk) begin
            // I am dumping all the 4 registers data at every posedge of clk
            for (i = 0; i < 4; i = i + 1) begin
                $fdisplay(fd, "Reg[%0d] = %h", i, DUT.reg_file_inst.reg_file[i]); // Dump register contents
            end
    end

    // Close file at simulation end
    initial begin
        #1000; // We can always adjust this simulation end time
        $fclose(fd);
        $display("Register file contents dumped to regfile.dump");
        $finish;
    end

endmodule : top_tb  