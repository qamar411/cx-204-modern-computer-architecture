module imem #(
    parameter IMEM_DEPTH = 64
)(
    input logic [$clog2(IMEM_DEPTH) - 1: 0]addr,
    output logic [7:0] inst
);

    // instruction memory 
    logic [7:0] imem [ 0 : IMEM_DEPTH];


    
    // initialize instruction memory 
    initial $readmemb("/home/it/Documents/cx-204/labs/lab01/task1/support_files/fib_im.mem",imem);

    $readmemb("address/file_name",imem)

    // read inst combinatinally ( continous assignment)
    assign inst = imem[addr];




endmodule : imem    