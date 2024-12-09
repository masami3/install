#!/usr/bin/env bash

set -euo pipefail

prepare()
{
  [ -d MSDOS ] || git clone https://github.com/microsoft/MS-DOS
  [ -d VZEditor ] || git clone https://github.com/vcraftjp/VZEditor.git
  [ -d src ] || ln -s MS-DOS/v4.0/src .
}

build()
{
  [ -e VZEditor/SRC/VZ.MA- ] || cp -p VZEditor/SRC/VZ.MAK VZEditor/SRC/VZ.MA-
  rm -f VZEditor/SRC/VZ.MAK
  cat VZEditor/SRC/VZ.MA- | dos2unix | sed -e 's/obj\\$/obj \\/' | unix2dos > VZEditor/SRC/VZ.MAK

  touch VZEditor/SRC/DUMMY
  cat > SETUP.BAT <<EOF
echo off
set path=%PATH%;C:\SRC\TOOLS
set ASM=M
set LNK=
set MASM=/dUS
EOF
  unix2dos SETUP.BAT

  echo "Execute the following commands in dosbox-x"
  cat <<EOF
mount c ${PWD}
c:
setup.bat
cd vzeditor\src
nmake -f vz.mak
lz.bat
EOF
}

prepare
build


