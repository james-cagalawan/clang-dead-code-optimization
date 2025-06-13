cmake_minimum_required(VERSION 3.16)
project(basic_optimized_demo)

set(CMAKE_C_STANDARD 99)

# Create library
add_library(mylib lib.c)

# Create executable
add_executable(main main.c)
target_link_libraries(main mylib)

# Add compiler flags for O2 optimization
target_compile_options(mylib PRIVATE -O2)
target_compile_options(main PRIVATE -O2)