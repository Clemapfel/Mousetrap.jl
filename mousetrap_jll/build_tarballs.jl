# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder, Pkg

name = "mousetrap"
version = v"0.3.0"

# Collection of sources required to complete build
sources = [
    GitSource("https://github.com/Clemapfel/mousetrap.git", "f14b9e4a7b9f83fca6082ce961e468da93529e6c"),
    GitSource("https://github.com/Clemapfel/mousetrap_julia_binding.git", "5fa37713123201a523051d4bed318da015f514b1")
]

#julia -t 8 build_tarballs.jl --debug --verbose --deploy=local
#meson setup build --cross-file=$MESON_TARGET_TOOLCHAIN -Dcmake_prefix_path=$prefix
#meson setup build -Dprefix=$prefix -DJulia_INCLUDE_DIRS=$prefix/include/julia

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
platforms = [
    Platform("x86_64", "linux"; libc = "glibc")
    #=
    Platform("aarch64", "linux"; libc = "glibc")
    Platform("powerpc64le", "linux"; libc = "glibc")
    Platform("x86_64", "linux"; libc = "musl")
    Platform("aarch64", "linux"; libc = "musl")
    Platform("x86_64", "freebsd"; )
    =#
    Platform("x86_64", "macos"; )
    #Platform("aarch64", "macos"; )
    Platform("x86_64", "windows"; )
]

# The products that we will ensure are always built
products = [
    LibraryProduct("libmousetrap", :mousetrap),
    LibraryProduct("libmousetrap_julia_binding", :mousetrap_julia_binding)
]

x11_platforms = filter(p -> Sys.islinux(p) || Sys.isfreebsd(p), platforms)

# Dependencies that must be installed before this package can be built
dependencies = [
    Dependency(PackageSpec(name="GLEW_jll", uuid="bde7f898-03f7-559e-8810-194d950ce600"))
    Dependency(PackageSpec(name="GLU_jll", uuid="bd17208b-e95e-5925-bf81-e2f59b3e5c61"))
    Dependency(PackageSpec(name="GTK4_jll", uuid="6ebb71f1-8434-552f-b6b1-dc18babcca63"))
    Dependency(PackageSpec(name="libadwaita_jll", uuid="583852a3-1c13-5035-b52b-3b742a7b3316"))
    Dependency(PackageSpec(name="OpenGLMathematics_jll", uuid="cc7be9be-d298-5888-8f50-b85d5f9d6d73"))
    Dependency(PackageSpec(name="libcxxwrap_julia_jll", uuid="3eaa8342-bff7-56a5-9981-c04077f7cee7"))
    BuildDependency(PackageSpec(name="libjulia_jll", uuid="5ad3ddd2-0711-543a-b040-befd59781bbf"))
    BuildDependency("Xorg_xorgproto_jll"; platforms=x11_platforms)
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies; julia_compat="1.6", preferred_gcc_version = v"12.1.0")