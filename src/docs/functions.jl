
#
# Author: C. Cords (mail@clemens-cords.com)
# https://github.com/clemapfel/mousetrap.jl
#
# Copyright © 2023, Licensed under lGPL3-0
#

@document Circle """
```
Circle(center::Vector2f, radius::AbstractFloat, n_outer_vertices::Integer) -> Shape
```
Create a shape as a circle, defined by its center and radius. In OpenGL coordinates.
"""

@document CircularRing """
```
CircularRing(center::Vector2f, outer_radius::AbstractFloat, thickness::AbstractFloat, n_outer_vertices::Integer) -> Shape 
```
Create a shape as a circular ring, defined by its center, `outer_radius`, which is the distance to the out perimeter, and `thickness` which is the distance between the inner and out perimeter.
"""

@document Ellipse """
```
Ellipse(center::Vector2f, x_radius::AbstractFloat, y_radius::AbstractFloat, n_outer_vertices::Integer) -> Shape
```
Create a shape as an ellipse, defined by its center and radii along the x- and y-dimension, in OpenGL coordinates.
"""

@document EllipticalRing """
```
EllipticalRing(center::Vector2f, outer_x_radius::AbstractFloat, outer_y_radius::AbstractFloat, x_thickness::AbstractFloat, y_thickness::AbstractFloat, n_outer_vertices::Unsigned) -> Shape
```
Create a shape as an elliptical ring, where
+ `center`: center of the ring
+ `outer_x_radius`: distance between the center and the outer perimeter along the x-axis
+ `outer_y_radius`: distance between the center and the outer perimeter along the y-axis
+ `x_thickness`: distance between the outer and inner perimeter along the x-axis
+ `y_thickness``: distance between the outer and inner perimeter along the y-axis

In OpenGL coordinates.
"""

@document Line """
```
Line(a::Vector2f, b::Vector2f) -> Shape
```
Create a shape as a 1-fragment thick line between two points, in OpenGL coordinates.
"""

@document Lines """
```
Lines(:Vector{Pair{Vector2f, Vector2f}) -> Shape
```
Create a shape as a set of unconnected lines, vertex positions in OpenGL coordinates.
"""

@document LineStrip """
```
LineStrip(points::StaticArraysCore.SVector{2, Vector2f}) -> Shape
```
Create a shape as a line-strip. For points `{a1, a2, ..., an}`, this will be a set of connected lines `{a1, a2}, {a2, a3}, ..., {an-1, an}`, in OpenGL coordinates.
"""

@document Outline """
```
Outline(other::Shape) -> Shape
```
Create a shape as an outline of another shape.
"""

@document Point """
```
Point(position::Vector2f) -> Shape
```
Create a shape as 1-fragment point, in OpenGL coordinates.
"""

@document Points """
```
Point(positions::Vector{Vector2f}) -> Shape
```
Create a shape as a set of unconnected points, in OpenGL coordinates.
"""

@document Polygon """
```
Polygon(points::Vector{Vector2f}) -> Shape
```
Create a shape as a convex polygon, the outer hull of `points` will be computed, but no vertex elimination will take place. In OpenGL coordiantes.
"""

@document Rectangle """
```
Rectangle(top_left::Vector2f, size::Vector2f) -> Shape
```
Create a shape as an axis-aligned rectangle, in OpenGL coordinates.
"""

@document RectangularFrame """
```
RectangularFrame(top_left::Vector2f, outer_size::Vector2f, x_width::AbstractFloat, y_width::AbstractFloat) -> Shape
```
Create a shape as a rectangular frame, where `x_width`, `y_width` are the "thickness" of the frames filled area. In OpenGL coordinates.
"""

@document Triangle """
```
Triangle(a::Vector2f, b::Vector2f, c::Vector2f) -> Shape
```
Create a shape as a triangle defined by three points, in OpenGL coordinates.
"""

@document Wireframe """
```
Wireframe(points::Vector{Vector2f}) -> Shape
```
Create a shape as a wire-frame. For points `{a1, a2, a3, ..., an}`, the shape
will be a connected series of lines `{a1, a2}, {a2, a3}, ..., {an-1, an}, {an, a1}`. In OpenGL coordinates.
"""

@document activate! """
```
activate!(::Widget)
```
If the widget is activatable, trigger it. Depending on the widget, this may not necssarily emit signal `activate`. Use [`emit_signal_activate`](@ref) to manually emit the signal instead.

---

```
activate!(::Action) 
```
Trigger the actions callback. This will also emit signal `activated`.

"""

@document add_action! """
```
add_action!(app::Application, action::Action)
```
Register an action with the application. This is usually done automatically.

---

```
add_action!(model::MenuModel, label::String, action::Action) 
```
Add an "action"-type item to the menu model

---

```
add_action!(shortcut_controller::ShortcutEventController, action::Action) 
```
Register an action with the shortcut controller. Once connected to a widget, the
controller will listen for keyboard events associated with any registered action,
triggering that action when the shortcut is recognized.
"""

@document add_allow_all_supported_image_formats! """
```
add_allow_all_supported_image_formats!(::FileFilter) 
```
Let all file formats pass through the filter that can be loaded `Image`, `ImageDisplay`, or `Icon`.
"""

@document add_allowed_mime_type! """
```
add_allowed_mime_type!(::FileFilter, mime_type_id::String) 
```
Let all files pass through the filter whose MIME type is equal to the given string.
"""

@document add_allowed_pattern! """
```
add_allowed_pattern!(::FileFilter, pattern::String) 
```
Let all files pass through the filter whose name match the given shell-style glob.

## Example
```julia
filter = FilterFilter("pass_julia_files")
add_allowed_pattern!(filter, "*.jl")
```
"""

@document add_allowed_suffix! """
```
add_allowed_suffix!(::FileFilter, suffix::String) 
```
Let all files pass through the filter whose file extension equal the given string, where `suffix` should **not** contain a dot.

## Example
```julia
filter = FilterFilter("pass_julia_files")
add_allowed_suffix!(filter, "jl") # "jl", not ".jl"
```
````
"""

@document add_button! """
```
add_button!(::AlertDialog, index::Signed, label::String) -> Cvoid
```
Insert a button with given label after the given index (1-based), or 0 to insert it at the beginning.
"""

@document add_child! """
```
add_child!(stack::Stack, ::Widget, title::String) 
```
Add a new stack page that will be uniquely identified by `title`.

---

```
add_child!(fixed::Fixed, ::Widget, position::Vector2f) 
```
Add a widget at given position, in absolute widget-space coordinates.
"""

@document add_controller! """
```
add_controller!(::Widget, controller::EventController) 
```
Add an event controller to the widget. Once that widget is realized, the controller will start listening for events.
"""

@document add_filter! """
```
add_filter!(::FileChooser, ::FileFilter)
```
Add a filter to the selection of available file filters. Use [`set_initial_filter!`](@ref) to make it the currently selected filter.
"""

@document add_icon! """
```
add_icon!(model::MenuModel, icon::Icon, action::Action) 
```
Add an "icon"-type item to the menu model. 
"""

@document add_mark! """
```
add_mark!(::Scale, value::Number, position::RelativePosition, [label::String])
```
Add a mark with an option label. `position` determines where the mark is shown relative to the scales center.
"""

@document add_marker! """
```
add_marker!(::LevelBar, name::String, value::AbstractFloat) 
```
Add a marker with label to the level bar.
"""

@document add_overlay! """
```
add_overlay!(overlay::Overlay, child::Widget ; [include_in_measurement::Bool = true, clip::Bool = false]) 
```
Add an additional overlay widget. It will be display "on top" of previously added widgets. 

If `include_in_measurement` is `true`, the overlaid widget will be included in size allocation of 
the entire `Overlay`.

If `clip` is `true`, if part of a widget goes outside the overlays allocated area, it will be truncated.
"""

@document add_render_task! """
```
add_render_task!(area::RenderArea, task::RenderTask) 
```
Register a new render task with the area. Unless a custom handle was connected to the `RenderArea` using `connect_signal_render!`, 
the render task will be drawn every frame.
"""

@document add_resource_path! """
```
add_resource_path!(::IconTheme, path::String) 
```
Add a folder that the `IconTheme` should lookup icons from. This is in addition to the default search path for icons. 

The folder has to adhere to the [Freedesktop icon theme specificatins](https://specifications.freedesktop.org/icon-theme-spec/icon-theme-spec-latest.html).
"""

@document add_section! """
```
add_section!(self::MenuModel, title::String, to_add::MenuModel, [::SectionFormat]) 
```
Add a "section"-type menu item to the model, which will be constructed based on `to_add`.
"""

@document add_shortcut! """
```
add_shortcut!(::Action, shortcut::ShortcutTrigger) 
```
Add a shortcut trigger to the list of shortcuts. To make a widget listen for action shortcuts, use [`set_listens_for_shortcut_action!`](@ref), or use a [`ShortcutEventController`](@ref).
"""

@document add_submenu! """
```
add_submenu!(model::MenuModel, label::String, to_add::MenuModel) 
```
Add a "submenu"-type menu item to the model, which will be constructed based on `to_add`.
"""

@document add_widget! """
```
add_widget!(model::MenuModel, ::Widget) 
```
Add a "widget"-type item to the model. This widget should be interactable.
"""

@document alt_pressed """
```
alt_pressed(::ModifierState) -> Bool
```
Check if modifier state indicates that the `Alt` key is currently pressed.
"""

@document apply_to """
```
apply_to(::GLTransform, ::Vector2f) -> Vector2f
apply_to(::GLTransform, ::Vector3f) -> Vector3f
```
Apply transform to a vector, both operate in OpenGL coordinates.
"""

@document as_circle! """
```
as_circle!(::Shape, center::Vector2f, radius::AbstractFloat, n_outer_vertices::Integer) 
```
Create a shape as a circle, defined by its center and radius. In OpenGL coordinates.
"""

@document as_circular_ring! """
```
as_circular_ring!(::Shape, center::Vector2f, outer_radius::AbstractFloat, thickness::AbstractFloat, n_outer_vertices::Integer) 
```
Create a shape as a circular ring, defined by its center, `outer_radius`, which is the distance to the out perimeter, and `thickness` which is the distance between the inner and out perimeter.
"""

@document as_cropped """
```
as_cropped(image::Image, offset_x::Signed, offset_y::Signed, new_width::Integer, new_height::Integer) -> Image
```
Crop the image, this is similar to the "resize canvas" operation in many image manipulation programs.
`offset_x` and `offset_y` is the offset between the top-left pixel of the image and the top-left pixel of the
newly allocated area, where an offset of 0 means the new image is anchored at the same pixel as the original.
Offsets can be negative.

This function does not modify the original image.
"""

@document as_degrees """
```
as_degrees(angle::Angle) -> Float64
```
Convert the angle to degrees, in [0°, 360°].
"""

@document as_ellipse! """
```
as_ellipse!(::Shape, center::Vector2f, x_radius::AbstractFloat, y_radius::AbstractFloat, n_outer_vertices::Integer) 
```
Create a shape as an ellipse, defined by its center and radii along the x- and y-dimension, in OpenGL coordinates.
"""

@document as_elliptical_ring! """
```
as_elliptical_ring!(::Shape, center::Vector2f, outer_x_radius::AbstractFloat, outer_y_radius::AbstractFloat, x_thickness::AbstractFloat, y_thickness::AbstractFloat, n_outer_vertices::Unsigned) 
```
Create a shape as an elliptical ring, where
+ `center`: center of the ring
+ `outer_x_radius`: distance between the center and the outer perimeter along the x-axis
+ `outer_y_radius`: distance between the center and the outer perimeter along the y-axis
+ `x_thickness`: distance between the outer and inner perimeter along the x-axis
+ `y_thickness``: distance between the outer and inner perimeter along the y-axis

In OpenGL coordinates.
"""

@document as_flipped """
```
as_flipped(::Image, flip_horizontally::Bool, flip_vertically::Bool) -> Image
```
Create a new image that is a horizontally and/or vertically mirrored.

This function does not modify the original image.
"""

@document as_line! """
```
as_line!(::Shape, a::Vector2f, b::Vector2f) 
```
Create a shape as a 1-fragment thick line between two points, in OpenGL coordinates.
"""

@document as_line_strip! """
```
as_line_strip!(::Shape, points::Vector{Vector2f}) 
```
Create a shape as a line-strip. For points `{a1, a2, ..., an}`, this will be a set of connected lines `{a1, a2}, {a2, a3}, ..., {an-1, an}`, in OpenGL coordinates.
"""

@document as_lines! """
```
as_lines!(::Shape, points::Vector{Pair{Vector2f, Vector2f}}) 
```
Create a shape as a set of unconnected lines, vertex positions in OpenGL coordinates.
"""

@document as_microseconds """
```
as_microseconds(time::Time) -> Float64
```
Convert to microseconds.
"""

@document as_milliseconds """
```
as_milliseconds(time::Time) -> Float64
```
Convert to milliseconds.
"""

@document as_minutes """
```
as_minutes(time::Time) -> Float64
```
Convert to minutes.
"""

@document as_nanoseconds """
```
as_nanoseconds(time::Time) -> UInt64
```
Convert to number of nanoseconds.
"""

@document as_outline! """
```
as_outline!(self::Shape, other::Shape) 
```
Create a shape as an outline of another shape.
"""

@document as_point! """
```
as_point!(::Shape, position::Vector2f) 
```
Create a shape as 1-fragment point, in OpenGL coordinates.
"""

@document as_points! """
```
as_points!(::Shape, positions::Vector{Vector2f}) 
```
Create a shape as a set of unconnected points, in OpenGL coordinates.
"""

@document as_polygon! """
```
as_polygon!(::Shape, points::Vector{Vector2f}) 
```
Create a shape as a convex polygon, the outer hull of `points` will be computed, but no vertex elimination will take place. In OpenGL coordiantes.
"""

@document as_radians """
```
as_radians(angle::Angle) 
```
Convert to radians, in [0, 2π].
"""

@document as_rectangle! """
```
as_rectangle!(::Shape, top_left::Vector2f, size::Vector2f) 
```
Create a shape as an axis-aligned rectangle, in OpenGL coordinates.
"""

@document as_rectangular_frame! """
```
as_rectangular_frame!(::Shape, top_left::Vector2f, outer_size::Vector2f, x_width::AbstractFloat, y_width::AbstractFloat) 
```
Create a shape as a rectangular frame, where `x_width`, `y_width` are the "thickness" of the frames filled area. In OpenGL coordinates.
"""

@document as_scaled """
```
as_scaled(::Image, size_x::Integer, size_y::Integer, ::InterpolationType) -> Image
```
Scale the image to a new size. This is similar to the "scale image" option in many image manipulation programs.

Note that this does not modify the original image.
"""

@document as_seconds """
```
as_seconds(time::Time) -> Float64
```
Convert to seconds.
"""

@document as_string """
```
as_string(::KeyFile) -> String
```
Serialize file into a string.
"""

@document as_triangle! """
```
as_triangle!(::Shape, a::Vector2f, b::Vector2f, c::Vector2f) 
```
Create a shape as a triangle defined by three points, in OpenGL coordinates.
"""

@document as_wireframe! """
```
as_wireframe!(::Shape, points::Vector{Vector2f}) 
```
Create a shape as a wire-frame. For points `{a1, a2, a3, ..., an}`, the shape
will be a connected series of lines `{a1, a2}, {a2, a3}, ..., {an-1, an}, {an, a1}`. In OpenGL coordinates.
"""

@document attach_to! """
```
attach_to!(popover::Popover, attachment::Widget) 
```
Attach a popover to a widget, which anchors the graphical element of the popover such that it points to the widget.
"""

@document bind """
```
bind(::TextureObject) 
```
Bind a texture for rendering, which will make it available at `GL_TEXTURE_UNIT_0`. This is usually done automatically when a texture was registered with a shape using [`set_texture!`](@ref).
"""

@document bind_as_render_target """
```
bind_as_render_target(render_texture::RenderTexture) 
```
Bind a render texture as the current frame buffer. This should be done inside the signal handler 
of `RenderArea`s signal `render`.

Use [`unbind_as_render_target`](@ref) to restore the previously bound frame buffer.
"""

@document cancel! """
```
cancel!(::FileChooser)
```
Cancel the file chooser, this will behave identically to the user clicking the cancel button.

---

```
cancel!(::FileMonitor) 
```
Cancel the file monitor. It will no longer monitor the file.
"""

@document clear """
```
clear(::RenderArea) 
```
Clear the current framebuffer, this will reset `GL_COLOR_BUFFER_BIT` and replace the contents of the currently bound framebuffer with `RGBA(0, 0, 0, 0)`.
"""

@document clear! """
```
clear!(::Box) 
clear!(::ImageDisplay) 
clear!(::ListView) 
clear!(::ListView, [iterator::ListViewIterator]) 
clear!(::GridView) 
```
Remove all children from the widget.
"""

