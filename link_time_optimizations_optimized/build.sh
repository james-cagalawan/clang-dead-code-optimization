#!/bin/bash
set -e

echo "Building LTO optimized version (-O2 + LTO)..."
mkdir -p build
clang -O2 -flto -c lib.c -o build/lib.o
ar rcs build/libmylib.a build/lib.o
clang -O2 -flto main.c build/libmylib.a -o build/main

echo "Checking symbols..."
nm build/main | grep -E "(add|sub)" || echo "No add/sub symbols found"