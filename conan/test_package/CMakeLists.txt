cmake_minimum_required(VERSION 3.15)
project(PackageTest CXX)

find_package(nerdfont-codepoints CONFIG REQUIRED)

add_executable(example src/example.cpp)
target_link_libraries(example nerdfont-codepoints::nerdfont-codepoints)
