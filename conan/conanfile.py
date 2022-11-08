from conan import ConanFile
from conan.tools.cmake import CMakeToolchain, CMake, cmake_layout
from conan.tools.files import load, copy
import re


class NerdfontCodepointsConan(ConanFile):
    name = "nerdfont-codepoints"
    settings = "os", "compiler", "build_type", "arch"

    def set_version(self):
        content = load(self, "CMakeLists.txt")
        self.version = re.search(rf"set\({self.name}_VERSION (.*)\)", content).group(1)

    def export_sources(self):
        copy(self, "CMakeLists.txt", f"{self.recipe_folder}/../", self.export_sources_folder)
        copy(self, "*.h", f"{self.recipe_folder}/../include", f"{self.export_sources_folder}/include")
        copy(self, "*", f"{self.recipe_folder}/../cmake", f"{self.export_sources_folder}/cmake")

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
