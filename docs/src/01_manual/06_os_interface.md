# Chapter 8: Operating System Interface

In this chapter, we will learn:
+ How to properly do logging
+ How to copy / move / create / delete files 
+ How to automatically open a file or url for the user
+ How to access a files metadata
+ How to monitor a file changing
+ How to open a dialog that lets users select files
+ How to store arbitrary objects in a .ini file
+ How to use icons 
+ How to customize menu section layouts using icons

---

<details><summary><b><tt>main.cpp</tt> for this chapter</b></summary>

Here is a `main.cpp` that allows us to run any code snippet mentioned in this chapter:

```cpp
#include <mousetrap.hpp>
using namespace mousetrap;

int main()
{
    auto app = Application("example.app");
    app.connect_signal_activate([](Application* app)
    {
        auto window = Window(*app);
        auto button = Button();
        button.set_child("<b>&#9205;</b>");
        button.connect_signal_clicked([](Button*){
           // snippet goes here, press button to trigger it 
        });
        
        window.set_child(button);
        window.present();
    });
    return app.run();
}
```
</details>

---

## Logging

### Introduction

When shipping applications, stability is paramount. Nobody will use an app if it keeps crashing, especially if that crash may corrupt important files.

The best way to prevent crashing is to follow [proper testing procedures](https://www.globalapptesting.com/blog/software-testing). For a small team, it is inevitable that some things will slip through the cracks. When an end user comes to us with a problem or bug, they most likely will not be able to precisely describe the state of the application, and, depending on the user base, they may not be able to describe the problem at all.

This is where objective information about what exactly was happening is invaluable. **Logging** is the act of creating this information. Information about the current past state of the application is stored in a file, so that when a crash or bug occurrs, we can simply ask the user to provide use with the log file and analyze it ourselves.

When working through past chapters, we may have already encountered some logging information. For example, if we try to do the following:

```cpp
auto box = Box();
box.push_back(box);
```

We get the following message printed to our console:

```
(example_target:45245): mousetrap-CRITICAL **: 16:44:27.065: In Box::push_back: Attempting to insert widget into itself. This would cause an infinite loop
```

We cannot insert a widget into itself, mousetrap prevented this action and printed a log message to inform us of this instead. This cushions the applications stability from potential developer errors. Any and all functions should follow this philosphy: prevent the error or bug, print a log message instead. 

### Log Message Properties

Let's go through each part of the above message, one-by-one:

#### Application ID

First we have `(example_target:45245)`, this is the identification of our application. During normal runtime, this information may not be very useful. Once the log is stored to a system-level log file, however, many applications may log at the same time to the same file. Knowing which log message came from which application is integral in this context.

#### Log Domain

Next we have `mousetrap-CRITICAL`. The word before the `-` is the **log domain**. This is a developer-defined identification that should state which part of the application or library caused the logging message. Pre-defined domains include `mousetrap` for mousetrap-specific warnings, `GTK` for GTK-based warning, `GLib`, `Gio`, `Gdk`, etc. As a user of mousetrap, you should choose a new log domain. For example, if we create a new application called "Foo Image Manipulation Program", we should choose a descriptive log domain, such as `foo_image_manipulation_program`, `FIMP`, or `foo`.

#### Log Levels

`CRITICAL` is the messages **log level**. Mousetrap offers the following log levels:

+ `DEBUG` is for messages that should not appear when the end user uses the application, they are **only meant for developers** themself
+ `INFO` is for **benign status updates**, for example `succesfully opened file at (...)`. These message will not be stored or printed to console, unless we specifically request the logging suite to do so
+ `WARNING` is for messages that should attempt to **undesired but not critical behavior** before it occurrs, for example, when attempting to close a file while it is still being written to, a warning should be printed and the closing should be postponed until writing is done
+ `CRITICAL` are for errors. In many langauges, an error means the end of runtime, which is unacceptable for GUI applications. If the application throws an C++ exception, for example, that exception should be caught and printed as a `CRITICAL` log message. Software designers should take care that the application cannot crash under any circumstances
+ `FATAL` is the most severe log level and should only be used as an absolute last resort. Once a `FATAL` warning is printed, the application exits immediately. These should be reserved to issues that make it impossible to run an application, for example `no gaphics card detected. Quitting...`

We see that our message from before was designated as `CRITICAL`. This is because adding a widget to itself would effectively deadlock the application, ending runtime. This makes it an issue too severe for a `WARNING`, but it is still recoverable (by preventing the insertion), therefore `FATAL` would be inappropraite. `WARNING`s may be triggered by users, if a user is able to trigger a `CRITICAL` log message, this inherently means we as developers failed to prevent the user form doing so. An issue should be patched immediately.

#### Time Stamp

Next, we have `16:44:27.065`, this is the **time stamp** of the log message, with millisecond precision. When stored the log to a file, the current date and year is also appended to the time stamp.

#### Message

Lastly we have the **log message**. Log messages should contain the name of the function they are called from, for example, in the above message it says `In Box::push_back`, telling developers that the error happened in that function. This makes debugging easier.

Messages should not end with a `\n` (a newline), as one is automatically appended to the end of the message.

### Printing Messages

All interaction with the log is handled by \link mousetrap::log `mousetrap::log`\endlink, which is a singleton class. This means it cannot be instantiated, has no mutable members, and all functions of `log` are static.

We have one function for each log level, called `log::debug`, `log::info`, `log::warning`, `log::critical` and `log::fatal`. Each of these functions takes two arguments: the log message and the log domain, in that order. Application id, timestamp, etc. are automatically added. The message should be a plain string, it does not respect html, css, or pango properties and should not contain any control characters, such as `\t` or `\n`. We should always assume that the console or file we are logging to only supports UTF-8, characters from other encodings are discouraged.

As mentioned before, messages of level `debug` and `info` are only printed if we speficially request so. We enable these on a per-log-domain basis, using `set_surpress_info` and `set_surpress_debug` respectively. For example, if our log domain is `foo`:

```cpp
// define custom domain
const LogDomain FOO_DOMAIN = "foo";

// print `INFO` level message but nothing will happen because it is surpressed by default
log::info("Surpressed message", FOO_DOMAIN);

// enable `INFO` level messages
log::set_surpress_info(FOO_DOMAIN, false);

// message will be printed
log::info("No longer surpressed message");
```

Shipped applications, that is, applications intended for end users that are no longer under development, should surpress all `DEBUG` and `INFO` messages. The should only be enabled during development.

### Logging to a File

If the operating system is Linux, many log message will be written to the default location, usually `/var/log`. On other operating systems, message may not be stored at all.

Regardless of OS, we can forward all logging, including that of mousetrap itself, to a file using `log::set_file`, which takes the file path as a string. If the file already exist, it will be appended to (as opposed to being overriden). If the file does not yet exist, it will be created.

When stored to a file, logging message will have a different format that may or may not list additional information when compared to logging to a console. The philosophy behind this is that it is better to log as much information as possible, then use second party software to filter it, as opposed to missing crucial information for the sake of brevity and ease of debugging.

```cpp
const LogDomain FOO_DOMAIN = "foo";
log::set_file("example_log.txt");
log::warning("In example.main: Example Message", FOO_DOMAIN);
```

Will add the following lines to a `example_log.txt`

```
[23-05-06 23:01:34,920]: In example.main: Example Message
	GLIB_DOMAIN foo
	MOUSETRAP_LEVEL WARNING
	PRIORITY 4
```

Any and all finished applications should print as many log messages as is practical. This allows for better scalability and collaboration, as even contributors with minimal programming expertise are usually able to work through a log file, identifying the point at which our application failed.

---

---

## File System

Most GUI applications on desktops are centralized around modifying files. This may be a text or image editor exporting files, or a video game creating a save file. Conversely, Mousetrap offers a robust, operating-system-agnostic way of interacting with the users file system.

There are two kinds of objects in a filesystems: **files**, which contain arbitrary data, and **directories**, which contain other files and/or other directories. We sometimes call a directory a **folder**. 

Examples for files that are not folders include `.png`, `.txt`, `.cpp` text files, shared libraries, binaries, or executable files.

A **path** is a string, made up of folder names separated by `/`, (or `\` on windows, though this should be avoided). Examples include `/var/log`, `~/Desktop`, etc.

An **uri** (universal resource identifier) is another way to express the location of the file. It follows a [strict scheme](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier), which is followed by most internet browsers and should be preferred to regular paths for file transfers between different machines.

### FileDescriptor

When querying info about a file, we use \a{FileDescriptor}, which represents information about a file or folder. This object is non-mutating, meaning it is incapable of changing anything about the actual file on the disk. In other words, `FileDescriptor` is read-only. This is important to realize.

We can create a file descriptor from a path like so:

```cpp
auto readonly = FileDescriptor();
readonly.create_from_path("/usr/Desktop/example.txt");
```

Where the argument to `create_from_path` will be automatically detected as an absolute path (a path beginning at the root of a system, usually `/` on unix, `C:` on windows). If it is not an absolute path, it will be prefixed with the applications runtime directory. For example if we create a `FileDescriptor` from path `"resources/image.png"`, and our application is located in `/usr/bin`, then the path will be treated as `/usr/bin/resources/image.png`.

`FileDescriptor` does not make sure the undelying file or folder actually exists, or that it is a valid file. Creating a descriptor from an invalid path or a path that does not point to a file or folder works just fine, and we won't get a warning. To check wether a file descriptor points to a valid file or folder, we use `FileDescriptor::exists`. 

In order to query whether a `FileDescriptor` points to a file or a directory, we use `FileDescriptor::is_file` and `FileDescriptor::is_folder` respectively. If the entry pointed to by `FileDescriptor` does not exist, both of these functions will return `false`.

`FileDescriptor` allows us to query a variety of information about the file, including, but not limited to:

+ `get_path` returns the location of the file as a path, eg. `~/Desktop/example.txt`
+ `get_uri` returns the location as an uri, eg. `file://~/Desktop/example.txt`
+ `get_file_extension` returns the file extension, eg. `.txt`
+ `is_executable` checks whether the file is executable
+ `get_content_type` returns the [MIME type](https://en.wikipedia.org/wiki/Media_type), eg. `text/plain`

For less common metadata information, we can use `query_info`, which takes an **attribute identifier**. A list of identifiers can be found [here](https://docs.gtk.org/gio/index.html#constants), though, depending on the type of file and operating system, not all of these attributes may have a corresponding value.

If the file is a folder, we can use `get_children` to get all files and/or directories inside that folder. `get_children` takes a boolean as its only argument, which specifies whether it should list all children recursively.

---

## Manipulating the Disk

`FileDescriptor` being non-mutating means we need a different part of mousetrap in order to actually modify files on the users disk. This is accomplished using \a{file_system\, which, like `log`, is a singleton. It provides all the standard file operations: creating, deleting, copying, and moving files. 

### Creating Files

`file_system::create_file_at` creates a file at a given location. It takes a file descriptor as its argument. If `should_replace`, its second argument, is set to `false` and the file already exists, no operation will be performed

```cpp
if (file_system::create_file_at(FileDescriptor("/absolute/path/to/file.txt", false))
    // open contents of file here
```

`file_system::create_directory_at` performs a similar action, except it creates a directory instead of a file.

### Deleting Files

To permanently delete a file, we use `file_system::delete_at`, which takes a file descriptor as its argument. This immediately deletes the file, making it unable to be recovered. We usually want to avoid doing this, in which case shoul use `file_system::move_to_trash`.

```cpp
auto to_delete = FileDescriptor("/path/to/delete/file.txt");
if (not file_system::move_to_trash(to_delete))
    log::warning("In example: Unable to delete file at `" + to_delete.get_path() + "`");
```

### Moving / Copying File

To move a file from one location to another, we use `file_system::move`. If we want to copy a file or directory instead of moving it, we use `file_system::copy`:

```cpp
auto from = FileDescriptor("/path/from/file.txt");
auto to = FileDescriptor("/different_path/to/file.txt");
if (not file_system::move(from, to))
    log::warning("In example: Unable to move file from `" + from.get_path() + "` to `" + to.get_path() + "`");
```

### Changing File Properties

\todo this feature is not yet implemented

### Accessing & Changing a files content

\todo this feature is not yet implemented. Use [`std::fstream`](https://en.cppreference.com/w/cpp/io/basic_fstream) instead.

---

### Monitoring File Changes

Often, when writing a GUI, we want the graphical interface to reflect the contents of a file on the disk. A good example would be a text editor. We can of couse modify the file from inside our own application, however, if the file is modified by a third entity, such as another application, a conflict may arise. In this case, we will usually want to update the state of our application, whenever the underlying file changes. This is made possible by \a{FileMonitor}, which monitors a file or directy for changes.

`FileMonitor` cannot be created directly, instead, we first create a `FileDescriptor`, then call `FileDescriptor::create_monitor`, which returns the `FileMonitor` instance.

`FileMonitor` works similar to a signal emitter. To register a function that is called whenever the file changes, we use `on_file_changed`, which expects a function with the signature `(FileMonitorEvent event, const FileDescriptor& self, const FileDescriptor& other, (Data_t)) -> void`, where

+ `event` is a `FileMonitorEvent`, describing the type of action performed, see below
+ `self` is a descriptor pointing to the file that was modified
+ `other` is a descriptor usually not pointing to any file, unless the event was `FileMonitorEvent::MOVED_IN` or `FileMonitorEvent::MOVED_OUT` , in which case it will point to whatever file was moved into or out of the directory which `self` points to
+ `Data_t` is any arbitrary data

The following monitor events are supported:

| `FileMonitorEvent` | Meaning | value of `self`          | value of `other`   |
|--------------------|---------|--------------------------|--------------------|
|`CHANGED` | File was modified in any way | modified file            | none               |
|`DELETED` | File was deleted | monitored file or folder | deleted file       |
| `CREATED` | File was created | monitored file or folder | newly created file |
| `ATTRIBUTE_CHANGED` | File metadata changed | changed file             | none |
| `RENAMED` | Files name changed | changed file             | none |
|`MOVED_IN` | File was moved into self | monitored folder         | moved file |
|`MOVED_OUT` | File was moved out of self | monitored folder         | moved file | 

For example, if we want to trigger an action whenever `/path/to/file.txt` changes, we could do the following:

```cpp
auto to_watch = FileDescriptor("/path/to/file.txt"); // equivalent to .create_from_path
auto monitor = to_watch.create_monitor();
monitor.on_file_changed([](FileMonitorEvent event, const FileDescriptor& self, const FileDescriptor&){
    if (event == FileMonitorEvent::CHANGED)
        std::cout << "file at `" << self.get_path() << "` changed" << std::endl;
});
```

---

---

## FileChooser

Opening a dialog to allow a user to select a file or folder is a task so common, most operating systems provide a native widget just for this purpose. Mousetrap, conversely, also has an object tailor-made for this: \a{FileChooser}

`FileChooser` is not a widget, it is a `SignalEmitter` but does not have any public signals we can connect to. Its constructor takes two arguments, a \a{FileChooserAction} and the resulting dialog windows title. `FileChooserAction` is an enum, whose value determine which **mode** the `FileChooser` will perform in:

| `FileChooserAction` value | Users may select...         |
|---------------------------|-----------------------------|
| `OPEN_FILE` | exactly one file            |
| `OPEN_MULTIPLE_FILES` | one or more files           |
| `SELECT_FOLDER` | zero or one folder          |
| `SELECT_MULTIPLE_FOLDERS` | zero or more folders        |
| `SAVE` | new files name and location |

Depending on which `FileChooserAction` we choose, `FileChooser` will automatically change its layout and behavior.

```cpp
auto file_chooser = FileChooser(FileChooserAction::OPEN_MULTIPLE_FILES);
```

\image html file_chooser.png

\how_to_generate_this_image_begin
```cpp
auto filter = FileFilter("*.hpp");
filter.add_allowed_suffix("hpp");

static auto file_chooser = FileChooser(FileChooserAction::OPEN_MULTIPLE_FILES);
file_chooser.set_initial_filter(filter);

file_chooser.on_accept([](const std::vector<FileDescriptor>& files){
    for (auto& file : files)
        std::cout << file.get_path() << std::endl;
});

file_chooser.on_cancel([](){
    std::cout << "cancel" << std::endl;
});

file_chooser.present();
```
\how_to_generate_this_image_end

In order to react to the user making a selection or canceling the operation, we need to register a callback with the file chooser.

`FileChooser::on_accept` accepts a function with the signature `(const std::vector<FileDescriptor>&, (Data_t)) -> void`. The input to this function will be a list of file descriptors. Depending on which `FileChooserAction` we have chosen, the vector may have zero, one, or more elements, and the contained `FileDescriptor`s may point to a file or folder.

`FileChooser::on_cancel` is called if the user cancels or otherwise closes the dialog. This function accepts an argument with the signature `((Data_t)) -> void`:

```cpp
auto file_chooser = FileChooser(FileChooserAction::OPEN_MULTIPLE_FILES);
file_chooser.on_accept([](const std::vector<FileDescriptor&> files) -> void {
    // access selected files 
    for (auto file : files)
        std::cout << file.get_path() << std::endl;
});

file_choose.on_cancel([]() -> void {
    std::cout << "canceled" << std::endl;
});
```

After instantiation the `FileChooser` and connecting our handlers, we call `FileChooser::present` to present the dialog to the user.

### FileFilter

Looking again at the previous screenshot in this section, we see that in the bottom right corner of the dialog, a drop-down with the currently selected item `*.hpp` is seen. This is the currently active **filter**. Depending on the selection, only files that pass that filter will be shown. This is useful when we want to limit file selection to only a certain type of files, for example, an image manipulation application would only allow loadable image files as the file type for an `Open...` dialog.

We construct a `FileFilter` by first choosing a name. This string will be used as the title of the filter, which is shown in the `FileChooser`s drop-down:

```cpp
auto file_filter = FileFilter("*.hpp");
```

We now have to specify which files should pass the filter. `FileFilter` offers multiple functions for this:

| `FileFilter` Method | Argument | Resulting Allowed Files                                  |
|---------------------|----------|----------------------------------------------------------|
| `add_allowed_suffix` | `hpp`   | files ending in `.hpp`                                   |
| `add_allow_all_supported_image_formats | (no argument) | file types `Image::create_from_file` accepts             |
| `add_allowed_mime_type` | `text/plain` | files classified as plain text, for example `.txt`       |
| `add_alowed_pattern` | `*.hpp; *.cpp` | files whose name conform to the given regular expression |

Where a table with the allowed image formats is available in [the previous chapter on images](07_image_and_sound.md#supported-image-formats).

After having set up our filter, we simply add it to the `FileChooser` instance using `FileChooser::add_filter`:

```cpp
// create filter that only lets C++ header files through
auto file_filter = FileFilter("*.hpp");
file_filter.add_allowed_suffix("hpp");
file_chooser.add_filter(file_filter);
```

By default, no `FileFilter`s will be registered, which means the `FileChooser` will display all possible file types.

---

---

## Glib Keyfiles

For data like images or sound, we have methods like `Image::save_to_file`, or `SoundBuffer::save_to_file` to store them on the disk. For custom objects, such as the state of our application, we have no such option. While it may sometimes be necessary, for most purposes we do not need to create a custom file type, instead, we can use the [**GLib KeyFile**](https://docs.gtk.org/glib/struct.KeyFile.html), whose syntax is heavily inspired by Windows `.ini` settings files.

Keyfiles are human-readable and easy to edit, which makes them better suited for certain purposes when compared to [json](https://docs.fileformat.com/web/json/) or [xml](https://docs.fileformat.com/web/xml/) files.

Thanks to `mousetrap::KeyFile`, loading, saving, and modifying key files is made easy and convenient.

### Glib Keyfile Syntax

In a KeyFile, every line is on of four types:

+ **Empty**, it has no characters or only control characters and spaces
+ **Comment**, it begins with `#`
+ **Group**, has the form `[group_name]`, where group name is any name not containing a space
+ **Key**, has the form `key=value`, where key is any name and value is of a format discussed below

For example, the following is a valid key file:

```txt
# keybindings 
[image_view.key_bindings]

# store current file
save_file=<Control>s

# miscellanous config
[image_view.window]

# default window size
width=400
height=300

# default background color
default_color_rgba=0.1;0.7;0.2;1
```

Let's go through each line one-by-one:

+ `# keybindings`, and other lines starting with `#`, are parsed as comments
+ `[image_view.key_bindings]` designates the first **group**. Similar to how actions are named, we should use `.` to convey scoping, and pick descriptive names
+ `save_file=<Control>s` is the first key-value pair, which is in the group `image_view.key_bindings`, it has the key `save_file` and the value `<Control>s`, which is a **string** that can be parsed as a shortcut
+ `[image_view.window]` is our second group, its name is `image_view.window`
+ `width=400` and `height=300` are two key-value pairs in group `[image_view.window]`. Their values are **numbers**, `400` and `300`, which are integers
+ `default_color_rgba=0.1;0.7;0.2;1` is the third key-vaue pair in group `image_view.window`. It has the value `0.1;0.7;0.2;1` which is a **list of numbers**. As suggested by this entries key, this list should be interpreted as `RGBA(0.1, 0.7, 0.2, 1)`

Key-value pairs belong to the group that was last opened. Groups cannot be nested, they always have a depth of 1 and every key-value-pair has to be inside a group.

### Accessing Values

If the above keyfile is stored at `resources/example_key_file.txt`, we can access the values of the above named keys like so:

```cpp
auto file = KeyFile();
file.load_from_file("resources/example_key_file.txt");

// keybindings in group `image_view.keybindings`
// retrieved as string
std::string save_file_keybinding = file.get_value("image_view.key_bindings", "save_file");

// size of window
int width = file.get_value_as<int>("image_view.window", "width");
int height = file.get_value_as<int>("image_view.window", "height");

// background color
RGBA default_color = file.get_value_as<RGBA>("image_view.window", "default_color_rgba");
```

We see that the general syntax to access a keyfile value as C++-type `T`, is `file.get_value_as<T>("group_name", "key_name")`. `KeyFile` automatically parses the value of the key-value pair, which is a string, then returns the corresponding C++ type if parsing was succesful. Only the following types are supported:

| Type                     | Example Value                                | Format                           |
|--------------------------|----------------------------------------------|----------------------------------|
 | bool                     | `true`                                       | `true`                           |
| std::vector<bool>        | `{true, false, true}`                        | `true;false;true`                |
| int32_t                  | `32`                                         | `32`                             |
| std::vector<int32_t>     | `{12, 34, 56}`                               | `12;34;56`                       |
| uint64_t                 | `984`                                        | `948`                            |
| std::vector<uint64_t>    | `{124, 123, 192}`                            | `124;123;192`                    |
| float                    | `3.14`                                       | `3.14`                           |
| std::vector<float>       | `{1.2, 3.4, 5.6}`                            | `1.2;3.4;5.6`                    |
| double                   | `3.14569`                                    | `3.14569`                        |
| std::vector<double>      | `{1.123, 0.151, 3.121}`                      | `1.123;0.151;3.121`              |
| std::string              | `"foo"`                                      | `foo`                            |
| std::vector<std::string> | `{"foo", "lib", "bar"}`                      | `foo;lib;bar`                    |
| RGBA                     | `RGBA(0.1, 0.9, 0, 1)`                       | `0.1;0.9;0.0;1.0`                |
 | Image | `RGBA(1, 0, 1, 1), RGBA(0.5, 0.5, 0.7, 0.0)` | `1.0;0.0;1.0;1.0;0.5;0.5;0.7;0.0` | 

We can also access comments. To access the comment above a group name `group_name`, we use `KeyFile::get_comment_above("group_name")`. If the comment is above a key-value pair with key `key`, we would use `KeyFile::get_comment_above("group_name", "key")`.

### Storing Values

We use `KeyFile::set_value<T>` to modify the value of a keyfile entry. Like before, this functions takes a group- and key-identifier, along with the C++ type `T` of the value. `T` is again restricted to the types listed above.

For example, setting the value of `default_color_rgba` in group `image_view.window`:

```cpp
file.set_value<RGBA>("image_view.window", "default_color_rgba", RGBA(1, 0, 1, 1));
```

To modify comments, we use `KeyFile::add_comment_above`, which, just like before, takes only a group id to modify the comment above a group, or both a group id and key to modify the comment above a key-value pair.

When writing to an instance of `KeyFile`, only the value in memory is modified, **not the file on the disk**. To update the actual stored file, we need to call `KeyFile::save_to_file`. 

---

## Icons

We've seen before how to load and display an image using `Image`. One of the most common applications for this is to use the resulting picture as the label of a `Button`. In common language, this picture will often be called an **icon**.

In modern desktop applications, we may have dozens of these images exclusively used as visual labels for widgets. While it is possible to simply store all these images as `.png`s and load them manually with `Image`, this is hardly very scalable. Furthermore, this method does not allow use to modify all pictures at the same time, which may be necessary to for example increase icon size for visually impaired users.

A better way to handle images in a context like is this is provided by \a{Icon}.

`Icon` is similar to an image file, though it usually does not contain pixel data. `Icon`s can be loaded from `.png` files, but also allows `.svg` (vector graphics), and `.ico` (web browser icons). `Icon` supports the exact same file formats as `Image`, though we should usually prefer loading icons from vector-graphics files, as opposed to raster-based, as the latter may not scale smoothly to different resolutions. `Icon` is similar to a file descriptor, in that it does not contain any data and it is non-mutating and immutable, we cannot change the underlying image of an `Icon`.

### Creating and Viewing Icons

The simplest way to create an `Icon` is to load it as if it was an `Image`. If we have a vector graphics file at`resources/save_icon.svg`, we would load it like so:

```cpp
auto icon = Icon();
icon.create_from_file("resources/save_icon.svg", 48);
```

Where `48` means the icon will be initialized with a resolution of 48x48 pixels. `Icon`s can only be square.

If we want to display this icon using a widget, we can use `ImageDisplay::create_from_icon`. Ths is similar to images, however, because `Icon` will usually not be rasted-based, the `ImageDisplay` will scale much more smoothly to any resolution, as no interpolation has to take place.

On top of the ways we use `Image`, `Icon` offers some addtional ways of displaying it.

### Using Icons in Menus

One unique application for `Icon` is that it can be **used as a menu item**. We use `MenuModel::add_icon` to create a menu item of this type. An icon menu item cannot have a text label, though it does require an underlying action, which will be triggered when the user clicks the icon menu item.

```cpp
// declare action
auto action = Action("noop.action");
action.set_function([](Action*){
  // do something
});

// create icon
auto icon = Icon();
icon.create_from_file(// ...

// create menu
auto model = MenuModel();
auto submenu = MenuModel();
auto section = MenuModel();

// add icon 
section.add_icon(icon, action);

// add section
submenu.add_section("Buttons!", section, MenuModel::CIRCULAR_BUTTONS);

// display as MenuBar
model.add_submenu("Menu", submenu);
auto menubar = MenuBar(model);
```

\image html menu_model_with_icon.png

Note that when calling `add_section`, we provided an optional 3rd argument. This  is the **section format**, of type ` MenuModel::SectionFormat`. 

There are \link mousetrap::MenuModel::SectionFormat multiple styles\endlink of format, which all look slightly different. We should use sections styles **only when all items in the section are icons**, that is, all menu items in the section were created using `add_icon`.

With icons and section formats, we can add some style to our menus. This is rarely necessary, but it is a nice option to have. 

Note that an item cannot have both a text label and an icon at the same time. If we really need this format, we can create a `Box` with both an `ImageDispay` and `Label`, then add a menu item using `MenuModel::add_widget` instead.

### IconTheme

\todo this section is not yet complete