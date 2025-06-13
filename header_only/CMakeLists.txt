cmake_minimum_required(VERSION 3.16)
project(header_only_demo)

set(CMAKE_C_STANDARD 99)

# Create executable (no separate library needed)
add_executable(main main.c)
# target_compile_options(main PRIVATE -O2)