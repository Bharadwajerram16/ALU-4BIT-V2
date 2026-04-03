# 4-Bit ALU Design using Verilog

This project implements a **4-bit Arithmetic Logic Unit (ALU)** using Verilog HDL.  
It includes multiple arithmetic, logical, shifting, and advanced operations along with optimized hardware modules.

---

## Features

- Arithmetic Operations
  - Addition (Kogge-Stone Adder)
  - Subtraction
  - Multiplication (Wallace Tree Multiplier)
  - Division (Non-Restoring Divider)

- Logical Operations
  - AND
  - OR
  - XOR
  - NOT

- Shift Operations
  - Logical Shift Left
  - Logical Shift Right
  - Arithmetic Shift

- Flag Generation
  - Zero (Z)
  - Carry (C)
  - Sign (S)
  - Overflow (V)

---

## Modules Used

| Module | Description |
|------|------------|
| `kogge_stone_adder.sv` | High-speed parallel prefix adder |
| `wallace_multiplier.sv` | Fast multiplication using Wallace tree |
| `non_restoring_divider.sv` | Division using non-restoring algorithm |
| `logic_unit.sv` | Performs logical operations |
| `barrel_shifter.sv` | Performs shift operations |
| `flag_generator.sv` | Generates status flags |
| `top_module.sv` | Integrates all modules into ALU |

---

## Testbenches

Each module has its own testbench:

- `kogge_stone_adder_tb.sv`
- `wallace_multiplier_tb.sv`
- `non_restoring_divider_tb.sv`
- `logic_unit_tb.sv`
- `barrel_shifter_tb.sv`
- `top_module_tb.sv`

---

## How It Works

1. Inputs are given to the **top module**
2. Based on control signals:
   - Arithmetic / Logical / Shift operations are selected
3. Corresponding module processes the data
4. Output is generated along with status flags

---

## Tools Used

- Verilog HDL
- Simulation Tool (ModelSim / Vivado / any simulator)

---

## How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/Bharadwajerram16/ALU_4Bit.git
   cd ALU_4Bit