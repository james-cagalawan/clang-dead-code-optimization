cmake_minimum_required(VERSION 3.16)
project(function_sections_demo)

set(CMAKE_C_STANDARD 99)

# Create library
add_library(mylib lib.c)

# Create executable
add_executable(main main.c)
target_link_libraries(main mylib)

# Add function-sections and garbage collection flags
target_compile_options(mylib PRIVATE -ffunction-sections -fdata-sections)
target_compile_options(main PRIVATE -ffunction-sections -fdata-sections)

# Add linker flags for dead code elimination
if(APPLE)
    target_link_options(main PRIVATE -Wl,-dead_strip)
else()
    target_link_options(main PRIVATE -Wl,--gc-sections)
endif()