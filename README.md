# Dead Code Elimination Examples

This project demonstrates different approaches to dead code elimination in C compilation using Clang.

## Setup

Simple test case with two functions (`add` and `sub`) where only `add` is called from `main`.

```c
/* lib.h */
int add(int a, int b);
int sub(int a, int b); /* unused, will this be eliminated? */

/* lib.c */
int add(int a, int b) { return a + b; }
int sub(int a, int b) { return a - b; }

/* main.c */
int main() { return add(1, 2); }
```


## Results Summary

| Method | Unoptimized (no -O2) | Optimized (-O2) |
|--------|---------------------|-----------------|
| **Basic** | ❌ Both symbols present | ❌ Both symbols present |
| **Header-only** | ✅ Only `_add` | ✅ Fully inlined |
| **LTO** | ✅ Only `_add` | ✅ Fully inlined |
| **Function-sections** | ✅ Only `_add` | ✅ Only `_add` |

## Key Findings

1. **Basic compilation** includes all object file symbols regardless of usage or optimization level
2. **Header-only libraries** (`static inline`) provide excellent dead code elimination with or without -O2
3. **Link-time optimization (LTO)** eliminates dead code effectively regardless of optimization level
4. **Function-sections with garbage collection** (`-ffunction-sections -fdata-sections -Wl,-dead_strip`) consistently eliminates dead code
5. **-O2 optimization alone** does not enable dead code elimination across compilation units
6. **Binary sizes** are very similar across all approaches, with dead code elimination providing minimal size benefits in this simple example
7. **Dead code elimination techniques work independently of -O2 optimization** - they rely on linkage visibility and linker capabilities rather than compiler optimization levels

## Commands Used

### Unoptimized Versions
- **Basic**: `clang -c lib.c && ar rcs libmylib.a lib.o && clang main.c libmylib.a`
- **Header-only**: `clang main.c` (no separate library)
- **LTO**: `clang -flto main.c lib.c` (with link-time optimization)
- **Function-sections**: `clang -ffunction-sections -fdata-sections -Wl,-dead_strip main.c libmylib.a`

### Optimized Versions (with -O2)
- **Basic**: `clang -O2 -c lib.c && ar rcs libmylib.a lib.o && clang -O2 main.c libmylib.a`
- **Header-only**: `clang -O2 main.c` (no separate library)
- **LTO**: `clang -O2 -flto main.c lib.c` (with link-time optimization)
- **Function-sections**: `clang -O2 -ffunction-sections -fdata-sections -Wl,-dead_strip main.c libmylib.a`

## Symbol Analysis Commands

Check for `add` and `sub` functions in compiled binaries:

```bash
# Basic method - using nm (name list)
nm build/main | grep -E "(add|sub)"

# Alternative - using objdump 
objdump -t build/main | grep -E "(add|sub)"

# Show all symbols (for debugging)
nm build/main

# Show disassembly to see actual code
objdump -d build/main | grep -A10 -B2 -E "(add|sub)"
```

### Example outputs:

**Basic compilation (no elimination):**
```
# Unoptimized
00000001000004b4 T _add
00000001000004bc T _sub

# Optimized (-O2)
0000000100000498 T _add
00000001000004a0 T _sub
```

**Header-only (dead code eliminated):**
```
# Unoptimized
00000001000004b4 t _add

# Optimized (-O2)
No add/sub symbols found
```

**LTO (dead code eliminated):**
```
# Unoptimized
00000001000004cc t _add

# Optimized (-O2)
No add/sub symbols found
```

**Function-sections (dead code eliminated):**
```
# Unoptimized
00000001000004b4 T _add

# Optimized (-O2)
0000000100000498 T _add
```

## Project Structure

### Unoptimized Versions (no -O2)
- **Main project**: Basic compilation with no optimization flags
- **header_only/**: Header-only library approach using `static inline`
- **link_time_optimization/**: Link-time optimization approach (no -O2)
- **function_sections/**: Function-level linking with garbage collection (no -O2)

### Optimized Versions (with -O2)
- **basic_optimized/**: Basic compilation with -O2 optimization
- **header_only_optimized/**: Header-only library with -O2 optimization
- **link_time_optimizations_optimized/**: LTO with -O2 optimization
- **function_sections_optimized/**: Function-sections with -O2 optimization

## Building

Each directory contains a `build.sh` script that compiles the code and checks for dead code elimination:

```bash
# Build all examples
./build.sh
cd header_only && ./build.sh
cd ../link_time_optimization && ./build.sh  
cd ../function_sections && ./build.sh
```