@document clear_filters! """
```
clear_filters!(::FileChooser)
```
Remove all registered file filters.
"""

@document clear_marks! """
```
clear_marks!(::Scale)
```
Remove all marks added via [`add_mark!`](@ref).
"""

@document clear_render_tasks! """
```
clear_render_tasks!(::RenderArea) 
```
Remove all registered render tasks.
"""

@document clear_shortcuts! """
```
clear_shortcuts!(::Action) 
```
Remove all registered shortcut triggers.
"""

@document close! """
```
close!(::Window) 
```
Attempt to close the window, this will emit signal `close_request`.
"""

@document combine_with """
```
combine_with(self::GLTransform, other::GLTransform) -> GLTransform
```
Perform matrix-multiplication and return the resulting transform, in OpenGL coordinates.
"""

@document contains_file """
```
contains_file(::Clipboard) -> Bool
```
Check whether the cliboard contains a file path.
"""

@document contains_image """
```
contains_image(::Clipboard) -> Bool
```
Check whether the clipboard contains an image.
"""

@document contains_string """
```
contains_string(::Clipboard) -> Bool
```
Check whether the clipboard contains a string.
"""

@document control_pressed """
```
control_pressed(modifier_state::ModifierState) -> Bool
```
Check whether the modifier state indicates that `Control` is currently pressed.
"""

@document copy! """
```
copy!(from::FileDescriptor, to::FileDescriptor, allow_overwrite::Bool ; make_backup::Bool = false, follow_symlink::Bool = false) -> Bool
```
Copy a file from one location to another. Returns `true` if the operation was succesfull.
"""

@document create! """
```
create!(::Image, width::Integer, height::Integer, [color::RGBA]) 
create!(::TextureObject, width::Integer, height::Integer) 
```
Clear the current pixeldata and reinitialize it at given size. Will fille each pixel with `RGBA(0, 0, 0, 0)`, unless otherwise specified.
"""

@document create_as_file_preview! """
```
create_as_file_preview!(image_display::ImageDisplay, file::FileDescriptor) 
```
If the `file` points to an image file, create as a preview for that image, otherwise create from the 
files default icon.
"""

@document create_directory_at! """
```
create_directory_at!(destination::FileDescriptor) -> Bool
```
Create folder at given location, returns `true` if the operation was succesfull.
"""

@document create_file_at! """
```
create_file_at!(destination::FileDescriptor, should_replace::Bool) -> Bool
```
Create file at given location, returns `true` if the operation was succesfull
"""

@document create_from_file! """
```
create_from_file!(::Icon, path::String) -> Bool
create_from_file!(::Image, path::String) -> Bool
create_from_file!(::ImageDisplay, path::String) -> Bool
create_from_file!(::KeyFile, path::String) -> Bool
create_from_file!(::Shader, type::ShaderType, file::String) -> Bool 
```
Initialize the object from a file. Returns `true` if the operation was succesfull.
"""

@document create_from_icon! """
```
create_from_icon!(::ImageDisplay, icon::Icon) 
```
Create as preview of an icon.
"""

@document create_from_image! """
```
create_from_image!(::TextureObject, ::Image) 
create_from_image!(::ImageDisplay, ::Image) 
```
Initialize from an image. This will replace the current pixel data and size.
"""

@document create_from_path! """
```
create_from_path!(::FileDescriptor, path::String) 
```
Create as file descriptor pointing to given path. Use [`exists`](@ref) to check if this location is valid and contains a file or folde.
"""

@document create_from_string! """
```
create_from_string!(::KeyFile, file::String) 
```
De-serialize from a string. If you are loading a `KeyFile` from a file on disk, [`create_from_file!`](@ref) should be preferred.

---

```
create_from_string!(::Shader, type::ShaderType, glsl_code::String) 
```
Create from GLSL code. See the manual chapter on native rendering for more information.
"""

@document create_from_theme! """
```
create_from_theme!(::Icon, theme::IconTheme, id::String, square_resolution::Integer, [scale::Integer = 1]) 
```
Create an icon from the icon theme.
"""

@document create_from_uri! """
```
create_from_uri!(::FileDescriptor, uri::String) 
```
Create as file descriptor pointing to given URI. There is no guarantee that the location exists or points to a valid file or folder.
"""

@document create_monitor """
```
create_monitor(descriptor::FileDescriptor) -> FileMonitor
```
Create a `FileMonitor` monitoring the current file or folder. This may fail if the location does not contain a valid file.
"""

@document degrees """
```
degrees(::Number) -> Angle
```
Create angle from degrees, automatically clamped to [0°, 360°].
"""

@document delete_at! """
```
delete_at!(::FileDescriptor) -> Bool
```
Irreversibly delete file at given location, returns `true` if the operation was succesfull. 
"""

@document device_axis_to_string """
```
device_axis_to_string(axis::DeviceAxis) -> String
```
Serialize the axes identification.
"""

@document destroy! """
```
destroy!(::Window) -> Cvoid
```
Free the internally held reference, causing the window to be deallocated. This is only necessary if [`set_hide_on_close`](@ref) was set to `true`.
"""

@document download """
```
download(texture::TextureObject) -> Image
```
Retrieve the pixel data from the graphics card and return it as an image. This is an extremely costly operation.
"""

@document elapsed """
```
elapsed(clock::Clock) -> Time
```
Get time since the clock was last restarted.
"""

@document exists """
```
exists(::FileDescriptor) -> Bool
```
Check if file location contains a valid file or folder.
"""

@document find """
```
find(::ListView, ::Widget, [::ListViewIterator]) -> Signed
find(::GridView, ::Widget) -> Signed
``` 
Get index of widget in view, or -1 if widget is not part of view.
"""

@document flush """
```
flush(::RenderArea) -> Cvoid
```
Equivalent to `glFlush`, requests for the bound framebuffer to be pushed to the screen. This may not immediately 
update the `RenderArea`.
"""

@document from_gl_coordinates """
```
from_gl_coordinates(area::RenderArea, gl_coordinates::Vector2f) -> Vector2f
```
Convert OpenGL coordinates to absolute widget-space coordinates. This will take into account the `RenderArea`s currently allocated size on screen.
"""

@document get_acceleration_rate """
```
get_acceleration_rate(::SpinButton) -> Float64
```
Get the current rate at which the spin button accelerates when one of the buttons is held down.
"""

@document get_accept_label """
```
get_accept_label(::FileChooser) -> String
```
Get the label used for the "accept" button.
"""

@document get_action """
```
get_action(app::Application, id::String) -> Action
```
Retrieve an action registered with the application.
"""

@document get_adjustment """
```
get_adjustment(::Scale) -> Adjustment
get_adjustment(::SpinButton) -> Adjustment
get_adjustment(::Scrollbar) -> Adjustment
```
Retrieve the adjustment of the widget. Modifying the adjustment will modify the widget, and vice-versa.
"""

@document get_allocated_size """
```
get_allocated_size(::Widget) -> Vector2f
```
Get the size the widget currently occupies on screen, in pixels. If the widget is not currently shown, this function will return `(0, 0)`.
"""

@document get_allow_only_numeric """
```
get_allow_only_numeric(::SpinButton) -> Bool
```
Get whether the spin button only accepts numerical strings for its text-entry.
"""

@document get_angle_delta """
```
get_angle_delta(::RotateEventController) -> Angle
```
Get the difference between the current angle and the angle recognized when the gesture started.
"""

@document get_autohide """
```
get_autohide(::Popover) -> Bool
```
Get whether the popover should automatically hide when it looses focus.
"""

@document get_axis_value """
```
get_axis_value(::StylusEventController, ::DeviceAxis) -> Float32
```
Get value for the devices axis, or 0 if no such axis is present. This value will usually be in `[0, 1]`.
"""

@document get_button_label """
```
get_button_label!(::AlertDialog, index::Integer) -> String
```
Get label of the button at given index (1-based), from left to right.
"""

@document get_bottom_margin """
```
get_bottom_margin(::TextView) -> Float32
```
Get the distance between the bottom of the text and the bottom of the text views frame.
"""

@document get_bounding_box """
```
get_bounding_box(::Shape) -> AxisAlignedRectangle
```
Get the axis-aligned bounding box of the shape. This is the smallest rectangle that contains all vertices, in OpenGL coordinates.
"""

@document get_can_respond_to_input """
```
get_can_respond_to_input(::Widget) -> Bool
```
Get whether the widget can receive and capture input events.
"""

@document get_centroid """
```
get_centroid(::Shape) -> Vector2f
```
Get the centroid of the shape, this is the mathematical average of all its vertices positions, in OpenGL coordinates.
"""

@document get_child_at """
```
get_child_at(::Stack, index::Integer) -> StackID
```
Retrieve the ID of the stack page at given position, or `""` if the index is out of bounds.
"""

@document get_child_position """
```
get_child_position(fixed::Fixed, child::Widget) -> Vector2f
```
Get the fixed location of a child, in absolute widget-space coordinates. If the `Fixed` is not
yet realized, `(0, 0)` will be returned.
"""

@document get_child_x_alignment """
```
get_child_x_alignment(::AspectFrame) -> Float32
```
Get the horizontal alignment of the aspect frames child, in `[0, 1]`.
"""

@document get_child_y_alignment """
```
get_child_y_alignment(::AspectFrame) 
```
Get the vertical alignment of the aspect frames child, in `[0, 1]`.
"""

@document get_children """
```
get_children(descriptor::FileDescriptor ; [recursive = false]) -> Vector{FileDescriptor}
```
Get all children of a folder. If the location pointed to by `descriptor` is a file or does not exist, the resulting vector will be empty.
"""

@document get_clipboard """
```
get_clipboard(::Widget) -> Clipboard
```
Retrieve the clipboard from a widget, which should usually be the top-level window.
"""

@document get_color """
```
get_color(::ColorChooser) -> RGBA
```
Get the currently selected color.
"""

@document get_column_at """
```
get_column_at(column_view::ColumnView, index::Integer) -> ColumnViewColumn
```
Get column at specified position, 1-based.
"""

@document get_column_spacing """
```
get_column_spacing(::Grid) -> Float32
```
Get spacing between columns, in pixels.
"""

@document get_column_with_title """
```
get_column_with_title(column_view::ColumnView, title::String) -> ColumnViewColumn
```
Get column with specified title.
"""

@document get_columns_homogeneous """
```
get_columns_homogeneous(::Grid) -> Bool
```
Get whether all columns should allocate the same width.
"""

@document get_comment_above """
```
get_comment_above(::KeyFile, group::GroupID) -> String
get_comment_above(::KeyFile, group::GroupID, key::KeyID) -> String
```
Get the singular comment above a group or key declaration. 
"""

@document get_content_type """
```
get_content_type(::FileDescriptor) -> String
```
Get the file type as a MIME identification string.
"""

@document get_current_button """
```
get_current_button(gesture::SingleClickGesture) -> ButtonID
```
Get the ID of the button that triggered the current event.
"""

@document get_current_offset """
```
get_current_offset(::DragEventController) -> Vecto2f
```
Get the distance between the current cursor position and the point of origin for the drag-gestured, in absolute widget-space coordinates.
"""

@document get_current_page """
```
get_current_page(::Notebook) -> Int64
```
Get index of currently active page.
"""

@document get_cursor_visible """
```
get_cursor_visible(::TextView) -> Bool
```
Get whether the text caret should be visible.
"""

@document get_delay_factor """
```
get_delay_factor(::LongPressEventController) -> Float32
```
Get multiplier that determines after how much time a long press gesture is recognized, where `1` is no change as compared to the default, `2` is twice as long, `0.5` is half as long.
"""

@document get_destroy_with_parent """
```
get_destroy_with_parent(::Window) -> Bool
```
Get whether the window should be closed and deallocated when its parent window is.
"""

@document get_detailed_description """
```
get_detailed_description(::AlertDIalog) -> String
```
Get detailed message, this is the text shown below the dialogs title.
"""

@document get_editable """
```
get_editable(::TextView) -> Bool
```
Get whether the user can edit the text.
"""

@document get_ellipsize_mode """
```
get_ellipsize_mode(::Label) -> EllipsizeMode
```
Get the ellipsize mode of a label, `ELLIPSIZE_MODE_NONE` by default.
"""

@document get_enabled """
```
get_enabled(::Action) -> Bool
```
Get whether the action is enabled. A disabled action cannot be activated and all its connected widgets are disabled.
"""

@document get_enable_rubberband_selection """
```
get_enable_rubberband_selection(::ListView) -> Bool
get_enable_rubberband_selection(::GridView) -> Bool
get_enable_rubberband_selection(::ColumnView) -> Bool
```
Get whether the user can select multiple children by click-dragging with the cursor. The selectable widgets
selection mode has to be `SELECTION_MODE_MULTIPLE` in order for this to be possible.
"""

@document get_end_child_resizable """
```
get_end_child_resizable(::Paned) -> Bool
```
Get whether the end child should resize when the `Paned` is resized.
"""

@document get_end_child_shrinkable """
```
get_end_child_shrinkable(::Paned) -> Bool
```
Get whether the user can resize the end child such that its allocated area inside the paned is smaller than the natural size of the child.
"""

@document get_expand_horizontally """
```
get_expand_horizontally(::Widget) -> Bool
```
Get whether the widget can expand along the x-axis.
"""

@document get_expand_vertically """
```
get_expand_vertically(::Widget) -> Bool
```
Get whether the widget can expand along the y-axis.
"""

@document get_is_expanded """
```
get_is_expanded(::Expander) -> Bool
```
Get whether the expanders child is currently visible.
"""

@document get_file_chooser_action """
```
get_file_chooser_action(::FileChooser) -> FileChooserAction
```
Get the file chooser action type.
"""

@document get_file_extension """
```
get_file_extension(::FileDescriptor) -> String
```
Get the file extension of the file. This will be the any characters after the last dot.
"""

@document get_fixed_width """
```
get_fixed_width(::ColumnViewColumn) -> Float32
```
Get the target width of the column, in pixels, or `-1` if unlimited.
"""

@document get_focus_on_click """
```
get_focus_on_click(::Widget) -> Bool
```
Get whether the widget should grab focus when it is clicked.
"""

@document get_focus_visible """
```
get_focus_visible(::Window) -> Bool
```
Get whether which widget currently holds input focus should be highlighted using a border.
"""

@document get_fraction """
```
get_fraction(::ProgressBar) -> Float32
```
Get the currently displayed fraction of the progress bar, in `[0, 1]`.
"""

@document get_fragment_shader_id """
```
get_fragment_shader_id(::Shader) -> Cuint
```
Get the native OpenGL handle of the shader program.
"""

@document get_groups """
```
get_groups(::KeyFile) -> Vector{GroupID}
```
Get all group IDs currently present in the key file.
"""

@document get_hardware_id """
```
get_hardware_id(::StylusEventController) -> Cuint
```
Get the native ID of the stylus-device that caused the current event.
"""

@document get_has_base_arrow """
```
get_has_base_arrow(::Popover) -> Bool
```
Get whether the arrow-shaped "tail" of the popover is visible.
"""

@document get_has_border """
```
get_has_border(::Notebook) -> Bool
```
Get whether a border should be drawn around the notebooks perimeter.
"""

@document get_has_close_button """
```
get_has_close_button(::Window) -> Bool
```
Get whether the "x" button is present.
"""

@document get_has_focus """
```
get_has_focus(::Widget) -> Bool
```
Check whether the input currently holds input fcus.
"""

@document get_has_frame """
```
get_has_frame(::Button) -> Bool
get_has_frame(::Viewport) -> Bool
get_has_frame(::Entry) -> Bool
get_has_frame(::PopoverButton) -> Bool 
```
Get whether the widgets outline should be displayed, it will remain interactable.
"""

@document get_has_origin """
```
get_has_origin(::Scale) -> Bool
```
Get whether the area between the origin of the scales trough and the current value should be fille with a solid color.
"""

@document get_has_wide_handle """
```
get_has_wide_handle(::Paned) -> Bool
```
Get whether the barrier in between the paneds two children is wide or thin, wide by default.
"""

@document get_hide_on_close """
```
get_hide_on_close(::Window) -> Bool
```
Get whether the window will be hidden when it is closed, as opposed to destroyed.
"""

@document get_hide_on_overflow """
```
get_hide_on_overflow(::Widget) -> Bool
```
Get whether the entire widget should be hidden if its allocated area is smaller than its natural size. If `false`, the overflow part of the widget will be truncated.
"""

@document get_homogeneous """
```
get_homogeneous(::Box) -> Bool
```
Get whether all of the boxes children should be allocated the same width (or height, if orientation is `ORIENTATION_VERTICAL`).
"""

@document get_horizontal_adjustment """
```
get_horizontal_adjustment(viewport::Viewport) -> Adjustment
```
Get the adjustment controlling the horizontal scrollbar.
"""

