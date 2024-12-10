#!/usr/bin/env bash

set -euo pipefail

run()
{
  bochs -q -f bochsrc.386bsd  
}

run


