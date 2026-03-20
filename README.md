# 🧠 Multi-Cycle RV32I Processor (Verilog)

A Verilog implementation of a **Multi-Cycle RISC-V (RV32I) Processor** designed using a datapath + control unit architecture.
The processor executes instructions over multiple clock cycles, improving hardware efficiency.

---

## 🚀 Features

- Multi-cycle CPU design
- FSM-based control unit
- Separate datapath and control unit
- Simulation using **Icarus Verilog + GTKWave**

---

## 🏗️ Architecture

The processor consists of:

**Datapath**
- Program Counter (PC)
- Register File
- ALU
- Memory
- Intermediate Registers (A, B, ALUOut, Data)

**Control Unit**
- Finite State Machine (FSM)
- Generates control signals for each stage

📷 
<img width="1430" height="1006" alt="Screenshot 2026-03-15 163755" src="https://github.com/user-attachments/assets/148b0472-99e1-43d9-9307-bb0b53ab28b0" />


---

## 🔄 Instruction Flow

Each instruction is executed in multiple steps:

1. **Fetch** — Instruction is loaded from memory
2. **Decode** — Registers are read
3. **Execute** — ALU performs operation
4. **Memory** — Read/Write (for LW/SW)
5. **Write Back** — Result stored in register

---

## 🧪 Test Program
```assembly
addi x1, x0, 5
addi x2, x0, 10
add  x3, x1, x2
sw   x3, 0(x0)
lw   x4, 0(x0)
```

### ✅ Expected Output

| Register | Value |
| :--- | :--- |
| x1 | 5 |
| x2 | 10 |
| x3 | 15 |
| x4 | 15 |

---

## 📊 Simulation

<img width="1667" height="957" alt="waves" src="https://github.com/user-attachments/assets/6a3a5943-972d-4bba-bbf8-6d2a48ff447e" />


---

## 🛠️ How to Run

### 1. Compile
```bash
iverilog -o cpu *.v
```

### 2. Run Simulation
```bash
vvp cpu
```

### 3. View Waveform
```bash
gtkwave cpu.vcd
```

---

## 📂 Project Structure
```
├── datapath.v
├── control_unit.v
├── mainFSM.v
├── alu_decoder.v
├── instr_decoder.v
├── regfile.v
├── main_memory.v
├── tb_cpu.v
└── cpu.vcd
```

---

## 💡 Key Learnings

- Multi-cycle design reduces hardware complexity
- FSM control is crucial for correct execution
- Timing of control signals matters
- Correct datapath routing is critical (e.g., memory write data)

---

## 👤 Author

**Thejesh Varma**
B.Tech – Electronics and Communication Engineering
Rajiv Gandhi University of Knowledge Technologies

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).
