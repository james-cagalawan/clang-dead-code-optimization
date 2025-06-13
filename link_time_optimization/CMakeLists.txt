cmake_minimum_required(VERSION 3.16)
project(lto_demo)

set(CMAKE_C_STANDARD 99)

# Enable Link Time Optimization
set(CMAKE_INTERPROCEDURAL_OPTIMIZATION ON)

# Create library
add_library(mylib lib.c)

# Create executable
add_executable(main main.c)
target_link_libraries(main mylib)

# No optimization flags - using default debug build