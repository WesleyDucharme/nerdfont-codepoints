from conan import ConanFile
from conan.tools.cmake import CMakeToolchain, CMake, cmake_layout


class NerdfontCodepointsConan(ConanFile):
    name = "nerdfont-codepoints"
    version = "0.0.1"
    settings = "os", "compiler", "build_type", "arch"

    def export_sources(self):
        self.copy("../CMakeLists.txt")
        self.copy("*.h", "include", "../include")
        self.copy("../cmake/config.cmake.in", "cmake")

    def layout(self):
        cmake_layout(self)

    def generate(self):
        tc = CMakeToolchain(self)
        tc.generate()

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

    def package(self):
        cmake = CMake(self)
        cmake.install()
