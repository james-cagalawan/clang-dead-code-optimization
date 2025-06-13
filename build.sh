#!/bin/bash
set -e

echo "Building main project (no optimization)..."
mkdir -p build
clang -c lib.c -o build/lib.o
ar rcs build/libmylib.a build/lib.o
clang main.c build/libmylib.a -o build/main

echo "Checking symbols..."
nm build/main | grep -E "(add|sub)" || echo "No add/sub symbols found"