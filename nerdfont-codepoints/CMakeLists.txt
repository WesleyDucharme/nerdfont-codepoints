cmake_minimum_required(VERSION 3.23)

set(nerdfont_codepoints_VERSION 1.0.0)

project(nerdfont_codepoints
        VERSION ${nerdfont_codepoints_VERSION}
        DESCRIPTION "A header only library that exposes nerd font utf8 and utf16 codepoints"
        HOMEPAGE_URL "https://github.com/WesleyDucharme/nerdfont-codepoints"
        LANGUAGES CXX)

include(CMakePackageConfigHelpers)

add_library(nerdfont_codepoints include/NerdFont.h)
add_library(nerdfont_codepoints::nerdfont_codepoints ALIAS nerdfont_codepoints)

target_compile_features(nerdfont_codepoints PUBLIC cxx_std_17)
target_include_directories(nerdfont_codepoints
        PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

configure_package_config_file(cmake/config.cmake.in
        ${CMAKE_CURRENT_BINARY_DIR}/nerdfont_codepoints-config.cmake
        INSTALL_DESTINATION ${CMAKE_INSTALL_DATADIR}/nerdfont_codepoints
        NO_SET_AND_CHECK_MACRO)
write_basic_package_version_file(
        ${CMAKE_CURRENT_BINARY_DIR}/nerdfont_codepoints-config-version.cmake
        VERSION ${nerdfont_codepoints_VERSION}
        COMPATIBILITY SameMajorVersion)

install(FILES
        ${CMAKE_CURRENT_BINARY_DIR}/nerdfont_codepoints-config.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/nerdfont_codepoints-config-version.cmake
        DESTINATION
        ${CMAKE_INSTALL_DATADIR}/nerdfont_codepoints)

install(TARGETS nerdfont_codepoints EXPORT nerdfont_codepoints-targets)
install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(EXPORT nerdfont_codepoints-targets
        NAMESPACE nerdfont_codepoints::
        DESTINATION ${CMAKE_INSTALL_DATADIR}/nerdfont_codepoints)