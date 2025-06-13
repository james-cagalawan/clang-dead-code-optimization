#!/bin/bash
set -e

echo "Building header-only optimized version (-O2)..."
mkdir -p build
clang -O2 main.c -o build/main

echo "Checking symbols..."
nm build/main | grep -E "(add|sub)" || echo "No add/sub symbols found"