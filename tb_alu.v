`timescale 1ns / 1ps

module tb_alu;

    reg  [3:0] a;
    reg  [3:0] b;
    reg  [1:0] opcode;
    wire [3:0] result;
    wire       zero_flag;

    integer passed;
    integer failed;
    integer test_count;

    alu uut (
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result),
        .zero_flag(zero_flag)
    );

    task check_result;
        input [3:0] expected;
        input [1:0] op;
        input [3:0] operand_a;
        input [3:0] operand_b;
        reg [63:0] op_name;
        begin
            test_count = test_count + 1;

            case (op)
                2'b00: op_name = "ADD";
                2'b01: op_name = "SUB";
                2'b10: op_name = "AND";
                2'b11: op_name = "OR ";
            endcase

            if (result === expected) begin
                $display("[PASS] Test %0d: %s | A=%d, B=%d | Expected=%d, Got=%d | Zero=%b",
                         test_count, op_name, operand_a, operand_b, expected, result, zero_flag);
                passed = passed + 1;
            end else begin
                $display("[FAIL] Test %0d: %s | A=%d, B=%d | Expected=%d, Got=%d | Zero=%b",
                         test_count, op_name, operand_a, operand_b, expected, result, zero_flag);
                failed = failed + 1;
            end
        end
    endtask

    initial begin
        passed = 0;
        failed = 0;
        test_count = 0;

        $display("\n=================================================");
        $display("    4-bit ALU Verification Testbench");
        $display("=================================================\n");

        $display("Starting Directed Tests...\n");

        opcode = 2'b00; a = 4'd5;  b = 4'd3;  #10; check_result(4'd8, opcode, a, b);
        opcode = 2'b00; a = 4'd15; b = 4'd1;  #10; check_result(4'd0, opcode, a, b);
        opcode = 2'b00; a = 4'd7;  b = 4'd7;  #10; check_result(4'd14, opcode, a, b);

        opcode = 2'b01; a = 4'd10; b = 4'd3;  #10; check_result(4'd7, opcode, a, b);
        opcode = 2'b01; a = 4'd5;  b = 4'd5;  #10; check_result(4'd0, opcode, a, b);
        opcode = 2'b01; a = 4'd2;  b = 4'd8;  #10; check_result(4'd10, opcode, a, b);

        opcode = 2'b10; a = 4'b1111; b = 4'b1010; #10; check_result(4'b1010, opcode, a, b);
        opcode = 2'b10; a = 4'b1100; b = 4'b0011; #10; check_result(4'b0000, opcode, a, b);
        opcode = 2'b10; a = 4'b1010; b = 4'b1010; #10; check_result(4'b1010, opcode, a, b);

        opcode = 2'b11; a = 4'b1010; b = 4'b0101; #10; check_result(4'b1111, opcode, a, b);
        opcode = 2'b11; a = 4'b0000; b = 4'b0000; #10; check_result(4'b0000, opcode, a, b);
        opcode = 2'b11; a = 4'b1100; b = 4'b0011; #10; check_result(4'b1111, opcode, a, b);

        $display("\n-------------------------------------------------");
        $display("Starting Random Tests...\n");

        repeat (20) begin
            a = $random % 16;
            b = $random % 16;
            opcode = $random % 4;
            #10;

            case (opcode)
                2'b00: check_result((a + b) & 4'hF, opcode, a, b);
                2'b01: check_result((a - b) & 4'hF, opcode, a, b);
                2'b10: check_result(a & b, opcode, a, b);
                2'b11: check_result(a | b, opcode, a, b);
            endcase
        end

        $display("\n=================================================");
        $display("           Test Summary");
        $display("=================================================");
        $display("Total Tests: %0d", test_count);
        $display("Passed:      %0d", passed);
        $display("Failed:      %0d", failed);

        if (failed == 0) begin
            $display("\n*** ALL TESTS PASSED! ***\n");
        end else begin
            $display("\n*** SOME TESTS FAILED ***\n");
        end
        $display("=================================================\n");

        $finish;
    end

endmodule
