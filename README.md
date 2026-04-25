<div align="center">

```
██████████████████████████████████████████████████████████
█                                                        █
█   ██████╗  ██████╗   ██╗████████╗    █████╗ ██╗  ██╗ █
█   ██╔══██╗██╔════╝   ██║╚══██╔══╝   ██╔══██╗██║  ██║ █
█   ╚█████╔╝██║  ███╗  ██║   ██║      ███████║██║  ██║ █
█   ██╔══██╗██║   ██║  ██║   ██║      ██╔══██║██║  ██║ █
█   ██████╔╝╚██████╔╝  ██║   ██║      ██║  ██║╚█████╔╝ █
█   ╚═════╝  ╚═════╝   ╚═╝   ╚═╝      ╚═╝  ╚═╝ ╚════╝  █
█                                                        █
█          4-Bit Arithmetic Logic Unit — V2              █
█                                                        █
██████████████████████████████████████████████████████████
```

<br/>

![Language](https://img.shields.io/badge/Language-SystemVerilog-blueviolet?style=for-the-badge&logo=v&logoColor=white)
![Architecture](https://img.shields.io/badge/Architecture-Parallel_Prefix-informational?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Complete-success?style=for-the-badge)
![Operations](https://img.shields.io/badge/Operations-16+-orange?style=for-the-badge)

<br/>

> *A high-performance 4-bit ALU built from the silicon up — featuring a Kogge-Stone adder, Wallace Tree multiplier, and non-restoring divider. Each module is hand-crafted in SystemVerilog with full testbench coverage.*

</div>

---

## Architecture Overview

```
              ┌────────────────────────────────────────────┐
              │              top_module.sv                 │
              │                                            │
  A[3:0] ───► │  ┌──────────────┐  ┌────────────────────┐ │
  B[3:0] ───► │  │ Arithmetic   │  │  Logic Unit        │ │ ──► Result[7:0]
  opcode ───► │  │ ┌──────────┐ │  │  AND / OR / XOR /  │ │
              │  │ │KS Adder  │ │  │  NOT               │ │ ──► Flags
              │  │ ├──────────┤ │  └────────────────────┘ │    Z C S V
              │  │ │Wallace   │ │  ┌────────────────────┐ │
              │  │ │Multiplier│ │  │  Barrel Shifter    │ │
              │  │ ├──────────┤ │  │  LSL / LSR / ASR   │ │
              │  │ │NR Divider│ │  └────────────────────┘ │
              │  └──────────────┘                          │
              └────────────────────────────────────────────┘
```

---

## Modules

| Module | Algorithm | Key Property |
|---|---|---|
| `kogge_stone_adder.sv` | Parallel Prefix (Kogge-Stone) | O(log n) depth — fastest carry propagation |
| `wallace_multiplier.sv` | Wallace Tree + CSA | Reduces partial products in parallel |
| `non_restoring_divider.sv` | Non-Restoring Division | No correction step needed per iteration |
| `logic_unit.sv` | Bitwise combinational | AND, OR, XOR, NOT |
| `barrel_shifter.sv` | Mux-based shift network | LSL, LSR, ASR in a single cycle |
| `flag_generator.sv` | Combinational logic | Zero, Carry, Sign, Overflow |
| `top_module.sv` | Structural integration | Connects all units via opcode MUX |

---

## Supported Operations

### Arithmetic
| Opcode | Operation | Module |
|---|---|---|
| `4'b0000` | Addition | Kogge-Stone Adder |
| `4'b0001` | Subtraction | Kogge-Stone Adder (B inverted + Cin=1) |
| `4'b0010` | Multiplication | Wallace Tree Multiplier |
| `4'b0011` | Division | Non-Restoring Divider |

### Logical
| Opcode | Operation |
|---|---|
| `4'b0100` | AND |
| `4'b0101` | OR |
| `4'b0110` | XOR |
| `4'b0111` | NOT (on A) |

### Shift
| Opcode | Operation |
|---|---|
| `4'b1000` | Logical Shift Left |
| `4'b1001` | Logical Shift Right |
| `4'b1010` | Arithmetic Shift Right |

### Status Flags
| Flag | Meaning | Condition |
|---|---|---|
| `Z` | Zero | Result == 0 |
| `C` | Carry | Carry-out from MSB |
| `S` | Sign | MSB of result is 1 |
| `V` | Overflow | Signed overflow detected |

---

## Design Highlights

### Kogge-Stone Adder
The adder uses a **parallel prefix** approach. Instead of waiting for carry to ripple bit-by-bit (O(n) delay), it computes all carries simultaneously in O(log n) gate stages — the same architecture used in modern CPUs.

```
Stage 0:  G0  P0  G1  P1  G2  P2  G3  P3   ← bit-level generate/propagate
Stage 1:  G0:0    G1:0    G2:1    G3:2       ← prefix combine
Stage 2:  G0:0    G1:0    G2:0    G3:0       ← all carries ready
```

### Wallace Tree Multiplier
Partial products are generated for all bit pairs, then **carry-save adders (CSA)** reduce them to two rows before a final fast adder. This eliminates the sequential addition bottleneck found in array multipliers.

### Non-Restoring Divider
Each iteration either **adds or subtracts** the divisor based on the partial remainder's sign — no conditional restore step. This leads to a regular, pipeline-friendly hardware structure.

---

## Testbenches

Every module ships with a dedicated testbench for isolated verification before top-level integration.

```
├── kogge_stone_adder_tb.sv    — corner cases: all-zeros, all-ones, carry chains
├── wallace_multiplier_tb.sv   — full 4×4 product space coverage
├── non_restoring_divider_tb.sv — includes divide-by-zero and remainder checks
├── logic_unit_tb.sv           — exhaustive truth table verification
├── barrel_shifter_tb.sv       — boundary shifts (0, 3, 4 positions)
└── top_module_tb.sv           — end-to-end opcode sweep with flag checking
```

---

## Getting Started

### Clone the Repository

```bash
git clone https://github.com/Bharadwajerram16/ALU-4BIT-V2.git
cd ALU-4BIT-V2
```

### Simulate (Vivado)

```bash
# Add all .sv files to the project
# Set top_module_tb.sv as the simulation top
# Run behavioral simulation
```

### Simulate (ModelSim / QuestaSim)

```bash
vlog *.sv
vsim top_module_tb
run -all
```

### Simulate (iverilog + GTKWave)

```bash
iverilog -g2012 -o alu_sim *.sv
vvp alu_sim
gtkwave dump.vcd
```

---

## Project Structure

```
ALU-4BIT-V2/
│
├── src/
│   ├── kogge_stone_adder.sv
│   ├── wallace_multiplier.sv
│   ├── non_restoring_divider.sv
│   ├── logic_unit.sv
│   ├── barrel_shifter.sv
│   ├── flag_generator.sv
│   └── top_module.sv
│
├── tb/
│   ├── kogge_stone_adder_tb.sv
│   ├── wallace_multiplier_tb.sv
│   ├── non_restoring_divider_tb.sv
│   ├── logic_unit_tb.sv
│   ├── barrel_shifter_tb.sv
│   └── top_module_tb.sv
│
└── README.md
```

---

## What's Next

This ALU is the computational core of a future RISC-V CPU implementation. Planned extensions:

- [ ] Register file (32×32-bit, 2R1W)
- [ ] Instruction decode unit
- [ ] Single-cycle RISC-V RV32I datapath
- [ ] Pipelined execution with hazard detection

---

## Tools

- **HDL**: SystemVerilog (IEEE 1800-2017)
- **Simulation**: ModelSim / Vivado / iverilog
- **Target**: FPGA / ASIC synthesis compatible

---

<div align="center">

Made with SystemVerilog — ECE @ VNR VJIET

</div>