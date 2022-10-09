cmake_minimum_required(VERSION 3.23)

# This is a great resource for understanding what these different cmake calls do
# https://dominikberner.ch/cmake-interface-lib/

set(nerdfont-codepoints_VERSION 1.0.0)

project(nerdfont-codepoints
        VERSION ${nerdfont-codepoints_VERSION}
        DESCRIPTION "A header only library that exposes nerd font utf8 and utf16 codepoints"
        HOMEPAGE_URL "https://github.com/WesleyDucharme/nerdfont-codepoints"
        LANGUAGES CXX)

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# The INTERFACE here might be important. It makes our target a header only library that doesn't need to be compiled
add_library(nerdfont-codepoints INTERFACE include/NerdFont.h)
add_library(nerdfont-codepoints::nerdfont-codepoints ALIAS nerdfont-codepoints)

set_target_properties(nerdfont-codepoints PROPERTIES LINKER_LANGUAGE CXX)

target_compile_features(nerdfont-codepoints INTERFACE cxx_std_17)

# This generator expression allows us to provide different include directories based on the context this project is being used.
# For example, if this repo is added as a cmake subdirectory we make use of the `BUILD_INTERFACE`, giving the proper include dir.
#              Or, if it is an installed cmake library the include directory is the install location's include dir.
target_include_directories(nerdfont-codepoints
        INTERFACE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

configure_package_config_file(cmake/config.cmake.in
        ${CMAKE_CURRENT_BINARY_DIR}/nerdfont-codepoints-config.cmake
        INSTALL_DESTINATION ${CMAKE_INSTALL_DATADIR}/nerdfont-codepoints
        NO_SET_AND_CHECK_MACRO)

write_basic_package_version_file(
        ${CMAKE_CURRENT_BINARY_DIR}/nerdfont-codepoints-config-version.cmake
        VERSION ${nerdfont-codepoints_VERSION}
        COMPATIBILITY SameMajorVersion)

install(FILES
        ${CMAKE_CURRENT_BINARY_DIR}/nerdfont-codepoints-config.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/nerdfont-codepoints-config-version.cmake
        DESTINATION
        ${CMAKE_INSTALL_DATADIR}/nerdfont-codepoints)

install(TARGETS nerdfont-codepoints EXPORT nerdfont-codepoints-targets)
install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(EXPORT nerdfont-codepoints-targets
        NAMESPACE nerdfont-codepoints::
        DESTINATION ${CMAKE_INSTALL_DATADIR}/nerdfont-codepoints)