#!/bin/bash
set -e

echo "Building header-only version..."
mkdir -p build
clang main.c -o build/main

echo "Checking symbols..."
nm build/main | grep -E "(add|sub)" || echo "No add/sub symbols found"