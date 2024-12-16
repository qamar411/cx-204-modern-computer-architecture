typedef enum logic [1:0] {
    ADD,
    SUB,
    AND,
    OR
} alu_op_t;

module alu #(
    parameter ALU_WIDTH = 16
)(
    input logic [ALU_WIDTH - 1:0] op1, 
    input logic [ALU_WIDTH - 1:0] op2,
    input logic [1:0] alu_op,
    output logic [ALU_WIDTH - 1:0] alu_out
);

    alu_op_t alu_op_e;
//    assign alu_op_e = alu_op; // this won't work
    assign alu_op_e = alu_op_t'(alu_op); // type cast
    always @(*) begin 
        case(alu_op) 
            ADD: alu_out = op1 + op2;
            SUB: alu_out = op1 - op2;
            AND: alu_out = op1 & op2;
            OR: alu_out  = op1 | op2;
        endcase
    end

endmodule 