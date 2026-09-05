# Pipelined-RISCV-CPU — Roadmap

Ceiling of this project: **a CPU I designed, fabricated in real silicon, on a board on my desk.**
Between here and there are seven rungs. Each one is independently demoable and independently
impressive — that's the point. One platform, many outputs.

**Active target: rungs 1–4.** Rung 5 is a stretch. Rungs 6–7 are the horizon, worth knowing, not building now.

---

## Rung 0 — where we are  ⟵ *current*

5-stage pipeline in simulation that runs a single ADD.

- [x] ALU (ADD/SUB/AND/OR)
- [x] Register file (32×32, async read, sync write, x0 = 0)
- [x] Control unit decode for R-type / LW / SW
- [x] IF/ID, ID/EX, EX/MEM, MEM/WB pipeline registers in `rtl/riscv_top.v`
- [ ] **Blocker:** port mismatches — `riscv_top` wires `control_unit` as `.instruction/.alu_op`
      but the module declares `opcode/funct3/funct7/alu_control`; same for `alu`'s `.alu_op` vs `alu_control`
- [ ] Empty placeholder files: `rtl/if_stage.v`, `rtl/id_stage.v`, `rtl/wb_stage.v`, `rtl/pipeline.v`, `tb/riscv_tb.v`

## Rung 1 — a CPU that runs real programs (complete RV32I)

The "it's a real processor now" milestone.

- [ ] Fix the port mismatches; get `tb/top_tb.v` actually passing
- [ ] Program counter + instruction memory (stop feeding `instruction` from the testbench)
- [ ] Immediate generation (I/S/B/U/J formats)
- [ ] Full base integer set: arithmetic, loads/stores, branches, jumps

## Rung 2 — hazard handling

The intellectual heart of pipelining, and the single most-asked CPU interview topic.

- [ ] Data hazards: forwarding / bypassing (EX→EX, MEM→EX)
- [ ] Load-use stall
- [ ] Control hazards: branch flush / resolution

## Rung 3 — run compiled C, pass the suite

- [ ] Compile a C program with the RISC-V GCC toolchain, load it, run it correctly
- [ ] Pass the official RISC-V compliance tests

## Rung 4 — put it on an FPGA  ⟵ *finish line for the active target*

The credibility inflection point. Most students never leave the simulator.

- [ ] Synthesize the RTL onto a real board (Tang Nano = cheap; iCEBreaker / Xilinx / Altera for more room)
- [ ] Blink an LED, talk over UART

## Rung 5 — make it capable  *(stretch: a free summer)*

- [ ] Caches
- [ ] CSRs + interrupt/trap handling
- [ ] M extension (hardware multiply/divide)
- [ ] MAC / custom-instruction accelerator — the accelerator idea lives here, naturally
- [ ] **Peak:** boot Linux on my own core (needs virtual memory + the privileged spec)

## Rung 6 — microarchitecture depth  *(horizon)*

Superscalar, then out-of-order with register renaming. Reference cores: BOOM, CVA6.
This is literally the job at ARM / SiFive / Apple silicon.

## Rung 7 — the sky: actual silicon  *(horizon, but genuinely reachable)*

Synthesis → place-and-route → GDSII → fab. Tiny Tapeout's shared-wafer shuttle model makes this
~10–50× cheaper than buying wafer space: roughly **$250 for chip + PCB**, tiles ~$50 each,
fabricated at SkyWater, ~7-month turnaround, and the physical chip comes back mounted on a
demoboard. Beyond this is only commercial fabless scale — company territory, not solo.

---

## Why rungs 1–4

GATE/GRE prep owns the calendar. A complete, hazard-handled RV32I core running compiled C on an
FPGA is already a top-few-percent student project and covers essentially every CPU question a
company or fellowship will ask. The rest is a talking point, not a to-do list — knowing the full
arc ("I've built through FPGA; the natural continuation is caches, then tapeout via a shuttle")
signals understanding of the whole stack on its own.
