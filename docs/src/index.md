# Mousetrap

Welcome to the documentation of Mousetrap.jl, a GUI engine for Julia. 
Mousetrap was created and designed by [C. Cords](https://clemens-cords.com).

This page contains a [manual and tutorial](#manual), as well as an [index](#index) of all [functions](./02_library/functions.md), [classes](./02_library/classes.md), and [enums](./02_library/enums.md).

To download and install mousetrap, follow the instructions on the [official GitHub page](https://github.com/Clemapfel/mousetrap.jl#installation).

Mousetrap.jl, the non-Julia components of mousetrap, this documentation, and all its original assets, are licensed under [lGPL3.0](https://www.gnu.org/licenses/lgpl-3.0.en.html#license-text), meaning they can be used in both free, open-source, as well as for-profit, proprietary projects.

For frequently asked questions, see [here](#FAQ).

Use the navigation area on the left side of this page or the table of contents below to navigate to the appropriate chapter of this manual:

## Manual

```@contents
Pages = [
    "01_manual/01_installation.md"
    "01_manual/02_signals.md"
    "01_manual/03_actions.md"
    "01_manual/04_widgets.md"
    "01_manual/05_event_handling.md"
    "01_manual/06_image.md"
    "01_manual/07_os_interface.md"
    "01_manual/08_menus.md"
    "01_manual/09_native_rendering.md"
    "01_manual/10_theme_customization.md"
    "01_manual/11_app_distribution.md"
]

Depth = 5
```

---

## Index

+ [index of classes](./02_library/classes.md)
+ [index of functions](./02_library/functions.md)
+ [index of enums](./02_library/enums.md)

---

## FAQ

### Why is installation so complicated, why are there three jlls?

Simplifying the installation to `] add Mousetrap` is a very high priority, and, as of version 0.2.0, is actively being worked on.

The reason for three jlls is that the C++ build of Mousetrap is quite complex to begin with, and making it work inside the BinaryBuidler sandbox, which is the cross-compilation environment used to deploy jlls, was quite the struggle for me, even though building on an actual machine works flawlessly. Because of this, the jlls were split by platform, which works but is incredibly bad style. I didn't want to upload packages of this low quality to Yggdrasil, the BinaryBuilder registry, so I decided to host them locally until I have the skill necessary to make it one, well-maintained `mousetrap_jll`. Once this exists on Ygddrasil, `Mousetrap.jl` can be uploaded to the Julia registry the same day. Maintainers of BinaryBuilder have graciously reached out to me to assist me in this process, and we are actively collaborating to address this issue.

### Why is there a C++ Component at all?

The C++ version of mousetrap was originally created for an unrelated commercial, closed-source project in 2022. When the project failed due to funding issues in 2023, I decided that, instead of throwing away all my C++ work, I would instead create a Julia wrapper around it, so it can at least contribute to the Julia ecosysem. Even though Julia-Mousetrap is the face of the project now, C++-Mousetrap existed and was finished *before* Julia-Mousetrap was ever conceived.

A less valid reason is that mousetrap, in order to extend the GObject type system, [makes extensive use of C-macros](https://github.com/Clemapfel/mousetrap/blob/main/include/mousetrap/signal_component.hpp#L24), which are quite hard to emulate in Julia, as there is no way to `ccall` a macro, to my knowledge.

### What is the difference between mousetrap and GTK4.jl?

Mousetrap is unaffiliated with [GTK.jl](https://github.com/JuliaGraphics/Gtk.jl) and [GTK4.jl](https://github.com/JuliaGtk/Gtk4.jl). The only connection these projects share is that both use the GTK4 C library as their basis. Mousetrap is not endorsed by [GNOME](https://gnome.org) and has no connection to that organization or any of its contributors.

### What advantages does mousetrap have over pure GTK4?

While based on GTK4 and usually calling native GTK4 under the hood, mousetraps interface, that is, the actual architecture of the library, including syntax and names, was reworked from the ground up. Heavy editorializing has taken place, renaming or completely removing certain parts of GTK4 in an effort to make mousetrap more friendly to newcomers and people with no GUI experience, easier to use, and less susceptible to developer error.

Furthermore, mousetrap contains an all-new OpenGL-based rendering engine, which aims to replace the cairo component of native GTK4 to allow for faster, more easily integrated native rendering.

### What advantages does pure GTK4 have over mousetrap?

Speaking about the GTK4 C library specifically, not GTK4.jl, GTK4 is much bigger and has many features that went unused in mousetrap, or, if used, were made opaque such that a user of mousetrap cannot interact with these features:

+ Removed Modules: [GDK](https://docs.gtk.org/gdk4/), [ATK](https://gitlab.gnome.org/GNOME/atk), [gobject](https://docs.gtk.org/gobject/), [GLib](https://docs.gtk.org/glib/), [adwaita](https://gnome.pages.gitlab.gnome.org/libadwaita/doc/1.3/)
+ Widgets with no mousetrap equivalent: `GtkListBox`, `PasswordEntry`, `GtkTextView`, `GtkSourceView`, `AdwAboutWindow`
+ Removed Features: Mnemonics, Stateful Actions, [GtkBuilder Interface](https://docs.gtk.org/gtk4/class.Builder.html), `GTK_DEBUG`, `GtkInspector`

Furthermore, any classes marked as deprecated in GKT4.10, such as `GtkTreeView`, where removed completely.

When possible, the adwaita version of a widget was preferred over the native GTK4 version, for example, using `AdwWindow` instead of `GtkWindow`, or `AdwMessageDialog` over `GtkAlertDialog`.

Julia does not use a [build system such as meson](https://mesonbuild.com/) and is thus incompatible with distribution through [flatpak](https://flatpak.org/) or similar services.

### How do I ship my app?

JuliaComputing and many more contributors are currently working on [`PackageCompiler`](https://github.com/JuliaLang/PackageCompiler.jl), which is supposed to compile a Julia package into a stand-alone binary. Compatibility of mousetrap with `PackageCompiler` remains untested and may be impossible until further work has been put into either `PackageCompiler`, or mousetrap itself. [There is evidence](https://www.reddit.com/r/Julia/comments/14kfyx7/comment/jpuofyg/) that static compilation is one of Julias next big goals. Ideally, when static compilation is working 100% of the time, mousetrap will be polished enough to be considered fully stable and easily distributable, therefore making it usable in production.

Until then, the only way to ship a stand-alone Julia app is to bundle the entire Julia runtime along with the app-specific Julia code and resources, which will usually be a folder with a size of 2 GB or more. Alternatively, developers have to force end users to [install Julia on their machine globally](https://github.com/JuliaLang/juliaup), after which launching the app is as simple as calling (`julia main.jl`) from a shell script.
