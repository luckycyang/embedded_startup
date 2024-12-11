cmake_minimum_required(VERSION 3.21)
set(CMAKE_EXPORT_COMPILE_COMMANDS true)

# set you target here
set(ZIG_TARGET "thumb-freestanding-eabi")
include(${CMAKE_CURRENT_LIST_DIR}/zig-cross/cmake/zig-toolchain.cmake)

project(embedded_startup)

add_executable(${PROJECT_NAME})

target_sources(${PROJECT_NAME} PRIVATE src/main.c startup/startup.c)

target_compile_options(${PROJECT_NAME} PRIVATE -mcpu=cortex_m3)

target_link_options(${PROJECT_NAME} PRIVATE
                    -T${CMAKE_CURRENT_SOURCE_DIR}/startup/linker.ld)
