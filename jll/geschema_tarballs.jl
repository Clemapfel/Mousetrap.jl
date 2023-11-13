# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder, Pkg

name = "libmousetrap"
version = v"0.3.0"

# Collection of sources required to complete build
sources = [
    GitSource("https://github.com/Clemapfel/mousetrap.git", "ffa28d0bd569118320a6bb063286edfb35fc0429"),
    GitSource("https://github.com/Clemapfel/mousetrap_julia_binding.git", "6b838ea238e118d694ffc1b3a1e0225441c8cfb3")
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
echo -e "[binaries]\ncmake='/usr/bin/cmake'" >> cmake_toolchain_patch.ini
cd mousetrap
mkdir ${prefix}/share/licenses/mousetrap
cp LICENSE ${prefix}/share/licenses/mousetrap/LICENSE
meson setup build --cross-file=$MESON_TARGET_TOOLCHAIN --cross-file=../cmake_toolchain_patch.ini
meson install -C build
rm cmake_toolchain_patch.ini
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = filter(p -> nbits(p) == 64 && Sys.iswindows(p), supported_platforms())

# The products that we will ensure are always built
products = [
    LibraryProduct("libmousetrap", :mousetrap),
    #LibraryProduct("libmousetrap_julia_binding", :mousetrap_julia_binding),
    FileProduct("")
]

x11_platforms = filter(p -> Sys.islinux(p) || Sys.isfreebsd(p), platforms)
# Dependencies that must be installed before this package can be built
dependencies = [
    Dependency("GLEW_jll")
    Dependency("GLU_jll"; platforms = x11_platforms)
    Dependency("GTK4_jll")
    Dependency("libadwaita_jll")
    Dependency("OpenGLMathematics_jll")
    Dependency("libcxxwrap_julia_jll")
    BuildDependency("libjulia_jll")
    BuildDependency("Xorg_xorgproto_jll"; platforms = x11_platforms)
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies; julia_compat="1.6", preferred_gcc_version = v"12.1.0")