@document get_horizontal_alignment """
```
get_horizontal_alignemtn(::Widget) -> Alignment
```
Get alignment along the x-axis.
"""

@document get_horizontal_scrollbar_policy """
```
get_horizontal_scrollbar_policy(::Viewport) -> ScrollbarVisibilityPolicy
```
Get the policy governing how and if the horizontal scrollbar is revealed / hidden.
"""

@document get_icon_names """
```
get_icon_names(theme::IconTheme) -> Vector{String}
```
Get the ID of all icons available in the icon theme.
"""

@document get_id """
```
get_id(::Application) -> ApplicationID
get_id(::Action) -> ActionID
```
Access the ID specified during the objects construction.
"""

@document get_image """
```
get_image(f, ::Clipboard, [::Data_t])
```
Register a callback to read an image from the clipboad. Once the clipboard is ready, the callback will be invoked.

`f` is required to be invocable as a function with signature

```julia
(::Clipboard, ::Image, [::Data_t]) -> Cvoid
```

## Example
```julia
clipboard = get_clipboard(window)
if contains_image(clipboard)
    get_image(clipboard) do x::Clipboard, image::Image
        # use image here
    end
end
```
"""

@document get_inverted """
```
get_inverted(::LevelBar) -> Bool
```
Get whether the level bar should be mirrored along the horizontal or vertical axis, depending on orientation.
"""

@document get_is_active """
```
get_is_active(::CheckButton) -> Bool
get_is_active(::Switch) -> Bool
get_is_active(::ToggleButton) -> Bool
```
Get whether the internal state of the widget is active.
"""

@document get_is_circular """
```
get_is_circular(::Button) -> Bool
get_is_circular(::ToggleButton) -> Bool
get_is_circular(::PopoverButton)  -> Bool
```
Get whether the button is circular (as opposed to rectangular, the default).
"""

@document get_is_decorated """
```
get_is_decorated(::Window) -> Bool
```
Get whether the header bar area of the window is visible.
"""

@document is_executable """
```
is_executable(::FileDescriptor) -> Bool
```
Get whether the file location contains an executable.
"""

@document get_is_focusable """
```
get_is_focusable(::Widget) -> Bool
```
Get whether the widget can grab input focus.
"""

@document get_is_holding """
```
get_is_holding(::Application) -> Bool
```
Get whether [`hold!`](@ref) was called and the application currently blocks attempts at exiting.
"""

@document get_is_horizontally_homogeneous """
```
get_is_horizontally_homogeneous(::Stack) -> Bool
```
Get whether all pages of the stack should allocate the same width.
"""

@document get_is_inverted """
```
get_is_inverted(::ProgressBar) -> Bool
```
Get whether the progress bar should fill from right-to-left, instead of left-to-right
"""

@document get_is_modal """
```
get_is_modal(::Window) -> Bool
get_is_modal(::FileChooser) -> Bool
get_is_modal(::ColorChooser) -> Bool
get_is_modal(::AlertDialog) -> Bool
```
Get whether all other windows should be paused while this window is active.
"""

@document get_is_marked_as_busy """
```
get_is_marked_as_busy(::Application) -> Bool
```
Returns `true` if [`mark_as_busy!`](@ref) was called before.
"""

@document get_is_realized """
```
get_is_realized(::Widget) -> Bool
```
Get whether the widget was initialized and is now shown on screen.
"""

@document get_is_resizable """
```
get_is_resizable(::ColumnViewColumn) -> Bool
```
Get whether the user can choose the width of this column by click-dragging.
"""

@document get_is_scrollable """
```
get_is_scrollable(::Notebook) -> Bool
```
Get whether the user can scroll between pages using the mouse scrollwheel or touchscreen.
"""

@document get_is_spinning """
```
get_is_spinning(::Spinner) -> Bool
```
Get whether the spinners animation is currently playing.
"""

@document get_is_vertically_homogeneous """
```
get_is_vertically_homogeneous(::Stack) -> Bool
```
Get whether the stack should allocate the same height for all its pages.
"""

@document get_is_visible """
```
get_is_visible(::Widget) -> Bool
get_is_visible(::ColumnViewColumn) -> Bool 
```
Get whether the object is currently shown on screen.

---

```
get_is_visible(::Shape) -> Bool
```
Get whether the shape should be omitted from rendering, where `false` means it will be ommitted.
"""

@document get_item_at """
```
get_item_at(::DropDown, i::Integer) -> DropDownID
```
Get ID of the item at given position.
"""

@document get_justify_mode """
```
get_justify_mode(::Label) -> JustifyMode
get_justify_mode(::TextView) -> JustifyMode
```
Get the currently used justify mode.
"""

@document get_keys """
```
get_keys(::KeyFile, group::GroupID) -> Vector{KeyID}
```
Get all keys in this group, or an empty vector if the group does not exist.
"""

@document get_kinetic_scrolling_enabled """
```
get_kinetic_scrolling_enabled(::Viewport) -> Bool
```
Get whether the widget should continue scrolling once the user stopped operating the mouse wheel or touchscreen, simulating "inertia".
"""

@document get_label_x_alignment """
```
get_label_x_alignment(::Frame) -> Float32
```
Get the horizontal alignment of the frames optional label widget, in `[0, 1]`.
"""

@document get_layout """
```
get_layout(::HeaderBar) -> String
```
Get the layout string of the header bar. See the manual section on `HeaderBar` in the chapter on widgets for how layout-syntax works.
"""

@document get_left_margin """
```
get_left_margin(::TextView) -> Float32
```
Get distance between the left side of the text and the `TextView`s frame.
"""

@document get_lower """
```
get_lower(::Adjustment) -> Float32
get_lower(::Scale) -> Float32
get_lower(::SpinButton) -> Float32
```
Get the lower bound of the (underlying) adjustment.
"""

@document get_margin_bottom """
```
get_margin_bottom(::Widget) -> Float32
```
Get the bottom margin of the widget, in pixels.
"""

@document get_margin_end """
```
get_margin_end(::Widget) -> Float32
```
Get the right margin of the widget, in pixels.
"""

@document get_margin_start """
```
get_margin_start(::Widget) -> Float32
```
Get the left margin of the widget, in pixels.
"""

@document get_margin_top """
```
get_margin_top(::Widget) -> Float32
```
Get the top margin of the widget, in pixels.
"""

@document get_max_n_columns """
```
get_max_n_columns(grid_view::GridView) -> Signed
```
Get the maximum number of columns, (or rows if orientation is vertical), or `-1` if unlimited.
"""

@document get_max_value """
```
get_max_value(::LevelBar) -> Float32
```
Get the upper bound of the underlying range.
"""

@document get_max_width_chars """
```
get_max_width_chars(::Entry) -> Signed
get_max_width_chars(::Label) -> Signed
```
Get the maximum number of characters for which the label should allocate horizontal space, or `-1` if unlimited.
"""

@document get_message """
```
get_message(::AlertDialog) -> String
```
Get the current message, this is the title of the dialog.
"""

@document get_min_n_columns """
```
get_min_n_columns(grid_view::GridView) -> Signed
```
Get the minimum number of columns, or `-1` if unlimited.
"""

@document get_min_value """
```
get_min_value(::LevelBar) -> Float32
```
Get the lower bound of the underlying range.
"""

@document get_minimum_size """
```
get_minimum_size(::Widget) -> Vector2f
```
Get the minimum possible size the widget would have to allocate in order for it to be fully visible.
"""

@document get_mode """
```
get_mode(::LevelBar) -> LevelBarMode
```
Get whether the `LevelBar` should display its value as a continuous bar, or segmented.
"""

@document get_n_buttons """
```
get_n_buttons(::AlertDialog) -> Int64
```
Get the number of buttons the dialog currently has.
"""

@document get_n_columns """
```
get_n_columns(::ColumnView) -> Unsigned
```
Get the current number of columns.
"""

@document get_n_digits """
```
get_n_digits(::SpinButton) -> Signed
```
Get the number of digits the spin button should display.
"""

@document get_n_items """
```
get_n_items(::Box) -> Unsigned
get_n_items(::ListView) -> Unsigned
get_n_items(::GridView) -> Unsigned
```
Get the number of children.
"""

@document get_n_pages """
```
get_n_pages(::Notebook) -> Unsigned 
```
Get the number of pages.
"""

@document get_n_pixels """
```
get_n_pixels(::Image) -> Unsigned
```
Get the number of pixels, equal to `width * height`.
"""

@document get_n_rows """
```
get_n_rows(::ColumnView) -> Unsigned
```
Get the current number of rows.
"""

@document get_n_vertices """
```
get_n_vertices(::Shape) -> Unsigned
```
Get the number of OpenGL vertices.
"""

@document get_name """
```
get_name(::Icon) -> String
get_name(::FileDescriptor) -> String 
get_name(::FileFilter) -> String
```
Get a cleartext identifier for the object.
"""

@document get_native_handle """
```
get_native_handle(::TextureObject) -> Cuint
get_native_handle(::Shape) -> Cuint
```
Get the native OpenGL handle of the texture- or vertex buffer.
"""

@document get_natural_size """
```
get_natural_size(::Widget) -> Vector2f
```
Get the size the widget would prefer to display at, if given infinite space and no expansion.
"""

@document get_only_listens_to_button """
```
get_only_listens_to_button(::SingleClickGesture) -> Bool
```
Get whether the event controller should not capture events send by a touch device.
"""

@document get_opacity """
```
get_opacity(::Widget) -> Float32
```
Get the widgets current opacity, in `[0, 1]`.
"""

@document get_orientation """
```
get_orientation(::Box) -> Orientation
get_orientation(::CenterBox) -> Orientation 
get_orientation(::LevelBar) -> Orientation 
get_orientation(::ListView) -> Orientation 
get_orientation(::GridView) -> Orientation 
get_orientation(::Grid) -> Orientation 
get_orientation(::Paned) -> Orientation 
get_orientation(::ProgressBar) -> Orientation 
get_orientation(::Scrollbar) -> Orientation 
get_orientation(::Separator) -> Orientation 
get_orientation(::SpinButton) -> Orientation
get_orientation(::SpinButton) -> Orientation
```
Get whether the widget is oriented horizontally or vertically.

---

```
get_orientation(::PanEventController) -> Orientation 
```
Get along which axis the event controller should recognize pan gestures.
"""

@document get_parent """
```
get_parent(self::FileDescriptor) -> FileDescriptor
```
Get the files parent folder. If `self` points to root or a location that does not exist, the result may be invalid.
"""

@document get_path """
```
get_path(::FileDescriptor) -> String
```
Get the absolute path to the file location.
"""

@document get_path_relative_to """
```
get_path_relative_to(self::FileDescriptor, other::FileDescriptor) -> String
```
Get the relative path from `self` to `other`.
"""

@document get_pixel """
```
get_pixel(image::Image, x::Integer, y::Integer) -> RGBA
```
Get the color of the pixel at given position, 1-indexed.
"""

@document get_position """
```
get_position(::Widget) -> Vector2f
```
Get the current position on screen, relative to the toplevel windows origin, in pixels.

---

```
get_position(::Grid, ::Widget) -> Vector2i
```
Get row- and column-index of the widget, 1-indexed.

---

```
get_position(::Paned) -> Int32
```
Get the offset of the draggable handle, in absolute widget-space coordinates.
"""

@document get_program_id """
```
get_program_id(::Shader) -> Cuint
```
Get the native handle of the OpenGL shader program.
"""

@document get_propagate_natural_height """
```
get_propagate_natural_height(::Viewport) -> Bool
```
Get whether the viewport should assume the natural height of its child.
"""

@document get_propagate_natural_width """
```
get_propagate_natural_width(::Viewport) -> Bool
```
Get whether the viewport should assume the natural width of its child.

"""

@document get_propagation_phase """
```
get_propagation_phase(::EventController) -> PropagationPhase
```
Get the phase at which the event controller will capture events, see [here](https://developer-old.gnome.org/gtk4/stable/event-propagation.html) for more information.
"""

@document get_quick_change_menu_enabled """
```
get_quick_change_menu_enabled(::Notebook) -> Bool
```
Get whether the user can open a menu that lets them skip to any page of the notebook.
"""

@document get_ratio """
```
get_ratio(::AspectFrame) -> Float32
```
Get width-to-height aspect ratio.
"""

@document get_relative_position """
```
get_relative_position(::Popover) -> RelativePosition
get_relative_position(::PopoverButton) -> RelativePosition
```
Get the position of the popover relative to the widget it is attached to.
"""

@document get_is_revealed """
```
get_is_revealed(::Revealer) -> Bool
```
Get whether the revealers child is currently visible.
"""

@document get_right_margin """
```
get_right_margin(::TextView) -> Float32
```
Get distance between the right end of the text and the text views frame.
"""

@document get_row_spacing """
```
get_row_spacing(::Grid) -> Float32
```
Get the margin between two rows, in pixels.
"""

@document get_rows_homogeneous """
```
get_rows_homogeneous(::Grid) -> Bool
```
Get whether all rows should allocate the same height.
"""

@document get_scale """
```
get_scale(::ImageDisplay) -> Signed
```
Get scale factor, in `{1, 2, 3, ...}``.
"""

@document get_scale_delta """
```
get_scale_delta(::PinchZoomEventController) -> Float32
```
Get the difference between the current scale of the pinch-zoom-gesture and the scale at the point the gesture started, in absolute widget-space coordinates.
"""

@document get_scale_mode """
```
get_scale_mode(::TextureObject) -> ScaleMode
```
Get the OpenGL scale mode the texture uses.
"""

@document get_scope """
```
get_scope(::ShortcutEventController) -> ShortcutScope
```
Get the scope in which the controller listens for shortcut events, see [here](https://docs.gtk.org/gtk4/method.ShortcutController.set_scope.html) for more information.
"""

@document get_scrollbar_placement """
```
get_scrollbar_placement(::Viewport) -> CornerPlacement
```
Get the position of both scrollbars relative to the viewports center.
"""

@document get_is_selectable """
```
get_is_selectable(::Label) -> Bool
```
Get whether the user can select part of the label, as would be needed to copy its text.
"""

@document get_selected """
```
get_selected(::DropDown) -> DropDownID
```
Get the ID of the currently selected item.
"""

@document get_selection """
```
get_selection(::SelectionModel) -> Vector{Int64}
```
Get all currently selected items indices, 1-based.
"""

@document get_selection_model """
```
get_selection_model(::ListView) -> SelectionModel
get_selection_model(::GridView) -> SelectionModel
get_selection_model(::Stack) -> SelectionModel
get_selection_model(::ColumnView) -> SelectionModel
```
Get the underlying selection model of the selectable widget.
"""

@document get_selection_mode """
```
get_selection_mode(::SelectionModel) -> SelectionMode
```
Get the underlying selection mode of the model.
"""

@document get_shortcuts """
```
get_shortcuts(action::Action) -> Vector{ShortcutTrigger}
```
Get all registered shortcuts for the action.
"""

@document get_should_draw_value """
```
get_should_draw_value(::Scale) -> Bool
```
Get whether the value of the scales adjustment is drawn next to the knob.
"""

@document get_should_interpolate_size """
```
get_should_interpolate_size(::Stack) -> Bool
```
Get whether the stack should slowly transition its size when switching from one page to another.
"""

@document get_should_snap_to_ticks """
```
get_should_snap_to_ticks(::SpinButton) -> Bool
```
Get whether when the user enters a value using the spin buttons text entry, that value should be clamped to the nearest tick.
"""

@document get_should_wrap """
```
get_should_wrap(::SpinButton) -> Bool
```
Get whether the spin button should over- or underflow when reaching the upper or lower end of its range. This needs to be set to `true` in order for `SpinButton` to emit its signal `wrapped`.
"""

@document get_always_show_arrow """
```
get_always_show_arrow(::DropDown) -> Bool
get_always_show_arrow(::PopoverButton) -> Bool
```
Get whether an arrow should be drawn next to the label.
"""

@document get_show_column_separators """
```
get_show_column_separators(::ColumnView) -> Bool
```
Get whether a separator should be drawn between two columns.
"""

@document get_show_row_separators """
```
get_show_row_separators(::ColumnView) -> Bool
```
Get whether a separator should be drawn between two rows.
"""

@document get_show_separators """
```
get_show_separators(::ListView) -> Bool
```
Get whether a separator should be drawn between two items.
"""

@document get_show_text """
```
get_show_text(::ProgressBar) - Bool
```
Get whether a percentage or custom label should be displayed above the progress bar. User [`set_text!`](@ref) to choose the custom label.
"""

@document get_show_title_buttons """
```
get_show_title_buttons(::HeaderBar) -> Bool
```
Get whether the "close", "minimize", and / or "maximize" button should be visible.
"""

@document get_single_click_activate """
```
get_single_click_activate(::ListView) -> Bool
get_single_click_activate(::GridView) -> Bool
get_single_click_activate(::ColumnView) -> Bool
```
Get whether simply hovering over an item will select it.
"""

