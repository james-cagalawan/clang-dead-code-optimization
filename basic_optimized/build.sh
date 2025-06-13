#!/bin/bash
set -e

echo "Building basic optimized project (-O2)..."
mkdir -p build
clang -O2 -c lib.c -o build/lib.o
ar rcs build/libmylib.a build/lib.o
clang -O2 main.c build/libmylib.a -o build/main

echo "Checking symbols..."
nm build/main | grep -E "(add|sub)" || echo "No add/sub symbols found"