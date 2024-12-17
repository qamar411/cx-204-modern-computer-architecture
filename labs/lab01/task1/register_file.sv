module reg_file #(
    parameter REGF_WIDTH = 16
) (
    input logic clk, 
    input logic reset_n,
    input logic [1:0] rs1,
    input logic [1:0] rs2,
    input logic [1:0] rd,
    input logic [REGF_WIDTH - 1:0] data_in,
    output logic [REGF_WIDTH - 1:0] op1, 
    output logic [REGF_WIDTH - 1:0] op2
);

    // register file here 
    logic [REGF_WIDTH - 1:0] reg_file [0:3];

    assign reg_file[0] = 0;

    
    always @(posedge clk, negedge reset_n) begin 
        if(~reset_n) begin 
            for(int i = 1; i<4; i = i+1) begin 
                reg_file[i] <= 0;
            end
        end else begin // currently there is no write enable, always write
            reg_file[rd] <= data_in;
        end
    end

    assign op1 = reg_file[rs1];
    
    assign op2 = reg_file[rs2];


endmodule : reg_file