@document get_size """
```
get_size(::TextureObject) -> Vector2i
get_size(::Icon) -> Vector2i
get_size(::Image) -> Vector2i
```
Get resolution of the underlying image.

---

```
get_size(::Grid, ::Widget) -> Vector2i
```
Get the number of rows and columns.

---

```
get_size(::Shape) -> Vector2f
```
Get width and height of the axis-aligned bounding box, in OpenGL coordinates.
"""

@document get_size_request """
```
get_size_request(::Widget) -> Vector2f
```
Get the size request, where a `0` for either width or height indicates that no size request was made.
"""

@document get_spacing """
```
get_spacing(::Box) -> Float32
```
Get spacing drawn between any two items, in pixels.
"""

@document get_start_child_resizable """
```
get_start_child_resizable(::Paned) -> Bool
```
Get whether the start child should resize itself when the `Paned` is resized.
"""

@document get_start_child_shrinkable """
```
get_start_child_shrinkable(::Paned) -> Bool
```
Get whether the start child can be resized such that its allocated area in the paned is less than its minimum size.
"""

@document get_start_position """
```
get_start_position(controller::DragEventController) -> Vector2f
```
Get position at which the drag gesture was first recognized, in absolute widget-space coordinates.
"""

@document get_state """
```
get_state(::Action) -> Bool
```
If the action is stateful, get the underlying state, otherwise returns `false`.

---

```
get_state(::CheckButton) -> CheckButtonState
```
Get current state of the check button.
"""

@document get_step_increment """
```
get_step_increment(::Adjustment) -> Float32
get_step_increment(::Scale) -> Float32
get_step_increment(::SpinButton) -> Float32
```
Get minimum step increment of the underlying adjustment. 
"""

@document get_string """
```
get_string(f, clipboard::Clipboard, [::Data_t]) -> Cvoid
```
Register a callback with the signature:

```
(::Clipboad, ::String, [::Data_t]) -> Cvoid
```

When a string is read from the clipboard, the callback will be invoked and the string will be provided as the 
second argument for the callback.

## Example
```julia
clipboard = get_clipboard(window)
if contains_string(clipboard)
    get_string(clipboard) do x::Clipboard, string::String
        # use string here
    end
end
```
"""

@document get_surpress_debug """
```
get_surpress_debug(::LogDomain) -> Bool
```
Get whether log message of level "DEBUG" will be ommitted from the console output.
"""

@document get_surpress_info """
```
get_surpress_info(::LogDomain) -> Bool
```
Get whether log message of level "INFO" will be ommitted from the console output.
"""

@document get_tab_position """
```
get_tab_position(::Notebook) -> RelativePosition
```
Get position of the tab bar relative to the center of the notebook.
"""

@document get_tabs_reorderable """
```
get_tabs_reorderable(::Notebook) -> Bool
```
Get whether the user can reorder tabs.
"""

@document get_tabs_visible """
```
get_tabs_visible(::Notebook) -> Bool
```
Get whether the tab bar is visible.
"""

@document get_target_frame_duration """
```
get_target_frame_duration(::FrameClock) -> Time
```
Get the intended duration of a frame. For example, if the monitor has a refresh rate of 60hz, the target frame duration is `1/60s`.
"""

@document get_text """
```
get_text(::Entry) -> String
get_text(::Label) -> String
get_text(::TextView) -> String
```
Get the content of the underlying text buffer.

---

```
get_text(::ProgressBar) -> String
```
Get text currently displayed by the progress bar, or `""` if the percentage is displayed instead.
"""

@document get_text_visible """
```
get_text_visible(::Entry) -> Bool
```
Get whether the text entry is in "password mode".
"""

@document get_time_since_last_frame """
```
get_time_since_last_frame(::FrameClock) -> Time
```
Get the actual duration of the last rendered frame.
"""

@document get_title """
```
get_title(::Window) -> String
```
Get the window title.

---

```
get_title(::ColumnViewColumn) -> String 
```
Get the title for this column, which uniquely identifies it.
"""

@document get_tool_type """
```
get_tool_type(::StylusEventController) -> ToolType
```
Get the currently set tool type of the stylus device, or `TOOL_TYPE_UNKNOWN` if tool types are not supported.
"""

@document get_top_left """
```
get_top_left(::Shape) -> Vector2f
```
Get the position of the top left corner of the axis-aligned bounding box, in OpenGL coordinates.
"""

@document get_top_margin """
```
get_top_margin(::TextView) -> Float32
```
Get distance between the top of the text and the text views frame.
"""

@document get_touch_only """
```
get_touch_only(::SingleClickGesture) -> Bool
```
Get whether the event controller should exclusively react to events from touch-devices.
"""

@document get_top_level_widget """
```
get_top_level_widget(::Widget) -> Widget
```
Function that maps a non-native compount widget (subtyping `Widget`) to its top-level widget component. 

See the manual section on compound widgets in the chapter on widgets for more information.

## Example
```julia
struct CompoundWidget <: Widget
    box::Box
    CompoundWidget() = new(hbox(Label("this is a compound widget")))
end

mousetrap.get_top_level_widget(x::CompoundWidget) = x.box
# after this definition, `CompoundWidget` can be used like any native mousetrap widget
"""

@document get_transition_duration """
```
get_transition_duration(::Stack) -> Time
get_transition_duration(::Revealer) -> Time
```
Get the duration of the transition animation.
"""

@document get_transition_type """
```
get_transition_type(::Stack) -> StackTransitionType
get_transition_type(::Revealer) -> RevealerTransitionType
```
Get type of animation used for the transition animation.
"""

@document get_uniform_float """
```
get_uniform_float(::RenderTask, name::String) -> Cfloat
```
Get a registered uniform `float`, or `0.0` if no such uniform was registered.
"""

@document get_uniform_int """
```
get_uniform_int(::RenderTask, name::String) -> Cint
```
Get a registered uniform `int`, or `0` if no such uniform was registered.
"""

@document get_uniform_location """
```
get_uniform_location(::Shader, name::String) -> Cuint
```
Get the OpenGL shader program uniform location for the given uniform name, or `0` if no such uniform exists.
"""

@document get_uniform_rgba """
```
get_uniform_rgba(task::RenderTask, name::String) -> RGBA
```
Get uniform `vec4`, or `RGBA(0, 0, 0, 0)` if no such uniform exists.
"""

@document get_uniform_transform """
```
get_uniform_transform(task::RenderTask, name::String) -> GLTransform
```
Get uniform `mat4x4`, or the identity transform if no such uniform exists.
"""

@document get_uniform_uint """
```
get_uniform_uint(::RenderTask, name::String) -> Cuint
```
Get uniform `uint`, or `0` if no such uniform exists.
"""

@document get_uniform_vec2 """
```
get_uniform_vec2(task::RenderTask, name::String) -> Vector2f
```
Get uniform `vec2`, or `Vector2f(0, 0)` if no such uniform exists.
"""

@document get_uniform_vec3 """
```
get_uniform_vec3(task::RenderTask, name::String) 
```
Get uniform `vec3`, or `Vector3f(0, 0, 0)` if no such uniform exists.
"""

@document get_uniform_vec4 """
```
get_uniform_vec4(task::RenderTask, name::String) 
```
Get uniform `vec4`, or `Vector4f(0, 0, 0, 0)` if no such uniform exists.
"""

@document get_upper """
```
get_upper(::Adjustment) -> Float32
get_upper(::Scale) -> Float32
get_upper(::SpinButton) -> Float32
```
Get upper bound of the underlying adjustment.
"""

@document get_uri """
```
get_uri(::FileDescriptor) -> String
```
Transform the descriptors path to URI format.
"""

@document get_use_markup """
```
get_use_markup(::Label) -> Bool
```
Set whether the label should respect [pango markup syntax](https://docs.gtk.org/Pango/pango_markup.html), `true` by default.
"""

@document get_value """
```
get_value(::Adjustment) 
get_value(::SpinButton) 
get_value(::Scale) 
get_value(::LevelBar) 
```
Get current value of the underlying adjustment.

---

```
get_value(file::KeyFile, ::GroupID, ::KeyID, ::Type{<:AbstractFloat}) 
get_value(file::KeyFile, ::GroupID, ::KeyID, ::Type{Vector{T}}) where T <: AbstractFloat 
get_value(file::KeyFile, ::GroupID, ::KeyID, ::Type{<:Signed}) 
get_value(file::KeyFile, ::GroupID, ::KeyID, ::Type{Vector{T}}) where T <: Signed 
get_value(file::KeyFile, ::GroupID, ::KeyID, ::Type{<:Unsigned}) 
get_value(file::KeyFile, ::GroupID, ::KeyID, ::Type{Vector{T}}) where T <: Unsigned 
get_value(file::KeyFile, ::GroupID, ::KeyID, ::Type{Bool}) 
get_value(file::KeyFile, ::GroupID, ::KeyID, ::Type{Vector{Bool}}) 
get_value(file::KeyFile, ::GroupID, ::KeyID, ::Type{String}) 
get_value(file::KeyFile, ::GroupID, ::KeyID, ::Type{Vector{String}}) 
get_value(file::KeyFile, ::GroupID, ::KeyID, ::Type{RGBA}) 
get_value(file::KeyFile, ::GroupID, ::KeyID, ::Type{HSVA}) 
get_value(file::KeyFile, ::GroupID, ::KeyID, ::Type{Image}) 
```
Deserialize a value from the keyfile. Returns a default value if the key-value pair or group does not exist.
"""

@document get_velocity """
```
get_velocity(SwipeEventController) -> Vector2f
```
Get the swipes current velocity, in absolute widget-space coordinates.
"""

@document get_vertex_color """
```
get_vertex_color(::Shape, index::Integer) -> RGBA
```
Get color of the vertex at given index, or `RGBA(0, 0, 0, 0)` if `index` is out of bounds.
"""

@document get_vertex_color_location """
```
get_vertex_color_location() -> Cuint
```
Get the native uniform location for the `_vertex_color` input value of all vertex shaders.
"""

@document get_vertex_position """
```
get_vertex_position(::Shape, ::Integer) -> Vector3f
```
Get the position of vertex at given index, in 3D OpenGL coordinates.
"""

@document get_vertex_position_location """
```
get_vertex_position_location() -> Cuint
```
Get the native uniform location for `_vertex_position` input value of all vertex shaders.
"""

@document get_vertex_shader_id """
```
get_vertex_shader_id(::Shader) -> Cuint
```
Get the native OpenGL handle of vertex shader component of a shader program.
"""

@document get_vertex_texture_coordinate """
```
get_vertex_texture_coordinate(::Shape, index::Integer) -> Vector2f
```
Get the texture coordinate of a vertex at given index, in relative texture-space coordinates.
"""

@document get_vertex_texture_coordinate_location """
```
get_vertex_texture_coordinate_location() -> Cuint
```
Get the native uniform location for `_vertex_texture_coordinate` input value of all vertex shaders.
"""

@document get_vertical_adjustment """
```
get_vertical_adjustment(::Viewport) -> Adjustment
```
Get the underlying adjustment of the vertical scrollbar.
"""

@document get_vertical_alignment """
```
get_vertical_alignment(::Widget) -> Alignment
```
Get widget alignment along the y-axis.
"""

@document get_vertical_scrollbar_policy """
```
get_vertical_scrollbar_policy(::Viewport) -> ScrollbarVisibilityPolicy
```
Get the policy governing how and if the vertical scrollbar is revealed / hidden.
"""

@document get_visible_child """
```
get_visible_child(stack::Stack) -> StackID
```
Get the ID of currently selected child.
"""

@document get_was_modified """
```
get_was_modified(::TextView) -> Bool
```
Get whether the "was modified" flag of a `TextView` was set to `true`. 
"""

@document get_wrap_mode """
```
get_wrap_mode(::Label) -> LabelWrapMode
```
Get the mode use to determine at which point in a line a linebreak will be inserted.

---

```
get_wrap_mode(::TextureObject) -> TextureWrapMode
```
Get the OpenGL texture wrap mode.
"""

@document get_x_alignment """
```
get_x_alignment(::Label) -> Float32
```
Get the horizontal alignment of the labels text.
"""

@document get_y_alignment """
```
get_y_alignment(::Label) -> Float32
```
Get the vertical alignment of the labels text.
"""

@document goto_page! """
```
goto_page!(::Notebook, position::Integer) 
```
Jump to page at given index, or the last page if `position` is out of bounds.
"""

@document grab_focus! """
```
grab_focus!(::Widget) 
```
Attempt to grab input focus. This may fail.
"""

@document has_action """
```
has_action(::Application, id::String) -> Bool
```
Check whether an action with the given ID is registered.
"""

@document has_axis """
```
has_axis(::StylusEventController, ::DeviceAxis) -> Bool
```
Check whether a stylus-device supports the given axis.
"""

@document has_column_with_title """
```
has_column_with_title(::ColumnView, title::String) -> Bool
```
Check whether the `ColumnVIew` has a column with the given title.
"""

@document has_group """
```
has_group(::KeyFile, group::GroupID) -> Bool
```
Check if the `KeyFile` has a group with given id.
"""

@document has_icon """
```
has_icon(::IconTheme, icon::Icon) -> Bool
has_icon(::IconTheme, id::String) -> Bool
```
Check whether icon theme has an icon.
"""

@document has_key """
```
has_key(::KeyFile, group::GroupID, key::KeyID) -> Bool
```
Check whether the key file has a group with the given ID, and whether that group has a key with given ID.
"""

@document hbox """
```
hbox(::Widget...) -> Box
```
Convenience functions that wraps list of a widget in a horizonally oriented box. 
"""

@document hide! """
```
hide!(::Widget) 
```
Hide the widget, this means its allocated size will become `0` and all of its children will be hidden.
"""

@document hold! """
```
hold!(::Application) 
```
Prevent the application from closing. Use [`release!`](@ref) to undo this.
"""

@document hsva_to_rgba """
```
hsva_to_rgba(hsva::HSVA) -> RGBA
```
Convert HSVA to RGBA.
"""

@document html_code_to_rgba """
```
html_code_to_rgba(code::String) -> RGBA
```
Read an html color code of the form `#RRGGBB` or `#RRGGBBAA`, in hexadecimal.
"""

@document insert_at! """
```
insert_at!(::DropDown, index::Integer, label_for_both::String) -> DropDownItemID
insert_at!(::DropDown, index::Integer, list_widget::Widget, label_widget::Widget) -> DropDownItemID
insert_at!(f, ::DropDown, index::Integer, list_widget::Widget, label_widget::Widget, [::Data_t]) -> DropDownItemID
insert_at!(f, ::DropDown, index::Integer, label_for_both::String, [::Data_t]) -> DropDownItemID
```
Add an item to the drop down at given index. When it is selected `label_widget` will appear as the 
child of the drop down, while `list_widget` will be used as the widget displayed when the drop down menu is open.

`f` is called when the corresponding item is select. `f` is required to be invocable as a function with the signature
```
(::DropDown, [::Data_t]) -> Cvoid
```
Returns a unique ID identifying the inserted item.

See the manual section on `DropDown` in the chapter on widgets for more information.

---

```
insert_at!(::Notebook, inde::Integer, child_widget::Widget, label_widget::Widget)
```
Insert a page at the given position, where `child_widget` is the widget used as the page, and `label_widget` is the 
widget displayed in the tab bar.

---

```
insert_at!(::ListView, ::Widget, index::Integer, [::ListViewIterator]) -> ListViewIterator
insert_at!(::GridView, inde::Integer, ::Widget) -> Cvoid
insert_at!(::Grid, ::Widget, row_i::Signed, column_i::Signed, [n_horizontal_cells:Unsigned = 1, n_vertical_cells::Unsigned = 1]) -> Cvoid
```
Insert a widget at the given position.
"""

@document insert_after! """
```
insert_after!(::Box, to_append::Widget, after::Widget) 
```
Insert `to_append` such that it comes right after `after`.
"""

@document insert_column! """
```
insert_column!(column_view::ColumnView, index::Integer, title::String) 
```
Insert a column at the given index.
"""

@document insert_column_at! """
```
insert_column_at!(grid::Grid, column_i::Signed) 
```
Insert an empty column after the given index (may be negative).
"""

@document insert_next_to! """
```
insert_next_to!(::Grid, to_insert::Widget, already_in_grid::Widget, position::RelativePosition, [n_horizontal_cells:Unsigned = 1, n_vertical_cells::Unsigned = 1]) -> Cvoid
```
Insert widget into a grid such that it is now next to `already_in_grid`, where `position` describes the relative position of `already_in_grid` to `to_insert`.
"""

@document insert_row_at! """
```
insert_row_at!(grid::Grid, row_i::Signed) 
```
Insert an empty row after the given index (may be negative).
"""

