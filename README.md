# 🔐 AES Encryption Using Verilog 

## Overview

This FPGA project implements AES (Advanced Encryption Standard) encryption using Verilog. AES is a symmetric encryption algorithm widely used for securing sensitive data. The project provides support for **128-bit, 192-bit, or 256-bit** cipher keys and operates on a state matrix to perform encryption steps.

The project is designed to be modular, enabling easy integration into FPGA platforms. It can be synthesized and deployed using Quartus and is compatible with simulation tools like ModelSim for verification.

Additionally, the state matrix is hardcoded into the main module, which is editable, along with the three different key lengths (128, 192, and 256). The project features four switches: one to enable 128-bit encryption, another for 192-bit, one for 256-bit, and one for reset (registered into SW[0:3]). The clock is mimicked by KEY[0] on the FPGA.

Furthermore, the project includes an encoder to convert the last 1 byte to BCD and a decoder to display the last 3 digits of that BCD on a 7-segment screen (HEX0, HEX1, and HEX2).

## Features

- Supports AES encryption with key lengths of 128-bit, 192-bit, or 256-bit.
- Modular design with separate Verilog modules for each AES encryption step.
- Compatible with FPGA platforms.
- Synthesizable using Quartus.
- Simulation support with ModelSim.
- Hardcoded state matrix editable in the main module.
- Switches for enabling 128-bit, 192-bit, and 256-bit encryption, and for reset.
- Clock mimicked by FPGA KEY[0].
- Includes encoder to convert the last 1 byte to BCD.
- Decoder to display the last 3 digits of BCD on 7-segment screen (HEX0, HEX1, HEX2).

## Usage

### Setting Up the Project

1. Clone or download the project repository.
2. Open the project directory in Quartus.

### Configuring the AES Encryption Parameters

- Modify the encryption parameters (key length, input data, etc.) in the provided Verilog files as needed.

### Synthesizing and Deploying

1. Configure the target FPGA device in Quartus.
2. Compile the project to generate the FPGA configuration file.
3. Deploy the generated configuration file to the FPGA board.

### Simulation

1. Open the project directory in ModelSim.
2. Create simulation testbenches to verify the functionality of the AES encryption modules.
3. Run simulations to ensure correct operation.

- [Author Name](https://github.com/authorname)

## Acknowledgments

- Special thanks to [Name] for their contributions.
