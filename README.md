# PYNQ-Z2 LED Demo Project

Built using the Xilinx toolchain/toolsuite.  
Should also be portable to other ZYNQ XC7Z020 compatible boards.

## Purpose

What does it do?  
Wires up various switches, buttons and LEDs on the PYNQ-Z2 board (ZYNQ XC7Z020).  
Demonstrates the basics of creating a project using scripting.  
The I/O connections are hardwired in the FPGA project.  
Once deployed, pressing a button on the PYNQ-Z2 board will light the corresponding LED.

To understand how this works - start by reading the project [documentation](./app/docs/docs.md).  

## Recommended Folder Structure

All version-controlled assets should be checked out in an "app" sub-folder.  
Projects are then created parallel to this folder via scripts.  
Generated artifacts are not version-controlled.

## Getting Started

```sh
# create and build PL/vivado project
./app/pynq_z2_hw/scripts/create.sh
./app/pynq_z2_hw/scripts/build.sh

# optional - program bitstream
# connect up device to serial port
./app/pynq_z2_hw/scripts/program-bitstream.sh
# press push-buttons

# create and build PS/vitis project
./app/pynq_z2_fw/scripts/create.sh
./app/pynq_z2_fw/scripts/build.sh

# copy BOOT.bin to bootable SD card - e.g. D:
./app/pynq_z2_fw/scripts/cp-boot-bin.sh /d

# eject SD card, insert into device and power on
# press push-buttons
```

## Manifest

After running the project scripts to create and build the PL and PS projects, the folder structure should look like this:  

```text
app                     <-- version controlled app
├── docs
│   ├── docs.md
│   └── images
├── pynq_z2_env.sh      <-- project environment settings
├── pynq_z2_fw          <-- vitis project generator
│   └── scripts         <-- scripts to create, build, ... vitis project
├── pynq_z2_hw          <-- vivado project generator
│   ├── constraints
│   ├── NOTES.md
│   ├── scripts         <-- scripts to create, build, ... vivado project
│   └── src             <-- hardware platform source files
├── vhdl                <-- hardware application source files
│   └── src
└── xilinx_env.tcl      <-- project environment settings mapped to tcl variables
├── logs                <- generated logs from create/build scripts
├── pynq_z2_fw          <- generated vitis project
├── pynq_z2_hw          <- generated vivado project
└── README.md
```

## Prerequisites

- PYNQ-Z2 developer board
- Xilinx toolchain (vivado, vitis, ...)
