#!/usr/bin/env bash

gen()
{
  [ -e main.c ] && { echo "main.c exists!"; return 2; }
  [ -e makefile ] && { echo "makefile exists!"; return 3; }
  cat > main.c <<EOF
#include <stdio.h>
int main(int argc, char* argv[])
{
  printf("Hello\n");
}
EOF
  cat > makefile <<EOF
hello: main.c
	gcc -o hello main.c
EOF
  return 0
}

cleanup()
{
  rm -f main.c makefile hello
}

help()
{
  echo "make && ./hello"
}
