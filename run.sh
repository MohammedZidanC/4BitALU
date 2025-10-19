#!/bin/bash

echo ""
echo "============================================================"
echo "  4-bit ALU Verification - Automated Test Runner"
echo "============================================================"
echo ""

if [ ! -f "alu.v" ]; then
    echo "❌ Error: alu.v not found in current directory"
    exit 1
fi

if [ ! -f "tb_alu.v" ]; then
    echo "❌ Error: tb_alu.v not found in current directory"
    exit 1
fi

echo "✓ Design files found"
echo ""

echo "============================================================"
echo "Step 1: Compiling Verilog files"
echo "============================================================"
echo "Running: iverilog -o alu_sim alu.v tb_alu.v"
echo ""

iverilog -o alu_sim alu.v tb_alu.v

if [ $? -ne 0 ]; then
    echo ""
    echo "❌ Error: Compilation failed"
    exit 1
fi

echo ""
echo "✓ Compilation successful"
echo ""

echo "============================================================"
echo "Step 2: Running simulation"
echo "============================================================"
echo "Running: vvp alu_sim"
echo ""

vvp alu_sim

if [ $? -ne 0 ]; then
    echo ""
    echo "❌ Error: Simulation failed"
    rm -f alu_sim
    exit 1
fi

echo ""
echo "============================================================"
echo "  Simulation Complete!"
echo "============================================================"
echo ""

rm -f alu_sim
echo "✓ Cleaned up simulation files"
echo ""