@document is_cancelled """
```
is_cancelled(::FileMonitor) -> Bool
```
Check whether the file monitor has be cancelled.
"""

@document is_file """
```
is_file(::FileDescriptor) -> Bool
```
Check whether the location on disk contains points to a valid file (not folder).
"""

@document is_folder """
```
is_folder(::FileDescriptor) -> Bool
```
Check whether the location on disk contains points to a valid folder (not file).
"""

@document get_is_local """
```
get_is_local(::Clipboard) -> Bool
```
Check whether the content of the cliboard was set from within the currently active mousetrap application.
"""

@document is_symlink """
```
is_symlink(::FileDescriptor) -> Bool
```
Get whether the location on disk is a valid symbolic link.
"""

@document is_valid_html_code """
```
is_valid_html_code(code::String) -> Bool
```
Check whether `code` is a string that can be converted to a color using [`html_code_to_rgba`](@ref).
"""

@document main """
```
main(f; application_id::ApplicationID) 
```
Run `f`, it is required to be invocable as a function with signature
```
(::Application, [::Data_t]) -> Cvoid
```

This functions automatically creates an application with given ID and starts the main loop. If an error occurrs
during `f`, the application safely exits.

## Example
```julia
using mousetrap
main() do app::Application
    window = Window(app)
    present!(window)
end
"""

@document log_debug """
```
log_debug(::LogDomain, message::Sting)
@log_debug(::LogDomain, message::Sting)
```
Display a log message with level `DEBUG`. Messages of
this level will only be displayed once `set_surpress_debug!`
is set to `false` for this log domain.
    
If [`set_log_file!`](@ref) was called before, the message will also be appended to that file.
"""

@document log_info """
```
log_info(::LogDomain, message::Sting)
@log_info(::LogDomain, message::Sting)
```
Display a log message with level `INFO`. If [`set_log_file!`](@ref) was called before, the message will also be appended to that file.
"""

@document log_warning """
```
log_warning(::LogDomain, message::Sting)
@log_warning(::LogDomain, message::Sting)
```
Display a log message with level `WARNING`. If [`set_log_file!`](@ref) was called before, the message will also be appended to that file.
"""

@document log_critical """
```
log_critical(::LogDomain, message::Sting)
@log_critical(::LogDomain, message::Sting)
```
Display a log message with level `CRITICAL`. If [`set_log_file!`](@ref) was called before, the message will also be appended to that file.
"""

@document log_fatal """
```
log_fatal(::LogDomain, message::Sting)
@log_fatal(::LogDomain, message::Sting)
```
Dispay a log message with level `FATAL`. Immediately after, runtime ends.
"""

@document make_current """
```
make_current(::RenderArea) 
```
Bind the associated frame buffer as the one currently being rendered to. This is usually not necessary.
"""

@document mark_as_busy! """
```
mark_as_busy!(::Application) 
```
Mark the application as busy, this will tell the OS that the application is currently processing something.
"""

@document microseconds """
```
microseconds(n::AbstractFloat) -> Time
```
Create time from number of microseconds.
"""

@document milliseconds """
```
milliseconds(n::AbstractFloat) -> Time
```
Create time from number of milliseconds.
"""

@document minutes """
```
minutes(n::AbstractFloat) -> Time
```
Create time from number of minutes.
"""

@document mouse_button_01_pressed """
```
mouse_button_01_pressed(::ModifierState) -> Bool
```
Check whether the modifier state indicates that the left mouse button is currently pressed.
"""

@document mouse_button_02_pressed """
```
mouse_button_02_pressed(::ModifierState) -> Bool
```
Check whether the modifier state indicates that the right mouse button is currently pressed.
"""

@document move! """
```
move!(from::FileDescriptor, to::FileDescriptor, allow_overwrite::Bool ; [make_backup::Bool = false, follow_symlink::Bool = true]) -> Bool 
```
Move a file to a different location. Returns `true` if the operation was succesfull.
"""

@document move_page_to! """
```
move_page_to!(::Notebook, current_index::Integer, new_index::Integer)
```
Move notebook page at position `current_index` to position `new_index`, 1-based. This will emit signal `page_reordered`.
"""

@document move_to_trash! """
```
move_to_trash!(file::FileDescriptor) ::Bool
```
Safely move the file to the operating system garbage bin. This operation can be undone by the user. Returns `true` if the operation was succesfull.
"""

@document nanoseconds """
```
nanoseconds(n::Integer) -> Time
```
Create time from number of nanoseconds.
"""

@document next_page! """
```
next_page!(::Notebook) 
```
Go to the next page, if possible.
"""

@document on_accept! """
```
on_accept!(f, chooser::FileChooser, [::Data_t]) 
```
Register a callback to be called when the user clicks the "accept" button.

`f` is required to be invocable as a function with signature
```
(::FileChooser, ::Vector{FileDescriptor}, [::Data_t]) -> Cvoid
```

## Example
```julia
file_chooser = FileChooser(FILE_CHOOSER_ACTION_OPEN_FILE)
on_accept!(file_chooser) do x::FileChooser, files::Vector{FileDescriptor}
   # use `files` here
end
````
---

```
on_accept!(f, chooser::ColorChooser, [::Data_t]) 
```
Register a callback to be called when the users makes a color selection. `f` is required to be invocable as a function with signature:
```
(::FileChooser, ::RGBA, [::Data_t]) -> Cvoid
```

## Example
```julia
color_chooser = ColorChooser()
on_accept!(color_chooser) do self::ColorChooser, color::RGBA
   # use `color` here
end
```
"""

@document on_cancel! """
```
on_cancel!(f, chooser::FileChooser, [::Data_t]) 
```
Register a callback to be called when the user clicks the "cancel" button f the file chooser. 
`f` is required to be invocable as a function with signature
```
(::FileChooser, [::Data_t]) -> Cvoid
```

## Example
```julia
file_chooser = FileChooser(FILE_CHOOSER_ACTION_OPEN_FILE)
on_cancel!(file_chooser) do x::FileChooser
    println("file selection cancelled.")
end
```

---

```
on_cancel!(f, chooser::ColorChooser, [::Data_t]) 
```
Register a callback to be called the users cancels color selection or otherwise closes the dialog. `f` is required to be invocable as a function with signature:
```
(::FileChooser, [::Data_t]) -> Cvoid
```

## Example
```julia
color_chooser = ColorChooser()
on_cancel!(color_chooser) do self::ColorChooser
    println("color selection cancelled")
end
````
"""

@document on_file_changed! """
```
on_file_changed!(f, monitor::FileMonitor, [::Data_t]) 
```
Register a callback to be called when the monitored file is modified. `f` is required to be 
invocable as a function with signature 
```
(::FileMonitor, ::FileMonitorEvent, self::FileDescriptor, other::FileDescriptor) -> Cvoid
```
Where `other` may not point to a valid file, depending on the event type.

## Example
```julia
file = FileDescriptor("path/to/file.jl")
@assert(exists(file))
monitor = create_monitor(file)
on_file_changed!(monitor) do x::FileMonitor, event_type::FileMonitorEvent, self::FileDescriptor, other::FileDescriptor
    if event_type == FILE_MONITOR_EVENT_CHANGED
        println("File at " * get_path(self) * " was modified.")
    end
end
```
"""

@document on_selection! """
```
on_selection!(f, ::AlertDialog, [::Data_t])
```
Register a callback to be called when the user clicks one of the dialogs buttons or dismisses the dialog. `f` is required to be invocable as a function with signature
```
(::AlertDialog, button_index::Signed, [::Data_t]) -> Cvoid
```
Where `button_index` is the index of the current button (1-based), or `0` if the dialog was dismissed.

## Example
```
alert_dialog = AlertDialog(["Yes", "No"], "Is this is a dialog?")
on_selection!(alert_dialog) do self::AlertDialog, button_index::Signed
    if button_index == 0
        println("User dismissed the dialog")
    else
        println("User chose \$(get_button_label(self, button_index))")
    end
end
present!(alert_dialog)
```
"""

@document open_file """
```
open_file(::FileDescriptor) -> Cvoid
```
Asynchronously launch the default application to open the file or folder. May present the users with a list of applications they can choose from.
"""

@document open_url """
```
open_url(uri::String) -> Cvoid
```
Asynchronously launch the default application to open the uri. This will usually be the users web browser
"""

@document popdown! """
```
popdown!(::Popover) 
popdown!(::PopoverButton) 
```
Close the popover window.
"""

@document popup! """
```
popup!(::Popover) 
popup!(::PopoverButton) 
```
Present the popover window.
"""

@document present! """
```
present!(::Window) 
present!(::Popover) 
present!(::FileChooser) 
present!(::ColorChooser)
present!(::AlertDialog)
```
Show the window to the user.
"""

@document previous_page! """
```
previous_page!(::Notebook) 
```
Go to the previous page, if possible.
"""

@document pulse """
```
pulse(::ProgressBar) 
```
Trigger an animation that signifies to the user that progress has been made. This does not actually increase 
the displayed ratio of the progress bar.
"""

@document push_back! """
```
push_back!(::Box, ::Widget) -> Cvoid
push_back!(::ListView, ::Widget, [::ListViewIterator]) -> ListViewIterator 
push_back!(::GridView, ::Widget) -> Cvoid
push_back!(::HeaderBar, ::Widget) -> Cvoid
```
Add a widget to the end of the container.

---

```
push_back!(::DropDown, label_for_both::String) -> DropDownItemID
push_back!(::DropDown, list_widget::Widget, label_widget::Widget) -> DropDownItemID
push_back!(f, drop_down::DropDown, list_widget::Widget, label_widget::Widget, [::Data_t]) -> DropDownItemID
push_back!(f, drop_down::DropDown, label_for_both::String, [::Data_t]) -> DropDownItemID
```
Add an item to the end of the drop down. When it is selected `label_widget` will appear as the 
child of the drop down, while `list_widget` will be used as the widget displayed when the drop down menu is open.

`f` is called when the corresponding item is select. `f` is required to be invocable as a function with the signature
```
(::DropDown, [::Data_t]) -> Cvoid
```
Returns a unique ID identifying the inserted item.

See the manual section on `DropDown` in the chapter on widgets for more information.

---

```
push_back!(::Notebook, inde::Integer, child_widget::Widget, label_widget::Widget) 
```
Insert a page at the end of the notebook, where `child_widget` is the widget used as the page, and `label_widget` is the 
widget displayed in the tab bar.
"""

@document push_back_column! """
```
push_back_column!(::ColumnView, title::String) -> ColumnViewColumn
```
Add a column to the end of the column view.
"""

@document push_back_row! """
```
push_back_row!(column_view::ColumnView, widgets::Widget...) -> Cvoid
```
Add a number of widgets to the end of the rows, inserting them into the corresponding column. If the number of widgets is
lower than the number of columns, the left-over columns will contain an empty cell in that row. 
"""

@document push_front! """
```
push_front!(::Box, ::Widget) -> Cvoid
push_front!(::ListView, ::Widget, [::ListViewIterator]) -> ListViewIterator 
push_front!(::GridView, ::Widget) -> Cvoid
push_front!(::HeaderBar, ::Widget) -> Cvoid
```
Add a widget to the start of the container.

---

```
push_back!(::DropDown, label_for_both::String) -> DropDownItemID
push_back!(::DropDown, list_widget::Widget, label_widget::Widget) -> DropDownItemID
push_front!(f, drop_down::DropDown, list_widget::Widget, label_widget::Widget, [::Data_t]) -> DropDownItemID
push_front!(f, drop_down::DropDown, label_for_both::String, [::Data_t]) -> DropDownItemID
```
Add an item to the start of the drop down. When it is selected `label_widget` will appear as the 
child of the drop down, while `list_widget` will be used as the widget displayed when the drop down menu is open.

`f` is called when the corresponding item is select. `f` is required to be invocable as a function with the signature
```
(::DropDown, [::Data_t]) -> Cvoid
```
Returns a unique ID identifying the inserted item.

See the manual section on `DropDown` in the chapter on widgets for more information.

---

```
push_front!(::Notebook, inde::Integer, child_widget::Widget, label_widget::Widget) 
```
Insert a page at the start of the notebook, where `child_widget` is the widget used as the page, and `label_widget` is the 
widget displayed in the tab bar.
"""

@document push_front_column! """
```
push_front_column!(column_view::ColumnView, title::String) -> ColumnViewColumn
```
Add a column to the start of the column view.
"""

@document push_front_row! """
```
push_front_row!(column_view::ColumnView, widgets::Widget...) -> Cvoid
```
Add a number of widgets to the start of the rows, inserting them into the corresponding column. If the number of widgets is
lower than the number of columns, the leftover columns will contain an empty cell in that row. 
"""

@document query_info """
```
query_info(::FileDescriptor, attribute_id::String) -> String
```
Access metadata info about a file. A list of attribute IDs can be found [here](https://gitlab.gnome.org/GNOME/glib/-/blob/main/gio/gfileinfo.h#L46).
Note that there is no guarantee that a file will contain a value for any of these attributes.
"""

@document queue_render """
```
queue_render(::RenderArea) 
```
Request for the `RendeArea` to performa a render cycle and flush the current framebuffer to the screen. There is no guarantee that this 
will happen immediately.
"""

@document quit! """
```
quit!(::Application) 
```
Exit the application.
"""

@document radians """
```
radians(::Number) -> Angle
```
Construct angle from radians.
"""

@document read_symlink """
```
read_symlink(self::FileDescriptor) -> FileDescriptor
```
If the file location is a valid symlink, follow that symlink and return the resulting file.
"""

@document redo! """
```
redo!(::TextView) 
```
Invoke the "redo!" keybinding signal. If there is no action on the undo stack, this function does nothing.
"""

@document release! """
```
release!(::Application) 
```
Release an application that is currently being prevented from exiting because [`hold!`](@ref) was called before.
"""

@document remove! """
```
remove!(::Box, ::Widget) -> Cvoid
remove!(::ListView, index::Integer, [::ListViewIterator]) -> Cvoid 
remove!(::GridView, ::Widget) -> Cvoid
remove!(::Grid, ::Widget) -> Cvoid
remove!(::HeaderBar, ::Widget) -> Cvoid
remove!(::DropDown, item_id::DropDownItemID) -> Cvoid
remove!(::Notebook, position::Integer) -> Cvoid
```
Remove an item from the container.
"""

@document remove_action! """
```
remove_action!(::Application, id::String) 
```
Unregister an action from the application. Any connected widgets such as `Button` or `MenuModel` 
will be disabled.

---

```
remove_action!(::ShortcutEventController, ::Action) 
```
Remove an action, such that the controller will not longer trigger it if any of its shortcuts are recognized.
"""

@document remove_button! """
```
remove_button!(::AlertDialog, index::Signed) 
```
Remove the button at given position (1-based, left-to-right), this means all buttons after it have their index shifted by 1. 
"""

@document remove_center_child! """
```
remove_center_child!(::CenterBox) 
```
Remove the middle child of the center box.
"""

@document remove_child! """
```
remove_child!(::Fixed, child::Widget) 
remove_child!(::Window) 
remove_child!(::AspectFrame) 
remove_child!(::Button) 
remove_child!(::CheckButton) 
remove_child!(::ToggleButton) 
remove_child!(::Expander) 
remove_child!(::Frame) 
remove_child!(::Overlay) 
remove_child!(::Popover) 
remove_child!(::PopoverButton) 
remove_child!(::Stack, id::String) 
remove_child!(::Revealer) 
remove_child!(::Viewport) 
```
Remove the widgets singular child, such that it is now empty.
"""

@document remove_column! """
```
remove_column!(::ColumnView, column::ColumnViewColumn) 
```
Remove a column from the column view, this also frees all of its rows.
"""

@document remove_column_at! """
```
remove_column_at!(::Grid, column_i::Signed)
```
Remove column at given index (1-based, may be negative). Any following columns will be shifted to the left.
"""

@document remove_controller! """
```
remove_controller!(::Widget, controller::EventController) 
```
Disconnect an event controller.
"""

@document remove_end_child! """
```
remove_end_child!(::CenterBox) 
remove_end_child!(::Paned) 
```
Remove the latter child of the widget.
"""

@document remove_label_widget! """
```
remove_label_widget!(::Expander) 
remove_label_widget!(::Frame) 
```
Remove the label widget of the widget, such that it now has no label widget.
"""

@document remove_marker! """
```
remove_marker!(::LevelBar, name::String) 
```
Remove a marker with the given label from the level bar.
"""

@document remove_overlay! """
```
remove_overlay!(overlay::Overlay, overlayed::Widget) 
```
Remove an overlaid widget added via [`add_overlay!`](@ref).
"""

@document remove_popover! """
```
remove_popover!(::PopoverButton) 
```
Remove the connected `Popover` or `PopoverMenu`.
"""

@document remove_primary_icon! """
```
remove_primary_icon!(::Entry) 
```
Remove the left icon of the entry.
"""

