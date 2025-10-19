#!/usr/bin/env python3

import subprocess
import sys
import os

def run_command(cmd, description):
    print(f"\n{'='*60}")
    print(f"{description}")
    print(f"{'='*60}")
    print(f"Running: {' '.join(cmd)}\n")

    result = subprocess.run(cmd, capture_output=False, text=True)

    if result.returncode != 0:
        print(f"\n❌ Error: {description} failed with return code {result.returncode}")
        sys.exit(1)

    return result

def main():
    print("\n" + "="*60)
    print("  4-bit ALU Verification - Automated Test Runner")
    print("="*60)

    if not os.path.exists('alu.v'):
        print("\n❌ Error: alu.v not found in current directory")
        sys.exit(1)

    if not os.path.exists('tb_alu.v'):
        print("\n❌ Error: tb_alu.v not found in current directory")
        sys.exit(1)

    print("\n✓ Design files found")

    run_command(
        ['iverilog', '-o', 'alu_sim', 'alu.v', 'tb_alu.v'],
        "Step 1: Compiling Verilog files"
    )

    print("\n✓ Compilation successful")

    run_command(
        ['vvp', 'alu_sim'],
        "Step 2: Running simulation"
    )

    print("\n" + "="*60)
    print("  Simulation Complete!")
    print("="*60 + "\n")

    if os.path.exists('alu_sim'):
        os.remove('alu_sim')
        print("✓ Cleaned up simulation files\n")

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n\n⚠ Interrupted by user")
        sys.exit(1)
    except FileNotFoundError as e:
        print(f"\n❌ Error: Required tool not found - {e}")
        print("\nPlease install Icarus Verilog:")
        print("  Ubuntu/Debian: sudo apt-get install iverilog")
        print("  macOS:         brew install icarus-verilog")
        print("  Windows:       Download from http://bleyer.org/icarus/\n")
        sys.exit(1)
