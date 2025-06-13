cmake_minimum_required(VERSION 3.16)
project(function_sections_optimized_demo)

set(CMAKE_C_STANDARD 99)

# Create library
add_library(mylib lib.c)

# Create executable
add_executable(main main.c)
target_link_libraries(main mylib)

# Add function-sections, garbage collection flags, and O2 optimization
target_compile_options(mylib PRIVATE -O2 -ffunction-sections -fdata-sections)
target_compile_options(main PRIVATE -O2 -ffunction-sections -fdata-sections)

# Add linker flags for dead code elimination
if(APPLE)
    target_link_options(main PRIVATE -Wl,-dead_strip)
else()
    target_link_options(main PRIVATE -Wl,--gc-sections)
endif()