@document remove_row_at! """
```
remove_row_at!(grid::Grid, row_i::Signed) 
```
Remove a row at specified position (1-based).
"""

@document remove_secondary_icon! """
```
remove_secondary_icon!(::Entry) 
```
Remove the right icon of the entry.
"""

@document remove_start_child! """
```
remove_start_child!(::Paned) 
remove_start_child!(::CenterBox) 
```
Remove the start child such that the widget is now empty at that position
"""

@document remove_tick_callback! """
```
remove_tick_callback!(::Widget) 
```
Remove a registered tick callback. Usually, this should be done by returning `TICK_CALLBACK_RESULT_DISCONTINUE` from
within the tick callback function.
"""

@document remove_titlebar_widget! """
```
remove_titlebar_widget!(::Window) 
```
Reset the titlebar widget such that the default window decoration is used instead.
"""

@document remove_title_widget! """
```
remove_title_widget!(::HeaderBar)
```
Remove widget that is currently used as the title element.
"""

@document remove_tooltip_widget! """
```
remove_tooltip_widget!(::Widget) 
```
Remove the tooltip widget. The widget will now no longer display a tooltip.
"""

@document render """
```
render(::RenderTask) 
render(shape::Shape, shader::Shader, transform::GLTransform) 
```
Draw a shape to the currently bound framebuffer, forwarding the transform to the vertex shader and applying the
fragment shader to all fragments of the shape.

Note that calling this function is usually not necessary, instead, regsiter a `RenderTask` with a `RenderArea` 
using `add_render_task!`, after which the task will be automatically rendered every frame, unless a custom
signal handler was connected to `RenderArea`s signal `render`.
"""

@document render_render_tasks """
```
render_render_tasks(::RenderArea) 
```
Render all registered render tasks. This is only necessary when a custom signal handler is connected to the areas
signal `render`.
"""

@document reset! """
```
reset!(::GLTransform) 
```
Override the transform such that it is now the identity transform.
"""

@document reset_text_to_value_function! """
```
reset_text_to_value_function!(::SpinButton) 
```
Reset the function registered using `set_text_to_value_function!`, using the default handler instead.
"""

@document reset_value_to_text_function! """
```
reset_value_to_text_function!(::SpinButton) 
```
Reset the function registered using `set_value_to_text_function!`, using the default handler instead.
"""

@document restart! """
```
restart!(clock::Clock) -> Time
```
Restart the clock and return the elapsed time since the last restart.
"""

@document rgba_to_hsva """
```
rgba_to_hsva(rgba::RGBA) -> HSVA
```
Convert RGBA to HSVA.
"""

@document rgba_to_html_code """
```
rgba_to_html_code(rgba::RGBA) -> String
```
Convert the color to an html-style hexadecimal string of the form `#RRGGBB`. The alpha component is ignored.
"""

@document rotate! """
```
rotate!(::GLTransform, angle::Angle, [origin::Vector2f]) 
rotate!(::Shape, angle::Angle, [origin::Vector2f]) 
```
Rotate around a point, in OpenGL coordinates.
"""

@document run! """
```
run!(app::Application) -> Cint
```
Start the main loop, initializing the internal state and triggering `Application`s signal `activate`. Note that 
no part of mousetrap should be used or initialized before this function is called.

Usually, users are encouraged to use [`main`](@ref) instead, which does this automatically.

## Example
```julia
app = Application("example.app")
connect_signal_activate!(app) app::app
    # all initialization should happen here
end
run(app) # start the main loop
```
"""

@document save_to_file """
```
save_to_file(::Image, path::String) -> Bool
```
Save the image to a file, the file format is automatically determined based on the extension of the given path.

Returns `true` if the operation was successfull.

---

```
save_to_file(::KeyFile, path::String) -> Bool
```
Serialize the key file to a string and save that string to a file. Usually, the extension for this file should be `.ini`.

Returns `true` if the operation was successfull
"""

@document scale! """
```
scale!(::GLTransform, x_scale::AbstractFloat, y_scale::AbstractFloat) 
```
Combine the transform with a scale transform. To scale around a point, first `translate!` the transform to that point, 
then apply `scale!`, then `translate!` the transform back to origin.

Uses the OpenGL coordinate system.
"""

@document seconds """
```
seconds(n::AbstractFloat) -> Time
```
Create from number of seconds.
"""

@document select! """
```
select!(::SelectionModel, i::Integer, [unselect_others::Bool = true]) 
```
Select item at given position, this will emit signal `selection_changed`.
"""

@document select_all! """
```
select_all!(::SelectionModel) 
```
Select all items, triggering emission of signal `selection_changed`. This is only possible if the selection mode is `SELECTION_MODE_MULTIPLE`.
"""

@document self_is_focused """
```
self_is_focused(::FocusEventController) -> Bool
```
Check if the widget the controller was added to currently holds focus. 
"""

@document self_or_child_is_focused """
```
self_or_child_is_focused(::FocusEventController) -> Bool
```
Check if the widget the controller was added to, or any of the widgets children currently hold focus.
"""

@document set_acceleration_rate! """
```
set_acceleration_rate!(::SpinButton, factor::AbstractFloat) 
```
Set the rate at which the spin buttons value accelerates when a button is held down, where `0.0` is default rate, `0.1` is 10%, `1.0` is 100%, etc. May not be negative.
"""

@document set_accept_label! """
```
set_accept_label!(::FileChooser, label::String) 
```
Set the label used for the "accept" button of the file chooser.
"""

@document set_action! """
```
set_action!(::Button, ::Action) 
```
Connect an action to the button. When the button is clicked, the action is activated. When the action is disabled, the button is also disabled.

Note that a button can have both an action and a signal handler connected. If this is the case and the button is clicked, both 
are triggered.
"""

@document set_active! """
```
set_active!(::CheckButton, ::Bool)
```
If `true`, set the check button state to [`CHECK_BUTTON_STATE_ACTIVE`](@ref), otherwise set to [`CHECK_BUTTON_STATE_INACTIVE`](@ref).
"""

@document set_alignment! """
```
set_alignment!(::Widget, both::Alignment) 
```
Set both the horizontal and vertical alignment of a widget at the same time.
"""

@document set_allow_only_numeric! """
```
set_allow_only_numeric!(::SpinButton, ::Bool) 
```
Set whether the spin button should only accept numeric text entry, as opposed to alphanumeric.
"""

@document set_always_show_arrow! """
```
set_always_show_arrow!(::DropDown, ::Bool) 
set_always_show_arrow!(::PopoverButton, ::Bool) 
```
Set wether an arrow should be drawn next to the label.
"""

@document set_application! """
```
set_application!(window::Window, app::Application) 
```
Register the window with the application. This is usually done automatically.
"""

@document set_autohide! """
```
set_autohide!(::Popover, ::Bool) 
```
Set whether the popover should hide itself when the attached widget looses focus.
"""

@document set_button_label! """
```
set_button_label!(::AlertDialog, index::Integer, label::String)
```
Replace the label of the button at given position (1-based, left-to-right).
"""

@document set_bottom_margin! """
```
set_bottom_margin!(::TextView, margin::AbstractFloat) 
```
Set margin between the bottom of the text and the text views frame.
"""

@document set_can_respond_to_input! """
```
set_can_respond_to_input!(::Widget, ::Bool) 
```
Set whether the widget can receive input events. If set to `false`, the widget may appear "greyed out", signaling to the user that it is inactive.
"""

@document set_center_child! """
```
set_center_child!(::CenterBox, ::Widget) 
```
Set the middle child of the center box.
"""

@document set_centroid! """
```
set_centroid!(::Shape, centroid::Vector2f) 
```
Move the shape such that its centroid is now at given position, in OpenGL coordinates.
"""

@document set_child! """
```
set_child!(::Window, child::Widget) 
set_child!(::AspectFrame, child::Widget) 
set_child!(::Button, child::Widget) 
set_child!(::CheckButton, child::Widget) 
set_child!(::ToggleButton, child::Widget) 
set_child!(::Viewport, child::Widget) 
set_child!(::Expander, child::Widget) 
set_child!(::Frame, child::Widget) 
set_child!(::Overlay, child::Widget) 
set_child!(::Popover, child::Widget) 
set_child!(::PopoverButton, child::Widget) 
set_child!(::Revealer, child::Widget) 
```
Set the widgets singular child.
"""

@document set_child_position! """
```
set_child_position!(::Fixed, child::Widget, position::Vector2f) 
```
Set fixed position of the child, in absolute widget-space coordinates.
"""

@document set_child_x_alignment! """
```
set_child_x_alignment!(::AspectFrame, alignment::AbstractFloat) 
```
Set horizontal alignment of the aspect frames child. `0.5` by default.
"""

@document set_child_y_alignment! """
```
set_child_y_alignment!(::AspectFrame, alignment::AbstractFloat) 
```
Set vertical alignment of the aspect frames child. `0.5` by default.
"""

@document set_color! """
```
set_color!(::Shape, ::RGBA)
set_color!(::Shape, ::HSVA)
```
Set the color of all vertices of the shape.
"""

@document set_column_spacing! """
```
set_column_spacing!(::Grid, spacing::AbstractFloat) 
```
Set spacing between two columns of the grid, in pixels.
"""

@document set_columns_homogeneous! """
```
set_columns_homogeneous!(::Grid, ::Bool) 
```
Set whether all columns of the grid should be the same width.
"""

@document set_comment_above! """
```
set_comment_above!(::KeyFile, ::GroupID, comment::String) 
set_comment_above!(::KeyFile, ::GroupID, ::KeyID, comment::String) 
```
Set the singular comment above a group or key-value pair in the file.
"""

@document set_current_blend_mode """
```
set_current_blend_mode(::BlendMode; allow_alpha_blending::Bool = true) 
```
Enable GPU-side blending and set the current OpenGL blend mode. If `allow_alpha_blending` is set to `false`, 
only the rgb components of a fragments color will participate in blending.
"""

@document set_cursor! """
```
set_cursor!(::Widget, cursor::CursorType) 
```
Set which cursor shape should be used when the cursor is over the allocated area of the widget.
"""

@document set_cursor_from_image! """
```
set_cursor_from_image!(::Widget, image::Image, [offset::Vector2i = Vector2i(0, 0)]) 
```
Set which image should be displayed when the cursor is over the allocated area of the widget. `offset` 
determines the vertical and horizontal offset of the center of the image, relative to the cursor position, in pixels.
"""

@document set_cursor_visible! """
```
set_cursor_visible!(::TextView, ::Bool) 
```
Set whether the caret is visible.
"""

@document set_default_widget! """
```
set_default_widget!(window::Window, ::Widget) 
```
Designate a widget as the default widget. When the window is activated, for example by the user 
pressing the enter key, the default widget is activated.
"""

@document set_delay_factor! """
```
set_delay_factor!(::LongPressEventController, factor::AbstractFloat) 
```
Set a factor that multiplies the default delay after which a longpress gesture is recognized.
"""

@document set_destroy_with_parent! """
```
set_destroy_with_parent!(::Window, ::Bool) 
```
Set whether the window should close and be destroyed when the toplevel window is closed.
"""

@document set_detailed_description! """
```
set_detailed_description(::AlertDialog, message::String)
```
Set the detailed message, this is the text shown below the dialogs title.
"""

@document set_editable! """
```
set_editable!(::TextView, ::Bool) 
```
Set whether the user can edit the text in the text view.
"""

@document set_ellipsize_mode! """
```
set_ellipsize_mode!(::Label, mode::EllipsizeMode) 
```
Set the ellipsize mode of a label, `ELLIPSIZE_MODE_NONE` by default.
"""

@document set_enable_rubberband_selection! """
```
set_enable_rubberband_selection!(::ListView, ::Bool) 
set_enable_rubberband_selection!(::GridView, ::Bool) 
set_enable_rubberband_selection!(::ColumnView, ::Bool) 
```
Set whether the user can select multiple children by holding down the mouse button and click-dragging. The selectable widgets
selection mode has to be `SELECTION_MODE_MULTIPLE` in order for this to be possible.
"""

@document set_enabled! """
```
set_enabled!(::Action, ::Bool) 
```
Set whether the action is enabled. If set to `false`, all connected buttons and menu items 
will be disabled as well.
"""

@document set_end_child! """
```
set_end_child!(::CenterBox, child::Widget) 
set_end_child!(::Paned, child::Widget) 
```
Set the latter child of the widget.
"""

@document set_end_child_resizable! """
```
set_end_child_resizable!(::Paned, ::Bool) 
```
Set whether the end child should resize when the `Paned` is resized.
"""

@document set_end_child_shrinkable! """
```
set_end_child_shrinkable!(::Paned, ::Bool)
```
Set whether the user can resize the end child such that its allocated area inside the paned is smaller than the natural size of the child.
"""

@document set_expand! """
```
set_expand!(::Widget, ::Bool) 
```
Set whether the widget should expand along both the horizontal and vertical axis.
"""

@document set_is_expanded! """
```
set_is_expanded(::Expander, ::Bool) 
```
Automatically expand or hide the expanders child.
"""

@document set_expand_horizontally! """
```
set_expand_horizontally!(::Widget, ::Bool) 
```
Set whether the widget should expand along the x-axis.
"""

@document set_expand_vertically! """
```
set_expand_vertically!(::Widget, ::Bool) 
```
Set whether the widget should expand along the y-axis.
"""

@document set_file! """
```
set_file!(::Clipboard, file::FileDescriptor) 
```
Override the content of the clipboard with a path to a file. Use [`get_string`](@ref) to retrieve it.
"""

@document set_file_chooser_action! """
```
set_file_chooser_action!(::FileChooser, ::FileChooserAction)
```
Override the current file chooser action type, this may not change the layout until the dialog is hidden, then shown again.
"""

@document set_fixed_width! """
```
set_fixed_width!(::ColumnViewColumn, width::AbstractFloat)
```
Set the fixed width of the column, in pixels, or `-1` if unlimited.
"""

@document set_focus_on_click! """
```
set_focus_on_click!(::Widget, ::Bool) 
```
Set whether the widget should attempt to grap focus when it is clicked.
"""

@document set_focus_visible! """
```
set_focus_visible!(::Window, ::Bool) 
```
Set whether which widget currently holds input focus should be highlighted using a border.
"""

@document set_fraction! """
```
set_fraction!(::ProgressBar, zero_to_one::AbstractFloat) 
```
Set the currently displayed fraction of the progress bar, in `[0, 1]`.
"""

@document set_fullscreen! """
```
set_fullscreen!(::Window) 
```
Request for the window manager to enter fullscreen mode. This may fail.
"""

@document set_function! """
```
set_function!(f, action::Action, [::Data_t]) 
```
Register a callback that should be called when the action is activated.

## Example
```julia
action = Action("example.action")
set_function!(action) do x::Action
    println(get_id(x) * " called")
end
```
"""

@document set_has_base_arrow! """
```
set_has_base_arrow!(::Popover, ::Bool) 
```
Set whether the "tail" of the popover pointing to widget it is attached to should be visible.
"""

@document set_has_border! """
```
set_has_border!(::Notebook, ::Bool) 
```
Set whether a border should be drawn around the notebooks perimeter.
"""

@document set_has_close_button! """
```
set_has_close_button!(::Window, ::Bool) 
```
Set whether the "x" button is present.
"""

@document set_has_frame! """
```
set_has_frame!(::Button, ::Bool) 
set_has_frame!(::Viewport, ::Bool) 
set_has_frame!(::Entry, ::Bool) 
set_has_frame!(::PopoverButton, ::Bool) 
```
Set whether the widgets outline should be displayed. This does not impact the widgets interactability.
"""

@document set_has_origin! """
```
set_has_origin!(::Scale, ::Bool)
```
Set whether the area of the slider between the start of the range and the current value should be filled with a color.
"""

@document set_has_wide_handle! """
```
set_has_wide_handle!(::Paned, ::Bool) 
```
Set whether the barrier in-between the `Paned`s two children is wide or thin, wide by default.
"""

@document set_header_menu! """
```
set_header_menu!(::ColumnViewColumn, model::MenuModel) 
```
Add a menu model to be used as the columns header menu, which the user can access by 
clicking the columns title.
"""

@document set_hide_on_close! """
```
set_hide_on_close!(::Window, ::Bool) 
```
If set to to `true`, the window will be hidden when it is closed, if set to `false`, the window 
is destroyed when closed. `false` by default.

If set to `true`, the caller of this function is responsible for deallocating the window by calling [`destroy!`](@ref).
"""

@document set_hide_on_overflow! """
```
set_hide_on_overflow!(::Widget, ::Bool) 
```
Set whether the entire widget should be hidden if its allocated area is smaller than its natural size. If `false`, the overflow part of the widget will be truncated.
"""

@document set_homogeneous! """
```
set_homogeneous!(::Box, ::Bool) 
```
Set whether the box allocates the same space for all of its children.
"""

