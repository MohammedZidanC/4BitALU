# 4-bit ALU Verification

A beginner-friendly Verilog project implementing a 4-bit Arithmetic Logic Unit (ALU) with comprehensive verification testbench.

## Overview

This project demonstrates digital design fundamentals through a simple yet complete ALU implementation. The ALU performs basic arithmetic and logical operations on 4-bit operands.

## Project Structure

```
.
├── alu.v           # 4-bit ALU module implementation
├── tb_alu.v        # Comprehensive testbench with automatic verification
├── run_tests.py    # Python script for automated testing
├── run.sh          # Shell script for automated testing
└── README.md       # This file
```

## ALU Design

### Module Interface

```verilog
module alu (
    input  wire [3:0] a,          // 4-bit operand A
    input  wire [3:0] b,          // 4-bit operand B
    input  wire [1:0] opcode,     // 2-bit operation selector
    output reg  [3:0] result,     // 4-bit result
    output reg        zero_flag   // Flag: high when result is zero
);
```

### Operation Codes

| Opcode | Operation | Description |
|--------|-----------|-------------|
| `2'b00` | **ADD** | Addition: result = a + b |
| `2'b01` | **SUB** | Subtraction: result = a - b |
| `2'b10` | **AND** | Bitwise AND: result = a & b |
| `2'b11` | **OR**  | Bitwise OR: result = a \| b |

### Features

- **4-bit operands**: Supports values from 0 to 15
- **Combinational logic**: Results update immediately when inputs change
- **Zero flag**: Automatically set when result equals zero
- **Overflow handling**: Results wrap around (e.g., 15 + 1 = 0)

## Testbench

The testbench (`tb_alu.v`) provides comprehensive verification:

- **Directed tests**: 12 hand-crafted test cases covering edge cases
- **Random tests**: 20 randomly generated test cases for broader coverage
- **Automatic checking**: Self-checking mechanism compares actual vs expected results
- **Clear reporting**: Color-coded PASS/FAIL messages with detailed information
- **Test summary**: Final report showing total, passed, and failed tests

## Running the Simulation

### Prerequisites

Install a Verilog simulator. We recommend **Icarus Verilog** (open-source and beginner-friendly):

**Ubuntu/Debian:**
```bash
sudo apt-get install iverilog
```

**macOS:**
```bash
brew install icarus-verilog
```

**Windows:**
- Download from [Icarus Verilog for Windows](http://bleyer.org/icarus/)

### Method 1: Using Python Script (Recommended)

```bash
python3 run_tests.py
```

The script will:
1. Check for required files
2. Compile the Verilog sources
3. Run the simulation
4. Clean up temporary files

### Method 2: Using Shell Script

```bash
chmod +x run.sh
./run.sh
```

### Method 3: Manual Commands

```bash
# Compile
iverilog -o alu_sim alu.v tb_alu.v

# Run simulation
vvp alu_sim

# Clean up
rm alu_sim
```

## Expected Output

When you run the testbench, you should see output like this:

```
=================================================
    4-bit ALU Verification Testbench
=================================================

Starting Directed Tests...

[PASS] Test 1: ADD | A=5, B=3 | Expected=8, Got=8 | Zero=0
[PASS] Test 2: ADD | A=15, B=1 | Expected=0, Got=0 | Zero=1
...

-------------------------------------------------
Starting Random Tests...

[PASS] Test 13: SUB | A=12, B=7 | Expected=5, Got=5 | Zero=0
...

=================================================
           Test Summary
=================================================
Total Tests: 32
Passed:      32
Failed:      0

*** ALL TESTS PASSED! ***

=================================================
```

## Using with Other Simulators

### ModelSim/Questa

```bash
# Compile
vlog alu.v tb_alu.v

# Simulate
vsim -c -do "run -all; quit" tb_alu
```

### Vivado Simulator

```bash
# Compile
xvlog alu.v tb_alu.v

# Elaborate
xelab tb_alu -s tb_alu_sim

# Simulate
xsim tb_alu_sim -runall
```

## Understanding the Results

- **PASS**: The ALU produced the correct result for the given inputs
- **FAIL**: The ALU's output didn't match the expected value (indicates a bug)
- **Zero flag**: Shows whether the result is zero (useful for conditional operations)

## Extending the Project

Here are some ideas to expand your learning:

1. **Add more operations**: Implement XOR, NOT, shift operations
2. **Increase bit width**: Change from 4-bit to 8-bit or 16-bit
3. **Add status flags**: Carry, overflow, negative flags
4. **Pipeline the design**: Add registers for multi-cycle operation
5. **Create a waveform viewer**: Use GTKWave to visualize signals

## Troubleshooting

**"Command not found" errors:**
- Make sure Icarus Verilog is installed and in your PATH

**Compilation errors:**
- Check that all files are in the same directory
- Verify you're using the correct file names

**All tests fail:**
- Check the ALU logic in `alu.v`
- Verify the opcode definitions match between ALU and testbench

## Learning Resources

- [Verilog Tutorial](https://www.asic-world.com/verilog/veritut.html)
- [Digital Design Basics](https://www.nandland.com/)
- [Icarus Verilog Documentation](http://iverilog.icarus.com/documentation.html)

## License

This is a educational project. Feel free to use and modify for learning purposes.

---

**Happy Learning! 🚀**
