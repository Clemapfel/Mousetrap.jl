# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder, Pkg

name = "libmousetrap"
version = v"0.3.0"

# Collection of sources required to complete build
sources = [
    GitSource("https://github.com/Clemapfel/mousetrap.git", "aab1826318c43f0172d1ccd14faa06e7e61eba08"),
    GitSource("https://github.com/Clemapfel/mousetrap_julia_binding.git", "ffba2656ef05ab4dc052e6d53ee524b6f5e2371b")
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
cd ../mousetrap_julia_binding
meson setup build --cross-file=$MESON_TARGET_TOOLCHAIN --cross-file=../cmake_toolchain_patch.ini -DJulia_INCLUDE_DIRS=$prefix/include/julia
meson install -C build
cd ..
rm cmake_toolchain_patch.ini
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = filter(p -> nbits(p) == 64, supported_platforms())

# The products that we will ensure are always built
products = [
    LibraryProduct("libmousetrap", :mousetrap),
    LibraryProduct("libmousetrap_julia_binding", :mousetrap_julia_binding)
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