@document set_horizontal_alignment! """
```
set_horizontal_alignment!(::Widget, ::Alignment) 
```
Set alignment along the x-axis.
"""

@document set_horizontal_scrollbar_policy! """
```
set_horizontal_scrollbar_policy!(::Viewport, policy::ScrollbarVisibilityPolicy) 
```
Set the policy governing how and if the horizontal scrollbar is revealed / hidden.
"""

@document set_icon! """
```
set_icon!(::Button, ::Icon) 
set_icon!(::ToggleButton, ::Icon)
```
Replace the buttons label with an icon.
"""

@document set_image! """
```
set_image!(::Clipboard, image::Image) 
```
Override the clipboards content with an image. Use [`get_image`](@ref) to retrieve it.
"""

@document set_initial_file! """
```
set_initial_file!(::FileChooser, ::FileDescriptor)
```
For `FILE_CHOOSER_ACTION_OPEN_FILE` or `FILE_CHOOSER_ACTION_OPEN_MULTIPLE_FILES`, choose the file that is selected when the dialog is first shown.
"""

@document set_initial_filter! """
```
set_initial_filter!(::FileChooser, ::FileFilter)
```
Set currently selected filter. If the filter was not yet added with [`add_filter!`](@ref), it will 
still be made the active filter, but the user will be unable to change the filter selection.
"""

@document set_initial_folder! """
```
set_initial_folder(::FileChooser, ::FileDescriptor)
```
For `FILE_CHOOSER_ACTION_SELECT_FOLDER` or `FILE_CHOOSER_ACTION_OPEN_MULTIPLE_FOLDERS`, choose the folder that is selected when the dialog is first shown.
"""

@document set_initial_name! """
```
set_initial_name!(::FileChooser, ::String)
```
For `FILE_CHOOSER_ACTION_SAVE`, set the name field that will be used to determine the saved files name.
"""

@document set_inverted! """
```
set_inverted!(::LevelBar, ::Bool) 
```
Set whether the level bar should be mirrored along the horizontal or vertical axis, depending on orientation.
"""

@document set_is_active! """
```
set_is_active!(::Switch, ::Bool) 
set_is_active!(::ToggleButton, ::Bool) 
set_is_active!(::CheckMark, ::Bool)
```
Set the internal state of the widget.
"""

@document set_is_circular! """
```
set_is_circular!(::Button, ::Bool) 
set_is_circular!(::ToggleButton, ::Bool) 
set_is_circular!(::PopoverButton, ::Bool) 
```
Set whether the button should be circular, as opposed to rectangular.
"""

@document set_is_decorated! """
```
set_is_decorated!(::Window, ::Bool) 
```
Set whether the header bar area of the window is visible.
"""

@document set_is_focusable! """
```
set_is_focusable!(::Widget, ::Bool) 
```
Set whether the widget can retrieve input focus. Most widgets that support interaction by default are already focusable.
"""

@document set_is_horizontally_homogeneous """
```
set_is_horizontally_homogeneous(::Stack, ::Bool) 
```
Set whether the stack should allocate the same width for all of its pages.
"""

@document set_is_inverted! """
```
set_is_inverted!(::ProgressBar, ::Bool) 
```
Set whether the `ProgressBar` should be mirrored.
"""

@document set_is_modal! """
```
set_is_modal!(::Window, ::Bool) 
set_is_modal!(::FileChooser, ::Bool) 
set_is_modal!(::ColorChooser, ::Bool) 
set_is_modal!(::AlertDialog, ::Bool) 
```
Set whether all others windows should be paused while this window is active.
"""

@document set_is_resizable! """
```
set_is_resizable!(::ColumnViewColumn, ::Bool) 
```
Set whether the column can be resized. If set to `false`, the size set via [`set_fixed_width!`](@ref) will be used.
"""

@document set_is_scrollable! """
```
set_is_scrollable!(::Notebook, ::Bool) 
```
Set whether the user can scroll between pages using the mouse scroll wheel or touchscreen.
"""

@document set_is_spinning! """
```
set_is_spinning!(::Spinner, ::Bool) 
```
Set whether the spinner is currently playing its animation.
"""

@document set_is_vertically_homogeneous """
```
set_is_vertically_homogeneous(::Stack, ::Bool) 
```
Set whether all pages of the stack should allocate the same height.
"""

@document set_is_visible! """
```
set_is_visible!(::Widget, ::Bool) 
```
Set whether the widget is hidden.

---

```
set_is_visible!(::Shape, ::Bool) 
```
Set whether the shape and any associated render tasks should be rendered.

---

```
set_is_visible!(::ColumnViewColumn, ::Bool) 
```
Temporarily remove the column and all its rows from the column view.
"""

@document set_justify_mode! """
```
set_justify_mode!(::Label, mode::JustifyMode) 
set_justify_mode!(::TextView, mode:JustifyMode) 
```
Set the text justification mode.
"""

@document set_kinetic_scrolling_enabled! """
```
set_kinetic_scrolling_enabled!(::Viewport, ::Bool) 
```
Set whether the widget should continue scrolling once the user stopped operating the mouse wheel or touchscreen, simulating "inertia".
"""

@document set_label_widget! """
```
set_label_widget!(::Expander, label::Widget) 
set_label_widget!(::Frame, label::Widget) 
```
Choose a widget as the label.
"""

@document set_label_x_alignment! """
```
set_label_x_alignment!(::Frame, ::AbstractFloat) 
```
Set horizontal alignment of the label widget (if present), in `[0, 1]`
"""

@document set_layout! """
```
set_layout!(::HeaderBar, layout::String) 
```
Set layout string of the header bar.

This is a list of button IDs. Valid IDs are limited to:

+ `maximize`: Maximize Button
+ `minimize`: Minimize Button
+ `close`: Close Button

Any object left of `:` will be placed left of the title, any after `:` will be place right of the title. Object are delimited by `,`.

## Example
```julia
header_bar = HeaderBar()
set_layout!(header_bar, "close:maximize,minimize")
"""

@document set_left_margin! """
```
set_left_margin!(::TextView, margin::AbstractFloat) 
```
Set distance between the left end of the text and the text views frame.
"""

@document set_log_file! """
```
set_log_file!(path::String) -> Bool
```
Set file at `path` as the log file. Any logging will be pushed to the file as opposed to being printed to the console. The file
will be created if it does not exist. If it does exist, the file will be appended to, as opposed to being overwritten.

Returns `true` if the file was succesfully opened.
"""

@document set_lower! """
```
set_lower!(::Adjustment, ::Number) 
set_lower!(::Scale, ::Number) 
set_lower!(::SpinButton, ::Number) 
```
Set lower bound of the underlying adjustment.
"""

@document set_listens_for_shortcut_action! """
```
set_listens_for_shortcut_action!(::Widget, ::Action)
```
Adds the action to the widgets internal `ShortcutEventController`. While the widget holds focus,
if the user presses the actions associated shortcut, the action will trigger.
"""

@document set_margin_bottom! """
```
set_margin_bottom!(::Widget, margin::AbstractFloat) 
```
Set distance between the bottom of the text and the text views frame, in pixels.
"""

@document set_margin_end! """
```
set_margin_end!(::Widget, margin::AbstractFloat) 
```
Set right margin of the widget, in pixels.
"""

@document set_margin_horizontal! """
```
set_margin_horizontal!(::Widget, margin::AbstractFloat) 
```
Set both the left and right margin of the widget, in pixels.
"""

@document set_margin! """
```
set_margin!(::Widget, margin::AbstractFloat) 
```
Set both the left, right, top, and bottom margin of the widget, in pixels.
"""

@document set_margin_start! """
```
set_margin_start!(::Widget, margin::AbstractFloat) 
```
Set left margin of the widget, in pixels.
"""

@document set_margin_top! """
```
set_margin_top!(::Widget, margin::AbstractFloat) 
```
Set top margin of the widget, in pixels.
"""

@document set_margin_vertical! """
```
set_margin_vertical!(::Widget, margin::AbstractFloat) 
```
Set both the top and bottom margin of the widget, in pixels.
"""

@document set_max_n_columns! """
```
set_max_n_columns!(grid_view::GridView, n::Integer) 
```
Limit the number of columns (or rows, if horizontal) to given number, or `-1` if unlimited.
"""

@document set_max_value! """
```
set_max_value!(::LevelBar, value::AbstractFloat) 
```
Set upper limit of the underlying range.
"""

@document set_max_width_chars! """
```
set_max_width_chars!(::Label, n::Integer) 
set_max_width_chars!(::Entry, n::Integer) 
```
Set the number of characters that the widget should make space for, or `-1` if unlimited.
"""

@document set_maximized! """
```
set_maximized!(::Window, ::Bool) 
```
Attempt to maximize or unmaximize the window.
"""

@document set_message! """
```
set_message!(::AlertDialog, ::String)
```
Set the main message of the dialog, this will be used as the dialogs title.
"""

@document set_min_n_columns! """
```
set_min_n_columns!(grid_view::GridView, n::Integer) 
```
Limit the minimum number of columns, or unlimited if `-1`.
"""

@document set_min_value! """
```
set_min_value!(::LevelBar, value::AbstractFloat) 
```
Set the lower bound of the underlying range.
"""

@document set_mode! """
```
set_mode!(::LevelBar, mode::LevelBarMode) 
```
Set whether the level bar should display its value continuous or segmented.
"""

@document set_n_digits! """
```
set_n_digits!(::SpinButton, n::Integer) 
```
Set number of digits after the decimal point, up to a maximum of `20`. This only affects the visuals of the `SpinButton`, the internal value of the 
underlying adjustment is unaffected.
"""

@document set_only_listens_to_button! """
```
set_only_listens_to_button!(::SingleClickGesture, button::ButtonID) 
```
Set which mouse buttons the event controller should listen to, or `BUTTON_ID_ANY` to listen to all buttons.
"""

@document set_opacity! """
```
set_opacity!(::Widget, opacity::AbstractFloat) 
```
Set the opacity of the widget, in `[0, 1]`.
"""

@document set_orientation! """
```
set_orientation!(::Box, ::Orientation) 
set_orientation!(::CenterBox, ::Orientation) 
set_orientation!(::LevelBar, ::Orientation) 
set_orientation!(::Grid, ::Orientation) 
set_orientation!(::ProgressBar, ::Orientation) 
set_orientation!(::Scrollbar, ::Orientation) 
set_orientation!(::Separator, ::Orientation) 
set_orientation!(::ListView, ::Orientation) 
set_orientation!(::GridView, ::Orientation) 
set_orientation!(::Paned, ::Orientation) 
set_orientation!(::SpinButton, ::Orientation)
set_orientation!(::Scale, ::Orientation)
```
Set orientation of the widget, this governs along which axis it aligns itself and its children.

---

```
set_orientation!(::PanEventController) 
```
Set along which axis the event controller should listen for pan gestures.
"""

@document set_pixel! """
```
set_pixel!(image::Image, x::Integer, y::Integer, color::RGBA) 
set_pixel!(image::Image, x::Integer, y::Integer, color::HSVA) 
```
Override the color of a pixel, 1-based indexing.
"""

@document set_popover! """
```
set_popover!(::PopoverButton, popover::Popover) 
```
Attach a [`Popover`](@ref) to the popover button. This will detach any already attached `Popover` or `PopoverMenu`.
"""

@document set_popover_menu! """
```
set_popover_menu!(popover_button::PopoverButton, popover_menu::PopoverMenu) 
```
Attach a [`PopoverMenu`](@ref) to the popover button. This will detach any already attached `Popover` or `PopoverMenu`.
"""

@document set_position! """
```
set_position!(::Paned, position::Integer) 
```
Set position of the paned handle, relative to the `Paned`s origin, in pixels.
"""

@document set_primary_icon! """
```
set_primary_icon!(::Entry, icon::Icon) 
```
Set left icon of the entry.
"""

@document set_propagate_natural_height! """
```
set_propagate_natural_height!(::Viewport, ::Bool) 
```
Set whether the viewport should assume the width of its child. This will usually hide the vertical scrollbar.
"""

@document set_propagate_natural_width! """
```
set_propagate_natural_width!(::Viewport, ::Bool) 
```
Set whether the viewport should assume the height of its child. This will usually hide the horizontal scrollbar.
"""

@document set_propagation_phase! """
```
set_propagation_phase!(controller::EventController, ::PropagationPhase) 
```
Set the phase at which the event controller will capture events, see [here](https://developer-old.gnome.org/gtk4/stable/event-propagation.html) for more information.
"""

@document set_quick_change_menu_enabled! """
```
set_quick_change_menu_enabled!(::Notebook, ::Bool) 
```
Set whether the user can click any of the tabs to open a menu that allows them to jump to a page.
"""

@document set_ratio! """
```
set_ratio!(::AspectFrame, ratio::AbstractFloat) 
```
Set width-to-height aspect ratio.
"""

@document set_relative_position! """
```
set_relative_position!(::Popover, position::RelativePosition) 
set_relative_position!(::PopoverButton, position::RelativePosition) 
```
Set position of the popover relative to the widget it is attached to.
"""

@document set_resource_path! """
```
set_resource_path!(::IconTheme, path::String) 
```
Override all resource paths with the given path. The pointed-to folder has to adhere to the [Freedesktop icon theme specificatins](https://specifications.freedesktop.org/icon-theme-spec/icon-theme-spec-latest.html).
"""

@document set_is_revealed! """
```
set_is_revealed!(::Revealer, child_visible::Bool) 
```
Set whether the revealers child should be visible. If the visibility changes, an animation is played.
"""

@document set_right_margin! """
```
set_right_margin!(::TextView, margin::AbstractFloat) 
```
Set margin between the right end of the text and the text views frame.
"""

@document set_row_spacing! """
```
set_row_spacing!(::Grid, spacing::AbstractFloat) 
```
Set spacing between rows of the grid, in pixels.
"""

@document set_rows_homogeneous! """
```
set_rows_homogeneous!(::Grid, ::Bool) 
```
Set whether all rows should allocate the same height.
"""

@document set_scale! """
```
set_scale!(::ImageDisplay, scale::Integer) 
```
Scale image by a constant factor, in `{1, 2, 3, ...}`.
"""

@document set_scale_mode! """
```
set_scale_mode!(texture::mousetrap.TextureObject, mode::TextureWrapMode) 
```
Set the OpenGL scale mode the texture uses.
"""

@document set_scope! """
```
set_scope!(::ShortcutEventController, scope::ShortcutScope) 
```
Set the scope in which the controller listens for shortcut events, see [here](https://docs.gtk.org/gtk4/method.ShortcutController.set_scope.html) for more information.
"""

@document set_scrollbar_placement! """
```
set_scrollbar_placement!(::Viewport, placement::CornerPlacement) 
```
Set placement of both scrollbars relative to the viewports center.
"""

@document set_secondary_icon! """
```
set_secondary_icon!(entry::Entry, icon::Icon) 
```
Set the right icon of the entry.
"""

@document set_is_selectable! """
```
set_is_selectable!(::Label, ::Bool) 
```
Set whether the user can select part of the label, as would be needed to copy its text. `false` by default.
"""

@document set_selected! """
```
set_selected!(::DropDown, id::DropDownItemID)
```
Make the item identified by the given ID the currently selected item. This will invoke its associated callback.
"""

@document set_should_draw_value! """
```
set_should_draw_value!(::Scale, ::Bool)
```
Set whether the current value of the scales internal adjustment should be drawn next to the knob.
"""

@document set_should_interpolate_size """
```
set_should_interpolate_size(::Stack, ::Bool) 
```
Set whether the stack should slowly transition its size when transitioning from one page to another.
"""

@document set_should_snap_to_ticks! """
```
set_should_snap_to_ticks!(::SpinButton, ::Bool) 
```
Set whether when the user enters a value using the spin buttons text entry, that value should be clamped to the nearest tick.
"""

@document set_should_wrap! """
```
set_should_wrap!(::SpinButton, ::Bool) 
```
Set whether the spin button should over- / underflow when reaching the upper or lower end of its range.
"""

@document set_show_column_separators """
```
set_show_column_separators(::ColumnView, ::Bool) 
```
Set whether separators should be drawn between each column.
"""

@document set_show_row_separators """
```
set_show_row_separators(::ColumnView, ::Bool) 
```
Set whether separators should be drawn between each row.
"""

@document set_show_separators! """
```
set_show_separators!(::ListView, ::Bool) 
```
Set whether separators should be drawn between two items.
"""

@document set_show_text! """
```
set_show_text!(::ProgressBar, ::Bool)
```
Set whether a percentage or custom text should be displayed above the progress bar. Use [`set_text!`](@ref) to specify the custom text.
"""

@document set_show_title_buttons! """
```
set_show_title_buttons!(::HeaderBar, ::Bool) 
```
If set to `false`, the "close", "minimize" and "maximize" buttons will be hidden.
"""

