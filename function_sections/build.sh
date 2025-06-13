#!/bin/bash
set -e

echo "Building function-sections version..."
mkdir -p build
clang -ffunction-sections -fdata-sections -c lib.c -o build/lib.o
ar rcs build/libmylib.a build/lib.o

# Use appropriate linker flags for macOS vs Linux
if [[ "$OSTYPE" == "darwin"* ]]; then
    clang -ffunction-sections -fdata-sections -Wl,-dead_strip main.c build/libmylib.a -o build/main
else
    clang -ffunction-sections -fdata-sections -Wl,--gc-sections main.c build/libmylib.a -o build/main
fi

echo "Checking symbols..."
nm build/main | grep -E "(add|sub)" || echo "No add/sub symbols found"