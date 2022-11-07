cmake_minimum_required(VERSION 3.15)

set(nerdfont-codepoints_VERSION 0.0.1)

project(nerdfont-codepoints
        VERSION ${nerdfont-codepoints_VERSION}
        DESCRIPTION "A header only library that exposes nerd font utf8 and utf16 codepoints"
        HOMEPAGE_URL "https://github.com/WesleyDucharme/nerdfont-codepoints"
        LANGUAGES CXX)

add_library(nerdfont-codepoints INTERFACE ./include/NerdFont.h)

target_compile_features(nerdfont-codepoints INTERFACE cxx_std_17)
target_include_directories(nerdfont-codepoints
        INTERFACE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

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