@document set_single_click_activate! """
```
set_single_click_activate!(::ListView, ::Bool) 
set_single_click_activate!(::ColumnView, ::Bool) 
set_single_click_activate!(::GridView, ::Bool) 
```
Set whether simply hovering about an item selects it.
"""

@document set_size_request! """
```
set_size_request!(::Widget, size::Vector2f) 
```
Set the size request, where a `0` for either width or height indicates that no size request was made.
"""

@document set_spacing! """
```
set_spacing!(::Box, spacing::Number) 
```
Set the space between two items, in pixels.
"""

@document set_start_child! """
```
set_start_child!(::CenterBox, child::Widget) 
set_start_child!(::Paned, child::Widget) 
```
Set first child of the container.
"""

@document set_start_child_resizable! """
```
set_start_child_resizable!(::Paned, ::Bool) 
```
Set whether the first child should resize when the `Paned` is resized.
"""

@document set_start_child_shrinkable! """
```
set_start_child_shrinkable!(::Paned, ::Bool)
```
Set whether the user can resize the first child such that its allocated area inside the paned is smaller than the natural size of the child.
"""

@document set_startup_notification_identifier! """
```
set_startup_notification_identifier!(::Window, id::String) 
```
Register an ID to be used to send a notification when the window is first shown, which will usually be `"\$id is ready.". 

There is no guarantee that the users operating system supports this feature.
"""

@document set_state! """
```
set_state!(::Action, ::Bool) 
```
If the action is stateful, override its internal state.

---

```
set_state!(::CheckButton, state::CheckButtonState) 
```
Set the state of the check button, this will change its visual element and emit the `toggled` signal.
"""

@document set_step_increment! """
```
set_step_increment!(::Adjustment, value::Number) 
set_step_increment!(::Scale, value::Number) 
set_step_increment!(::SpinButton, value::Number) 
```
Set minimum distance between two discrete values of the underlying range.
"""

@document set_string! """
```
set_string!(::Clipboard, string::String) 
```
Override the clipboards contents with a string. Use [`get_string`](@ref) to retrieve it.
"""

@document set_surpress_debug! """
```
set_surpress_debug!(domain::String, ::Bool) 
```
If set to `false`, log messages with log-level `DEBUG` will now be printed to console or the log file. `true` by default.
"""

@document set_surpress_info! """
```
set_surpress_info!(domain::String, ::Bool) 
```
If set to `false`, log message with log-level `INFO` will now be printed to console or the log file. `true` by default.
"""

@document set_tab_position! """
```
set_tab_position!(::Notebook, relative_position::RelativePosition) 
```
Set position of the tab bar, relative to the notebooks center.
"""

@document set_tabs_reorderable! """
```
set_tabs_reorderable!(::Notebook, ::Bool) 
```
Set whether the user can reorder tabs by dragging them.
"""

@document set_tabs_visible! """
```
set_tabs_visible!(::Notebook, ::Bool) 
```
Set whether the tab bar should be displayed.
"""

@document set_text! """
```
set_text!(::Entry, text::String) 
set_text!(::Label, text::String) 
set_text!(::TextView, text::String) 
```
Override the content of the internal text buffer.

---

```
set_text!(::ProgressBar, text::String) 
```
Set text that will be displayed instead of the percentage when [`set_show_text!`](@ref) was set to true.
"""

@document set_text_to_value_function! """
```
set_text_to_value_function!(f, spin_button::SpinButton, [::Data_t]) 
```
Set function that converts the text in the spin buttons text entry to a value. `f` is required to be invocable as a function with signature
```
(::SpinButton, text::String) -> Float32
```
## Example
```
spin_button = SpinButton(0, 1, 0.001)
set_text_to_value_function!(spin_button) do self::SpinButton, text::String
    value::Float32 = 0
    # process string here
    return value
end
```
"""

@document set_text_visible! """
```
set_text_visible!(::Entry, ::Bool) 
```
Set whether the entry should enter password mode.
"""

@document set_texture! """
```
set_texture!(::Shape, texture::TextureObject) 
```
Set the texture of the shape. It will be automatically bound when rendering.
"""

@document set_tick_callback! """
```
set_tick_callback!(f, ::Widget, [::Data_t]) 
```
Register a function that will be invoced exactly once per frame while the widget is shown. `f` is required to be invocable as a function with signature
```
(::FrameClock, [::Data_t]) -> TickCallbackResult
```
The callback will be removed when `f` returns `TICK_CALLBACK_RESULT_DISCONTINUE`.

## Example
```julia
set_tick_callback!(widget) do clock::FrameClock
    frame_duration = as_seconds(get_time_since_last_frame(clock))
    println("It has been \$frame_duration seconds since widget was last rendered")
    return TICK_CALLBACK_RESULT_CONTINUE
end
```
"""

@document set_title! """
```
set_title!(::Window, title::String) 
```
Set the windows title, which will be shown in its titlebar.

---

```
set_title!(::ColumnViewColumn, title::String) 
```
Set the columns title, which will uniquely identify that column.
"""

@document set_title_widget! """
```
set_title_widget!(header_bar::HeaderBar, ::Widget) 
```
Replace the default header bar with a custom widget.
"""

@document set_titlebar_widget! """
```
set_titlebar_widget!(window::Window, titlebar::Widget) 
```
Set a widget used as the titlebar. This will usually be a `HeaderBar`.
"""

@document set_tooltip_text! """
```
set_tooltip_text!(::Widget, text::String) 
```
Create a simple text tooltip. It will be automatically shown when the user hovers above the widgets allocated area for a certain duration.
"""

@document set_tooltip_widget! """
```
set_tooltip_widget!(::Widget, tooltip::Widget) 
```
Set a custom widget as the widgets tooltip. It will be automatically shown when the user hovers above the widgets allocated area for a certain duration.

This widget should not be interactable.
"""

@document set_top_left! """
```
set_top_left!(::Shape, top_left::Vector2f) 
```
Move the shape such that the top left corner of its axis-aligned bounding box is at given position, in OpenGL coordinates.
"""

@document set_top_margin! """
```
set_top_margin!(::TextView, margin::AbstractFloat) 
```
Set margin between the top of the text and the text views frame, in pixels.
"""

@document set_touch_only! """
```
set_touch_only!(::SingleClickGesture) 
```
Make it such that the event controller will exclusively listen to events emitted by touch devices.
"""

@document set_transient_for! """
```
set_transient_for!(self::Window, other::Window) 
```
Make it such that if `self` and `other` overlap, `self` will always be shown on top.
"""

@document set_transition_duration! """
```
set_transition_duration!(::Stack, duration::Time) 
set_transition_duration!(::Revealer, duration::Time) 
```
Choose the duration of the transition animation.
"""

@document set_transition_type! """
```
set_transition_type!(::Stack, transition::StackTransitionType) 
set_transition_type!(::Revealer, type::RevealerTransitionType) 
```
Set the type of transition animation. 
"""

@document set_uniform_float! """
```
set_uniform_float!(::Shader, name::String, v::Cfloat) 
set_uniform_float!(::RenderTask, name::String, v::Cfloat) 
```
Assign a value to a uniform in the shader program, whose variable name exactly matches `name`. 

This value will be a `float` in GLSL.
"""

@document set_uniform_hsva! """
```
set_uniform_hsva!(task::RenderTask, name::String, hsva::RGBA) 
```
Assign a value to a uniform in the shader program, whose variable name exactly matches `name`. 

This value will be a `vec4` in GLSL.
"""

@document set_uniform_int! """
```
set_uniform_int!(::Shader, name::String, float::Int32) 
set_uniform_int!(::RenderTask, name::String, v::Int32) 
```
Assign a value to a uniform in the shader program, whose variable name exactly matches `name`. 

This value will be a `int` in GLSL.
"""

@document set_uniform_rgba! """
```
set_uniform_rgba!(::RenderTask, name::String, rgba::RGBA) 
```
Assign a value to a uniform in the shader program, whose variable name exactly matches `name`. 

This value will be a `vec4` in GLSL.
"""

@document set_uniform_transform! """
```
set_uniform_transform!(::Shader, name::String, transform::GLTransform) 
set_uniform_transform!(::RenderTask, name::String, transform::GLTransform) 
```
Assign a value to a uniform in the shader program, whose variable name exactly matches `name`. 

This value will be a `mat4x4` in GLSL.
"""

@document set_uniform_uint! """
```
set_uniform_uint!(::Shader, name::String, float::UInt32) 
set_uniform_uint!(::RenderTask, name::String, v::UInt32) 
```
Assign a value to a uniform in the shader program, whose variable name exactly matches `name`. 

This value will be a `uint` in GLSL.
"""

@document set_uniform_vec2! """
```
set_uniform_vec2!(::Shader, name::String, vec2::Vector2f) 
set_uniform_vec2!(::RenderTask, name::String, v::Vector2f) 
```
Assign a value to a uniform in the shader program, whose variable name exactly matches `name`. 

This value will be a `vec2` in GLSL.
"""

@document set_uniform_vec3! """
```
set_uniform_vec3!(::Shader, name::String, vec2::Vector2f) 
set_uniform_vec3!(::RenderTask, name::String, v::StaticArraysCore.SVector{3, Float32}) 
```
Assign a value to a uniform in the shader program, whose variable name exactly matches `name`. 

This value will be a `vec3` in GLSL.
"""

@document set_uniform_vec4! """
```
set_uniform_vec4!(::Shader, name::String, vec2::Vector2f) 
set_uniform_vec4!(::RenderTask, name::String, v::StaticArraysCore.SVector{4, Float32}) 
```
Assign a value to a uniform in the shader program, whose variable name exactly matches `name`. 

This value will be a `vec4` in GLSL.
"""

@document set_upper! """
```
set_upper!(::Adjustment, ::Number) 
set_upper!(::Scale, ::Number) 
set_upper!(::SpinButton, ::Number) 
```
Set upper bound of th underlying adjustment.
"""

@document set_use_markup! """
```
set_use_markup!(::Label, ::Bool) 
```
Set whether the label should respect [pango markup syntax](https://docs.gtk.org/Pango/pango_markup.html). `true` by default.
"""

@document set_value! """
```
set_value!(::SpinButton, value::Number) 
set_value!(::Scale, value::Number) 
set_value!(adjustment::Adjustment, ::Number) 
```
Set the current value of the underlying range, clamped to `[lower, upper]`.

---

```
set_value!(file::KeyFile, ::GroupID, ::KeyID, ::AbstractFloat) 
set_value!(file::KeyFile, ::GroupID, ::KeyID, ::Vector{<:AbstractFloat}) 
set_value!(file::KeyFile, ::GroupID, ::KeyID, ::Signed) 
set_value!(file::KeyFile, ::GroupID, ::KeyID, ::Vector{<:Signed}) 
set_value!(file::KeyFile, ::GroupID, ::KeyID, ::Unsigned) 
set_value!(file::KeyFile, ::GroupID, ::KeyID, ::Vector{<:Unsigned}) 
set_value!(file::KeyFile, ::GroupID, ::KeyID, ::Bool) 
set_value!(file::KeyFile, ::GroupID, ::KeyID, ::Vector{Bool}) 
set_value!(file::KeyFile, ::GroupID, ::KeyID, ::String) 
set_value!(file::KeyFile, ::GroupID, ::KeyID, ::Vector{String}) 
set_value!(file::KeyFile, ::GroupID, ::KeyID, ::RGBA)
set_value!(file::KeyFile, ::GroupID, ::KeyID, ::HSVA) 
set_value!(file::KeyFile, ::GroupID, ::KeyID, ::Image) 
```
Serialize a value and save it to a key-value pair in given group. If the group or key does not yet exist, it is created.
"""

@document set_value_to_text_function! """
```
set_value_to_text_function!(f, spin_button::SpinButton) 
set_value_to_text_function!(f, spin_button::SpinButton, data::Data_t) where Data_t 
```
Register a function that converts the value of the underyling range to the text displayed in the text-entry area of the spin button.
`f` is required to be invocable as a function with signature
```
(::SpinButton, ::AbstractFloat) -> String
```

## Example
```julia
spin_button = SpinButton(0, 1, 0.001)
set_value_to_text_function!(spin_button) do self::SpinButton, value::AbstractFloat
    result = ""
    # generate string here
    return result
end
```
"""

@document set_vertex_color! """
```
set_vertex_color!(::Shape, index::Integer, color::RGBA) 
```
Set the color of a specific vertex.
"""

@document set_vertex_position! """
```
set_vertex_position!(::Shape, index::Integer, position::Vector3f) 
```
Set position of a specific vertex, in 3D OpenGL coordinates.
"""

@document set_vertex_texture_coordinate! """
```
set_vertex_texture_coordinate!(::Shape, inde::Integer, coordinate::Vector2f) 
```
Set texture coordinate of a specific vertex.
"""

@document set_vertical_alignment! """
```
set_vertical_alignment!(::Widget, alignment::Alignment) 
```
Set widget alignment along the y-axis.
"""

@document set_vertical_scrollbar_policy! """
```
set_vertical_scrollbar_policy!(::Viewport, policy::ScrollbarVisibilityPolicy) 
```
Set policy of vertical scrollbar, this determines when/if the scrollbar is shown.
"""

@document set_visible_child! """
```
set_visible_child!(stack::Stack, id::StackID) 
```
Make the current page of the stack that identified by ID.
"""

@document set_was_modified! """
```
set_was_modified!(::TextView, ::Bool) 
```
Override the flag indicating that a text buffer was modified.
"""

@document set_widget_at! """
```
set_widget_at!(::ListView, index::Integer, ::Widget, [::ListViewIterator]) 
set_widget_at!(::ColumnView, ::ColumnViewColumn, row_i::Integer, ::Widget)
```
Replace the widget at given position.
"""

@document set_wrap_mode! """
```
set_wrap_mode!(::Label, mode::LabelWrapMode) 
```
Set wrap mode, this determines at which point of a line a linebreak will be inserted.

---

```
set_wrap_mode!(::TextureObject, mode::TextureWrapMode) 
```
Set OpenGL texture wrap mode.
"""

@document set_x_alignment! """
```
set_x_alignment!(::Label, ::AbstractFloat) 
```
Set horizontal alignment of the label, in `[0, 1]`.
"""

@document set_y_alignment! """
```
set_y_alignment!(::Label, ::AbstractFloat) 
```
Set vertical alignment of the label, in `[0, 1]`.
"""

@document shift_pressed """
```
shift_pressed(modifier_state::ModifierState) -> Bool
```
Check whether the modifier state indicates that the shift or caps key is currently down.
"""

@document should_shortcut_trigger_trigger """
```
should_shortcut_trigger_trigger(::KeyEventController, trigger::String) -> Bool
```
Test whether the currently active event should trigger the shortcut trigger. This function 
should only be called from within signal `key_pressed` or `modifiers_changed`.

This is usually not necessary, use `ShortcutEventController` to listen for shortcuts instead.
"""

@document show! """
```
show!(::Widget) 
```
Reveal the widget if it is currently hidden. This will emit signal `show`.
"""

@document show_in_file_explorer """
```
show_in_file_explorer(::FileDescriptor) -> Cvoid
```
Asynchronously open the users file explorer application to show the folder containing the given file.
"""

@document start! """
```
start!(::Spinner) 
```
Start the spinning animation if it is currently stopped.
"""

@document stop! """
```
stop!(::Spinner) 
```
Stop the spinning animation if it is currently playing.
"""

@document to_gl_coordinates """
```
to_gl_coordinates(area::RenderArea, absolute_widget_space_coordinates::Vector2f) -> Vector2f
```
Convert absolute widget-space coordinates to OpenGL coordinates. This will take into account the `RenderArea`s currently allocated size on screen.
"""

@document translate! """
```
translate!(transform::GLTransform, offset::Vector2f) 
```
Translate the transform by the given offset, in OpenGL coordinates.
"""

@document unbind """
```
unbind(::TextureObject) 
```
Unbind a texture from rendering. This is usually done automatically.
"""

@document unbind_as_render_target """
```
unbind_as_render_target(render_texture::RenderTexture) 
```
Make it such that the render texture is no longer the current render target. This will restore the framebuffer that
was active when `bind_as_render_target` was called.
"""

@document undo! """
```
undo!(::TextView) 
```
Trigger an undo step.
"""

@document unmark_as_busy! """
```
unmark_as_busy!(::Application) 
```
Undo the effect of [`mark_as_busy!`](@ref).
"""

@document unparent! """
```
unparent!(::Widget) 
```
Remove the widget from its parent.
"""

@document unselect! """
```
unselect!(model::SelectionModel, i::Integer) 
```
Make item at given position no longer selected.
"""

@document unselect_all! """
```
unselect_all!(::SelectionModel) 
```
Make it such that no item is selected, if the selection mode allows for that. 
"""

@document vbox """
```
vbox(::Widget...) -> Box
```
Convenience function that wraps list of widgets in a vertically oriented box.
"""
