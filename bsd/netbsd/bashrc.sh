#!/usr/bin/env bash
# Usage: source ./bashrc.sh

usage()
{
    cat <<EOF
Commands:
  cdinstall
  prepare
  run
  ssh2bsd
EOF
}

prepare()
{
    [ which qemu-system-x86_64 ] || sudo apt install qemu-system
    [ -e disk.qcow ] || qemu-img create -f qcow2 disk.qcow 5G
}

cdinstall()
{
    qemu-system-x86_64 -m 1024M -boot menu=on -cdrom ./NetBSD-10.0-amd64.iso \
		       -drive file=disk.qcow,format=qcow2
}

run()
{
    qemu-system-x86_64 -m 1024M -drive file=disk.qcow,format=qcow2 \
		       -net nic -net user,ipv6=off,hostfwd=tcp::2222-:22
}

ssh2bsd()
{
    local username
    username=$(whoami)
    ssh -p 2222 ${username}@localhost
}

usage
