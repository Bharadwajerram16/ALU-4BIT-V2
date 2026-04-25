<div align="center">

```
 _  _      ____  ___  _____      _   _     _   _
| || |    | __ )|_ _||_   _|    / \ | |   | | | |
| || |_   |  _ \ | |   | |     / _ \| |   | | | |
|__   _|  | |_) || |   | |    / ___ \ |___| |_| |
   |_|    |____/|___|  |_|   /_/   \_\____|\___/
```

<br/>

![Language](https://img.shields.io/badge/Language-SystemVerilog-blueviolet?style=for-the-badge)
![Adder](https://img.shields.io/badge/Adder-Kogge--Stone-informational?style=for-the-badge)
![Multiplier](https://img.shields.io/badge/Multiplier-Wallace_Tree-orange?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Complete-success?style=for-the-badge)

<br/>

> *A 4-bit ALU built in SystemVerilog featuring a Kogge-Stone adder, Wallace Tree multiplier, non-restoring divider, barrel shifter, and logic unit — all integrated under a single clocked top module with full flag generation.*

</div>

---

## Architecture

```
Inputs: a[3:0], b[3:0], op[2:0], op1[2:0], sel_shift[1:0], mode_shift[1:0], dir, clk, rst

         ┌──────────────────────────────────────────────────────┐
         │                   top_module                         │
         │                                                      │
         │  op == 3'b000 / 3'b110 ──► kogge_stone_adder         │
         │                            (c=1 when op==3'b110)     │
         │  op == 3'b001           ──► logic_unit  (via op1)    │ ──► result[7:0]
         │  op == 3'b010           ──► barrel_shifter           │ ──► Z, C, S, V
         │  op == 3'b011           ──► wallace_multiplier       │ ──► done
         │  op == 3'b100           ──► non_restoring_divider (Q)│
         │  op == 3'b101           ──► non_restoring_divider (R)│
         │                                                      │
         └──────────────────────────────────────────────────────┘
```

---

## Opcode Table

| `op[2:0]` | Operation | Module | Output |
|---|---|---|---|
| `3'b000` | Addition | `kogge_stone_adder` | 4-bit, zero-extended to 8 |
| `3'b110` | Subtraction | `kogge_stone_adder` (cin=1) | 4-bit, zero-extended to 8 |
| `3'b001` | Logic operation | `logic_unit` (via `op1`) | 4-bit, zero-extended to 8 |
| `3'b010` | Shift operation | `barrel_shifter` (via `sel_shift`, `mode_shift`, `dir`) | 4-bit, zero-extended to 8 |
| `3'b011` | Multiplication | `wallace_multiplier` | Full 8-bit product |
| `3'b100` | Division — Quotient | `non_restoring_divider` | 4-bit, zero-extended to 8 |
| `3'b101` | Division — Remainder | `non_restoring_divider` | 4-bit, zero-extended to 8 |

> Subtraction reuses the adder: `c = (op == 3'b110)` drives `cin`, and B is inverted externally, giving A + ~B + 1 = A − B in two's complement.

---

## Module Reference

| Instance | Module File | Role |
|---|---|---|
| `ksa` | `kogge_stone_adder.sv` | Parallel prefix adder — add and subtract |
| `lu1` | `logic_unit.sv` | Bitwise ops selected by `op1[2:0]` |
| `sh1` | `barrel_shifter.sv` | Shift controlled by `sel_shift`, `mode_shift`, `dir` |
| `mul1` | `wallace_multipler.sv` | 4×4 multiplication, full 8-bit result |
| `div1` | `non_restoring_divider.sv` | Clocked divider — asserts `div_done` on completion |
| `fg1` | `flag_generator.sv` | Generates Z, C, S, V from `result[3:0]`, `cout`, `cin_msb` |

---

## Port Reference

### Inputs

| Port | Width | Description |
|---|---|---|
| `clk` | 1 | Clock — used by the non-restoring divider |
| `rst` | 1 | Reset — used by the non-restoring divider |
| `a` | 4 | Operand A |
| `b` | 4 | Operand B |
| `op` | 3 | Main operation select |
| `op1` | 3 | Logic unit sub-operation select |
| `sel_shift` | 2 | Shift amount |
| `mode_shift` | 2 | Shift mode |
| `dir` | 1 | Shift direction |

### Outputs

| Port | Width | Description |
|---|---|---|
| `result` | 8 | Operation result |
| `Z` | 1 | Zero flag |
| `C` | 1 | Carry flag |
| `S` | 1 | Sign flag |
| `V` | 1 | Overflow flag |
| `done` | 1 | Result valid — always `1` except during division |

---

## Flag Generation

Flags are driven by `flag_generator` using `result[3:0]`, `cout`, and `cin_msb`.

| Flag | Condition |
|---|---|
| `Z` — Zero | `result[3:0] == 4'b0000` |
| `C` — Carry | `cout` from the adder |
| `S` — Sign | `result[3]` |
| `V` — Overflow | `cout ^ cin_msb` |

`cin_msb` is computed in the top module as:

```systemverilog
assign cin_msb = a[3] ^ (b[3] ^ c) ^ sum[3];
```

---

## `done` Signal

| `op` | `done` source |
|---|---|
| `3'b100` — quotient | `div_done` from `non_restoring_divider` |
| `3'b101` — remainder | `div_done` from `non_restoring_divider` |
| All others | Tied to `1'b1` — result is combinational and immediate |

---

## Testbenches

| File | What it tests |
|---|---|
| `kogge_stone_adder_tb.sv` | Add, subtract — carry, overflow, zero edge cases |
| `wallace_multiplier_tb.sv` | Full 4×4 product space |
| `non_restoring_divider_tb.sv` | Quotient, remainder, `done` timing |
| `logic_unit_tb.sv` | All `op1` sub-operations |
| `barrel_shifter_tb.sv` | All shift modes and directions |
| `top_module_tb.sv` | End-to-end opcode sweep with flag verification |

---

## How to Run

**Vivado**
```
1. Create project and add all .sv source files
2. Set top_module_tb.sv as simulation top
3. Run Behavioral Simulation
```

**ModelSim / QuestaSim**
```bash
vlog *.sv
vsim top_module_tb
run -all
```

**iverilog + GTKWave**
```bash
iverilog -g2012 -o alu_sim *.sv
vvp alu_sim
gtkwave dump.vcd
```

---

## Repository Structure

```
ALU-4BIT-V2/
│
├── src/
│   ├── kogge_stone_adder.sv
│   ├── wallace_multipler.sv
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

This ALU is the first major building block toward a RISC-V CPU implementation:

- [ ] Register file — 16×4-bit, 2R1W
- [ ] Instruction decode unit
- [ ] Single-cycle RISC-V datapath
- [ ] Pipelined execution with hazard detection

---

## Clone

```bash
git clone https://github.com/Bharadwajerram16/ALU-4BIT-V2.git
cd ALU-4BIT-V2
```

---

<div align="center">

**Author:** E. Bharadwaj &nbsp;|&nbsp; ECE @ VNR VJIET &nbsp;|&nbsp; April 2026

</div>