#!/usr/bin/env bash
set -euo pipefail

# Verify that the hello_rv64 ELF binary exists and is a valid RISC-V 64-bit ELF.
binary="build/tests/muntjac-gcc-toolchain/hello_rv64/hello"
if [[ ! -f "$binary" ]]; then
  echo "Error: binary $binary not found" >&2
  exit 1
fi

echo "Verifying $binary..."
file -L "$binary" | grep -E "ELF 64-bit.*RISC-V"
echo "PASS: $binary is a valid RISC-V 64-bit ELF binary."
