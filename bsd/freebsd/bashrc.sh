#!/usr/bin/env bash
# Usage: source ./bashrc.sh

usage()
{
    cat <<EOF
Commands:
  cdinstall
  download
  prepare
  run
  ssh2bsd
EOF
}

download()
{
    wget https://download.freebsd.org/releases/amd64/amd64/ISO-IMAGES/14.2/FreeBSD-14.2-RELEASE-amd64-bootonly.iso.xz
    wget https://download.freebsd.org/releases/amd64/amd64/ISO-IMAGES/14.2/CHECKSUM.SHA256-FreeBSD-14.2-RELEASE-amd64
    cat CHECKSUM.SHA256-FreeBSD-14.2-RELEASE-amd64 
    sha256sum FreeBSD-14.2-RELEASE-amd64-bootonly.iso.xz 
    xz -d ./FreeBSD-14.2-RELEASE-amd64-bootonly.iso.xz 
}

prepare()
{
    [ which qemu-system-x86_64 ] || sudo apt install qemu-system
    [ -e disk.qcow ] || qemu-img create -f qcow2 disk.qcow 5G
    echo if you want to use kvm:
    echo   execute sudo usermod -aG kvm ${USER}
    echo   and newgrp kvm or login again
}

cdinstall()
{
    qemu-system-x86_64 -enable-kvm -m 1024 -boot order=d \
		       -cdrom FreeBSD-14.2-RELEASE-amd64-bootonly.iso \
		       ./fbsd-16g.qcow2
}

run()
{
    qemu-system-x86_64 -enable-kvm -m 1024 -boot order=c \
		       ./fbsd-16g.qcow2 \
		       -net nic -net user,hostfwd=tcp::2222-:22
}

ssh2bsd()
{
    local username
    username=$(whoami)
    ssh -p 2222 ${username}@localhost
}

usage
