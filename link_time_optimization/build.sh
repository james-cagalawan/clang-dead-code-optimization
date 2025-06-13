#!/bin/bash
set -e

echo "Building LTO version (simplified)..."
mkdir -p build
clang -flto main.c lib.c -o build/main

echo "Checking symbols..."
nm build/main | grep -E "(add|sub)" || echo "No add/sub symbols found"