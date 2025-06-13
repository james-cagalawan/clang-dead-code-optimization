cmake_minimum_required(VERSION 3.16)
project(lto_optimized_demo)

set(CMAKE_C_STANDARD 99)

# Create library
add_library(mylib lib.c)

# Create executable
add_executable(main main.c)
target_link_libraries(main mylib)

# Add LTO and O2 optimization flags
target_compile_options(mylib PRIVATE -O2 -flto)
target_compile_options(main PRIVATE -O2 -flto)
target_link_options(main PRIVATE -flto)