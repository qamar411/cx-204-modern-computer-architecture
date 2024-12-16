module top(
    input logic clk,
    input logic reset_n
);
    // set parameters to control size, range, depth of units
    parameter PROG_VALUE = 3;
    parameter IMEM_DEPTH = 4;
    parameter ALU_WIDTH = 16;
    parameter REGF_WIDTH = 16;

    // program counter
    logic [$clog2(PROG_VALUE) - 1:0] current_pc;
    n_bit_counter #(
        .PROG_VALUE(PROG_VALUE)
    ) program_counter_inst (
        .clk(clk),
        .reset_n(reset_n),
        .count(current_pc)
    );

    // instruction memory
    logic [7:0] inst; 
    imem #(
        .IMEM_DEPTH(IMEM_DEPTH)
    ) imem_inst (
        .addr(current_pc),
        .inst(inst)
    );

    // Use simple and clear names
    // to different parts of inst  
    logic [1:0] rs1, rs2, rd, opcode; 

    assign opcode = inst[1:0]; // Explicit cast still necessary for safety
    assign rs1    = inst[3:2];
    assign rs2    = inst[5:4];
    assign rd     = inst[7:6];

    // Register file 
    logic [ALU_WIDTH  - 1:0] alu_result;
    logic [REGF_WIDTH - 1:0] op1;
    logic [REGF_WIDTH - 1:0] op2;
    
    reg_file #(
        .REGF_WIDTH(REGF_WIDTH)
    ) reg_file_inst (
        .clk(clk),
        .reset_n(reset_n),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .data_in(alu_result),
        .op1(op1),
        .op2(op2)
    );

    // ALU 
    alu #(
        .ALU_WIDTH(ALU_WIDTH)
    ) alu_inst (
        .op1(op1),
        .op2(op2),
        .alu_op(opcode), 
        .alu_out(alu_result)
    );

endmodule : top
