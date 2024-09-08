#!/usr/bin/env bash
# Usage: source ./install.sh

set -euo pipefail

require()
{
    sudo apt-get install build-essential libffi-dev git pkg-config
    sudo apt-get install gcc-arm-none-eabi libnewlib-arm-none-eabi
    sudo apt install qemu-system-arm
    # for riscv
    sudo apt install gcc-riscv64-unknown-elf
    sudo apt install picolibc-riscv64-unknown-elf
}

clone()
{
    cd ${HOME}/work
    mkdir -p micropython
    micropython/
    mkdir 01
    cd 01
    git clone https://github.com/masami3/micropython
    cd micropython/
    git remote -v
    git checkout -b dev-branch
}

build_cross()
{
    cd ${HOME}/work/micropython/01/micropython/mpy-cross
    make
}

build_unix()
{
    cd ${HOME}/work/micropython/01/micropython/ports/unix
    make submodules
    make
    ./build-standard/micropython -c "import sys; print(sys.version)"

}

build_qemu()
{
    cd ${HOME}/work/micropython/01/micropython/ports/qemu
    make
    make repl
}

build_qemu_riscv()
{
    cd ${HOME}/work/micropython/01/micropython/ports/qemu
    make BOARD=VIRT_RV32
    make BOARD=VIRT_RV32 repl
}
