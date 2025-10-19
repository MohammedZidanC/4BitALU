module alu (
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire [1:0] opcode,
    output reg  [3:0] result,
    output reg        zero_flag
);

    localparam ADD = 2'b00;
    localparam SUB = 2'b01;
    localparam AND = 2'b10;
    localparam OR  = 2'b11;

    always @(*) begin
        case (opcode)
            ADD: result = a + b;
            SUB: result = a - b;
            AND: result = a & b;
            OR:  result = a | b;
            default: result = 4'b0000;
        endcase

        zero_flag = (result == 4'b0000);
    end

endmodule
