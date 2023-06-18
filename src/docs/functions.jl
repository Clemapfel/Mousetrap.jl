@do_not_compile const _generate_function_docs = quote

    for name in mousetrap.functions

        method_list = ""
        method_table = methods(getproperty(mousetrap, name))
        for i in eachindex(method_table)
            as_string = string(method_table[i])
            method_list *= as_string[1:match(r" \@.*", as_string).offset]
            if i != length(method_table)
                method_list *= "\n"
            end
        end

        println("""
        @document $name \"\"\"
        ```
        $method_list
        ```
        TODO
        \"\"\"
        """)
    end
end

# Note: @doc can't document macros, apparently, done inline in `mousetrap.jl`
# @document @log_info 
# @document @log_warning 
# @document @log_critical 
# @document @log_fatal 

@document activate """
```
activate(::Action) 
```
Trigger the actions callback. This will also emit signal `activated`.
"""

@document activate! """
```
activate!(::Widget)
```
If the widget is activatable, trigger it. This will cause it to emit signal `activate`, as well as possibly changings its state and playing an animation on screen.
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
controller will listen for keyboard events and trigger the action when its 
shortcut trigger is pressed.

"""

@document add_allow_all_supported_image_formats! """
```
add_allow_all_supported_image_formats!(::FileFilter) 
```
Let all file formats pass through the filter that can be loaded `Image`, `ImageDIsplay`, or `Icon`.
"""

@document add_allowed_mime_type! """
```
add_allowed_mime_type!(::FileFilter, mime_type_id::String) 
```
Let all files whos MIME type correponds to the given string pass through the filter.
"""

@document add_allowed_pattern! """
```
add_allowed_pattern!(::FileFilter, pattern::String) 
```
Let all file names that match the shell-style glob pass through the filter.
"""

@document add_allowed_suffix! """
```
add_allowed_suffix!(::FileFilter, suffix::String) 
```
Allow all files with the given suffix. The suffix should **not** contain a dot, e.g. `"jl"`, rather than `".jl"`.
"""

@document add_child! """
```
add_child!(fixed::Fixed, ::Widget, position::Vector2f) 
```
Add a child at given position, in absolute widget coodinates.
---

```
add_child!(stack::Stack, ::Widget, title::String) 
```
Add a new stack page that will be uniquely identified by `title`.
"""

@document add_controller! """
```
add_controller!(::Widget, controller::EventController) 
```
Add an event controller to the widget. Once the widget is realized, it will start listening for events.
"""

@document add_icon! """
```
add_icon!(model::MenuModel, icon::Icon, action::Action) 
```
Add an "icon"-type item to the menu model. 
"""

@document add_marker! """
```
add_marker!(::LevelBar, name::String, value::AbstractFloat) 
```
Add a marker to the level bar at given position.
"""

@document add_overlay! """
```
add_overlay!(overlay::Overlay, child::Widget ; [include_in_measurement::Bool = true, clip::Bool = false]) 
```
Add an additional overlay widget. It will be display "on top" of previously added widgets. 
If `inclde_in_measurement` is `true`, the overlaid widget will be included in size allocation of 
the entire `Overlay`.
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
Add a folder that the `IconTheme` should lookup icons in. The folder has to adhere to the [Freedesktop icon theme specificatins](https://specifications.freedesktop.org/icon-theme-spec/icon-theme-spec-latest.html).
"""

@document add_section! """
```
add_section!(model::MenuModel, title::String, to_add::MenuModel, [::SectionFormat]) 
```
Add a "section"-type menu item to the model. A model based on `to_add` will be displayed 
inside the outer `model`.
"""

@document add_shortcut! """
```
add_shortcut!(::Action, shortcut::ShortcutTrigger) 
```
Add a shortcut trigger to the list of shortcuts. To listen for shortcuts, register the `Action` 
with a `ShortcutEventController`.
"""

@document add_submenu! """
```
add_submenu!(model::MenuModel, label::String, to_add::MenuModel) 
```
Add a "submenu"-type menu item to the model. A single item will be inserted into `model`, that, when clicked,
reveals a menu based on `to_add`.
"""

@document add_widget! """
```
add_widget!(model::MenuModel, ::Widget) 
```
Add a "widget"-type item to the model. This widget should be interactable.
"""

@document alt_pressed """
```
alt_pressed(::ModifierState) 
```
Check if the `Alt` key is currently pressed.
"""

@document apply_to """
```
apply_to(transform::GLTransform, v::Vector2f) -> Vector2f
apply_to(transform::GLTransform, v::Vector3f) -> Vector3f
```
Apply transform to a vector. Note that this assume the OpenGL coordinate system.
"""

@document as_circle! """
```
as_circle!(::Shape, center::Vector2f, radius::AbstractFloat, n_outer_vertices::Integer) 
```
Initialize the shape as a circle at given position.
"""

@document as_circular_ring! """
```
as_circular_ring!(::Shape, center::Vector2f, outer_radius::AbstractFloat, thickness::AbstractFloat, n_outer_vertices::Integer) 
```
Initialize the shape as a circular ring
"""

@document as_cropped """
```
as_cropped(image::Image, offset_x::Signed, offset_y::Signed, new_width::Integer, new_height::Integer) -> Image
```
Crop the image, this is similar to the "resize canvas" operation in many image manipulation programs.
Note that `offset_x` and `offset_y` can be negative. Any pixeldata that was not part of the 
original image will be filled with RGBA(0, 0, 0, 0).

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
Initialize the shape as an ellipse.
"""

@document as_elliptical_ring! """
```
as_elliptical_ring!(::Shape, center::Vector2f, outer_x_radius::AbstractFloat, outer_y_radius::AbstractFloat, x_thickness::AbstractFloat, y_thickness::AbstractFloat, n_outer_vertices::Unsigned) 
```
Initialize the shape as an elliptical ring.
"""

@document as_line! """
```
as_line!(::Shape, a::Vector2f, b::Vector2f) 
```
Initialize the shape as a 1-fragment thick line between two points.
"""

@document as_line_strip! """
```
as_line_strip!(::Shape, points::Vector{Vector2f}) 
```
Initialize the shape as a line-strip. For points `{a1, a2, ..., an}`, 
lines `{a1, a2}, {a2, a3}, ..., {an-1, an}` will be drawn.
"""

@document as_lines! """
```
as_lines!(::Shape, points::Vector{Pair{Vector2f, Vector2f}}) 
```
Initialize the shape as a number of unconnected lines.
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
Initialize shape as an outline of another shape.
"""

@document as_point! """
```
as_point!(::Shape, position::Vector2f) 
```
Initialize shape as a 1-fragment point.
"""

@document as_points! """
```
as_points!(::Shape, positions::Vector{Vector2f}) 
```
Initialize shape as a number of unconnected 1-fragment points.
"""

@document as_polygon! """
```
as_polygon!(::Shape, points::Vector{Vector2f}) 
```
Initialize shape as a convex polygon.
"""

@document as_radians """
```
as_radians(angle::Angle) 
```
Convert to radians, in [0, 2π]
"""

@document as_rectangle! """
```
as_rectangle!(::Shape, top_left::Vector2f, size::Vector2f) 
```
Initialize shape as axis-aligned rectangle.
"""

@document as_rectangular_frame! """
```
as_rectangular_frame!(::Shape, top_left::Vector2f, outer_size::Vector2f, x_width::AbstractFloat, y_width::AbstractFloat) 
```
Initialize shape as a rectangular frame. `x_width` is the thickness of the frame along the x-axis, `y_width` along the y-axis.
"""

@document as_scaled """
```
as_scaled(::Image, size_x::Integer, size_y::Integer, ::InterpolationType) -> Image
```
Scale the image, this is similar to the "scale image" option in many image manipulation programs.

Note that this does not modify the original image.
"""

@document as_seconds """
```
as_seconds(time::Time) -> Float64
```
Convert to number of seconds.
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
Initialize the shape as a triangle.
"""

@document as_wireframe! """
```
as_wireframe!(::Shape, points::Vector{Vector2f}) 
```
Initialize the shape a wire-frame. For points `{a1, a2, a3, ..., an}`, the shape
will be a connected series of lines `{a1, a2}, {a2, a3}, ..., {an-1, an}, {an, a1}`
"""

@document attach_to! """
```
attach_to!(popover::Popover, attachment::Widget) 
```
Attach a popover to a widget, This is required in order for the popover to be visible.
"""

@document bind """
```
bind(::TextureObject) 
```
Bind a texture for rendering. This will make it available at `GL_TEXTURE_UNIT_0`.
"""

@document bind_as_render_target """
```
bind_as_render_target(render_texture::RenderTexture) 
```
Bind a render texture as the current frame buffer. This should be done inside the callback 
of `RenderArea`s signal `render`.
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
Cancel the file monitor.
"""

@document clear """
```
clear(::RenderArea) 
```
Clear the current framebuffer with `RGBA(0, 0, 0, 0)`
"""

@document clear! """
```
clear!(::Box) 
clear!(::ImageDisplay) 
clear!(::ListView) 
clear!(::ListView, iterator::ListViewIterator) 
clear!(::GridView) 
```
Remove all children from the container widget.
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
Close the window, this will emit signal `close_request`.
"""

@document combine_with """
```
combine_with(self::GLTransform, other::GLTransform) -> GLTransform
```
Perform matrix-multiplication and return the resulting transform. 
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
control_pressed(modifier_state::ModifierState) -> Bol
```
Check whether `Control` is currently pressed.
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
create!(::mousetrap.TextureObject, width::Integer, height::Integer) 
```
Initialize at given size, filling the pixel data with `RGBA(0, 0, 0, 0)`, unless otherwise specified.
"""

@document create_as_file_preview! """
```
create_as_file_preview!(image_display::ImageDisplay, file::FileDescriptor) 
```
If the `file` points to an image file, create as a preview for that image, otherwise will 
display the files associated default icon.
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
create_from_file!(::KeyFile, path::String) -> Bool
create_from_file!(::ImageDisplay, path::String) -> Bool
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
Initialize from an image.
"""

@document create_from_path! """
```
create_from_path!(::FileDescriptor, path::String) 
```
Create as file descriptor pointing to given path. There is no guarantee that the location exists or points to a valid file or folder.
"""

@document create_from_string! """
```
create_from_string!(::KeyFile, file::String) 
```
De-serialize from a string.

---

```
create_from_string!(::Shader, type::ShaderType, glsl_code::String) 
```

Create from glsl code as string.
"""

@document create_from_theme! """
```
create_from_theme!(::Icon, theme::IconTheme, id::String, square_resolution::Integer, [scale::Integer = 1]) 
```
Read an icon from an icon theme at given resolution. 
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
Create a `FileMonitor` monitoring the current file or folder. This may fail if the location does not exist.
"""

@document degrees """
```
degrees(::Number) -> Angle
```
Create from number of degrees.
"""

@document delete_at! """
```
delete_at!(::FileDescriptor) -> Bool
```
Irreversibly delete file at given location, returns `true` if the operation was succesfull
"""

@document device_axis_to_string """
```
device_axis_to_string(axis::DeviceAxis) -> String
```
Serialize the axis' name.
"""

@document download """
```
download(texture::TextureObject) -> Image
```
Retrieve the pixeldata from the graphics card and return it as an image. This is an extremely costly operation.
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
Check if file location points to a file or folder on disk.
"""

@document flush """
```
flush(::RenderArea) -> Cvoid
```
Equivalent to `glFlush`, requests for the bound framebuffer to be pushed to the screen. This may not necessarily immediately 
update the `RenderArea`.
"""

@document from_gl_coordinates """
```
from_gl_coordinates(area::RenderArea, gl_coordinates::Vector2f) -> Vector2f
```
Convert OpenGL coordinates to absolute widget coordinates
"""

@document get_acceleration_rate """
```
get_acceleration_rate(::SpinButton) -> Float64
```
Get the current rate at which the spin button accelerates, when one of the buttons is held down.
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
Retrieve the adjustment of the widget.
"""

@document get_allocated_size """
```
get_allocated_size(::Widget) -> Vector2f
```
Get the size the widget currently occupies on screen. If the widget is not currently shown, it will be `(0, 0)`
"""

@document get_allow_only_numeric """
```
get_allow_only_numeric(::SpinButton) -> Bool
```
Get whether the spin button only accepts numerical values for its text-entry.
"""

@document get_always_show_arrow """
```
get_always_show_arrow(::PopoverButton) -> Bool
```
Get whether the popover button should display an arrow next to its label.
"""

@document get_autohide """
```
get_autohide(::Popover) -> Bool
```
Get whether the popover should automatically hide when it looses focus
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
Get the axis-aligned bounding box of the shape. This is the smallest rectangle that contains all vertices.
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
Get the centroid of the shape, this is the mathematical average of all its vertices positions.
"""

@document get_child_position """
```
get_child_position(fixed::Fixed, child::Widget) -> Vector2f
```
Get the fixed location of a child.
"""

@document get_child_x_alignment """
```
get_child_x_alignment(::AspectFrame) -> Float32
```
Get the horizontal alignment of the aspect frames child. In `[0, 1]`.
"""

@document get_child_y_alignment """
```
get_child_y_alignment(::AspectFrame) 
```
Get the vertical alignment of the aspect frames child. In `[0, 1]`.
"""

@document get_children """
```
get_children(descriptor::FileDescriptor ; [recursive = false]) -> Vector{FileDescriptor}
```
Get all children of a folder. If the location pointed to by `descriptor` is a file, the resulting vector will be empty.
"""

@document get_clipboard """
```
get_clipboard(::Widget) -> Clipboard
```
Retrieve the clipboard of a widget. This will usually be the top-level window.
"""

@document get_column_at """
```
get_column_at(column_view::ColumnView, index::Integer) -> ColumnViewColumn
```
Get column at specified position, 1-indexed.
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
Get whether all columns should allocate the same widget.
"""

@document get_comment_above_group """
```
get_comment_above_group(::KeyFile, group::String) -> String
```
Get comment above a group declaration. 
"""

@document get_comment_above_key """
```
get_comment_above_key(::KeyFile, group::String, key::String) -> String
```
Get comment above a key-value pair in group.
"""

@document get_content_type """
```
get_content_type(::FileDescriptor) -> String
```
Get file type as a MIME identification string.
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
Get offset from starting positin of the drag gesture, in pixels.
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
Get whether the text caret cursor is currently visible.
"""

@document get_delay_factor """
```
get_delay_factor(::LongPressEventController) -> Float32
```
Get multiplier that determines after how much time a long press gesture is recognized.
"""

@document get_destroy_with_parent """
```
get_destroy_with_parent(::Window) -> Bool
```
Get whether the window should be closed and deallocated when its parent window is.
"""

@document get_display_mode """
```
get_display_mode(::ProgressBar) -> ProgressBarDisplayMode
```
Get whether the progress bar displays a percentage or custom text.
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

@document get_enabled_rubberband_selection """
```
get_enabled_rubberband_selection(::ListView) -> Bool
get_enabled_rubberband_selection(::GridView) -> Bool
get_enabled_rubberband_selection(::ColumnView) -> Bool
```
Get whether the user can select multiple children by holding down the mouse button. The selectable widgets
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
Get whether the user can resize the end child such that its allocated area inside the paned is smaller than the natural size of the widget.
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

@document get_file_extension """
```
get_file_extension(::FileDescriptor) -> String
```
Get the file extension of the file. This will be the any character after the last `.`.
"""

@document get_fixed_width """
```
get_fixed_width(::ColumnViewColumn) -> Bool
```
Get whether the column should always allocate the specified width.
"""

@document get_focus_on_click """
```
get_focus_on_click(::Widget) -> Bool
```
Get whether the input should grab focus when it is clicked.
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
Get native OpenGL handle of the shader program.
"""

@document get_frame_clock """
```
get_frame_clock(::Widget) -> FrameClock
```
Get a `FrameClock` that is synched to the widgets render cycle.
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
Get the native id of the stylus-device that caused the current event.
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
Get whether the "X" button is present.
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
Get whether the widgets outline should be displayed. This does not impact the widgets interactability.
"""

@document get_has_wide_handle """
```
get_has_wide_handle(::Paned) -> Bool
```
Get whether the barrier in between the paneds two children is wide or thin.
"""

@document get_hide_on_overflow """
```
get_hide_on_overflow(::Widget) -> Bool
```
Get whether any are of the widget that goes outside of its allocate space should be drawn or clipped.
"""

@document get_homogeneous """
```
get_homogeneous(::Box) -> Bool
```
Get whether all of the boxes children should be allocated the same size.
"""

@document get_horizontal_adjustment """
```
get_horizontal_adjustment(viewport::Viewport) -> Adjustment
```
Get the adjustment controlling the horizontal scrollbar.
"""

@document get_horizontal_alignemtn """
```
get_horizontal_alignemtn(::Widget) -> Alignment
```
Get alignment along the x-axis.
"""

@document get_horizontal_scrollbar_policy """
```
get_horizontal_scrollbar_policy(::Viewport) -> ScrollbarPolicy
```
Get the policy governing how and if the horizontal scrollbar is revealed / hidden.
"""

@document get_icon_names """
```
get_icon_names(theme::IconTheme) -> Vector{String}
```
Get ID of all icons available in the icon theme.
"""

@document get_id """
```
get_id(::Application) -> ApplicationID
get_id(::Action) -> ActionID
```
Access the ID specified during the objects construction.
"""

@document get_inverted """
```
get_inverted(::LevelBar) -> Bool
```
Get whether the level bar should be mirrored along the horizontal or vertcial axis, depending on orientation.
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
Get whether the button is circular or rectangular.
"""

@document get_is_decorated """
```
get_is_decorated(::Window) -> Bool
```
Get whether the header bar of the window is visible.
"""

@document get_is_focusable """
```
get_is_focusable(::Widget) -> Bool
```
Get whether the widget can hold input focus.
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
```
Get whether all other windows should be paused while this window is active.
"""

@document get_is_realized """
```
get_is_realized(::Widget) -> Bool
```
Get whether the window has emitted its `realize` signal yet.
"""

@document get_is_resizable """
```
get_is_resizable(::ColumnViewColumn) -> Bool
```
Get whether the column is resizable.
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

@document get_is_stateful """
```
get_is_stateful(::Action) -> Bool
```
Get whether the action is stateful or stateless.
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
Get whether the shape should be omitted from rendering.
"""

@document get_item_at """
```
get_item_at(drop_down::DropDown, i::Integer) -> DropDownID
```
Get ID of item currently at given position.
"""

@document get_justify_mode """
```
get_justify_mode(::Label) -> JustifyMode
get_justify_mode(::TextView) -> JustifyMode
```
Get currently used justify mode.
"""

@document get_keys """
```
get_keys(::KeyFile, group::String) -> Vector{KeyID}
```
Get all keys in group.
"""

@document get_kinetic_scrolling_enabled """
```
get_kinetic_scrolling_enabled(::Viewport) -> Bool
```
Get whether the widget should continue scrolling, simulating "inertia".
"""

@document get_label_x_alignment! """
```
get_label_x_alignment!(::Frame) -> Float32
```
Get the horizontal alignment of the frames optional label widget. In `[0, 1]`.
"""

@document get_layout """
```
get_layout(::HeaderBar) -> String
```
Get layout string of the header bar.
"""

@document get_left_margin """
```
get_left_margin(::TextView) -> Float32
```
Get distance between the left side of the text and the text views fame.
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
Get bottom margin of the widget, in pixels.
"""

@document get_margin_end """
```
get_margin_end(::Widget) -> Float32
```
Get right margin of the widget, in pixels.
"""

@document get_margin_start """
```
get_margin_start(::Widget) -> Float32
```
Get left margin of the widget, in pixels.
"""

@document get_margin_top """
```
get_margin_top(::Widget) -> Float32
```
Get top margin of the widget, in pixels.
"""

@document get_max_length """
```
get_max_length(::Entry) -> Signed
```
Get maximum number of characters, or `-1` if unlimited.
"""

@document get_max_n_columns """
```
get_max_n_columns(grid_view::GridView) -> Signed
```
Get maximum number of columns, or `-1` if unlimited.
"""

@document get_max_width_chars """
```
get_max_width_chars(::Label) -> Signed
```
Get maximum number of characters for which the label should allocate horizontal space, or `-1` if unlimited.
"""

@document get_min_n_columns """
```
get_min_n_columns(grid_view::GridView) -> Signed
```
Get minimum number of columns, or `-1` if unlimited.
"""

@document get_min_value """
```
get_min_value(::LevelBar) -> Float32
```
Get lower bound of the range expressed by level bar.
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
Get display mode of level bar.
"""

@document get_n_columns """
```
get_n_columns(::ColumnView) -> Unsigned
```
Get current number of columns.
"""

@document get_n_digits """
```
get_n_digits(::SpinButton) -> Signed
```
Get number of digits the spin button should display, or `-1` if unlimited.
"""

@document get_n_items """
```
get_n_items(::Box) -> Unsigned
get_n_items(::ListView) -> Unsigned
get_n_items(::GridView) -> Unsigned
```
Get number of children.
"""

@document get_n_pages """
```
get_n_pages(::Notebook) -> Unsigned 
```
Get number of pages.
"""

@document get_n_pixels """
```
get_n_pixels(::Image) -> Unsigned
```
Get number of pixels, equal to `width * height`.
"""

@document get_n_rows """
```
get_n_rows(::ColumnView) -> Unsigned
```
Get current number of rows.
"""

@document get_n_vertices """
```
get_n_vertices(::Shape) -> Unsigned
```
Get number of OpenGL vertices.
"""

@document get_name """
```
get_name(::Icon) -> String
get_name(::FileDescriptor) -> String 
get_name(::FileFilter) -> String
```
Get cleartext identifier.
"""

@document get_native_handle """
```
get_native_handle(::TextureObject) -> Cuint
get_native_handle(::Shape) -> Cuint
```
Get native OpenGL handle.
"""

@document get_natural_size """
```
get_natural_size(::Widget) -> Vector2f
```
Get the size the window would prefer to display at, if given infinite space and no expansion.
"""

@document get_only_listens_to_button """
```
get_only_listens_to_button(gesture::SingleClickGesture) -> Bool
```
Get whether the event controller should not capture events send by a touch device.
"""

@document get_opacity """
```
get_opacity(::Widget) -> Float32
```
Get current opacity, in `[0, 1]`.
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
Get parent folder. If `self` points to root, the result may not exist.
"""

@document get_path """
```
get_path(::FileDescriptor) -> String
```
Get absolute path to object pointed to be file descriptor.
"""

@document get_path_relative_to """
```
get_path_relative_to(self::FileDescriptor, other::FileDescriptor) -> String
```
Get relative path from `self` to `other`.
"""

@document get_pixel """
```
get_pixel(image::Image, x::Integer, y::Integer) -> RGBA
```
Get pixel at given position, 1-indexed.
"""

@document get_position """
```
get_position(::Widget) -> Vector2f
```
Get current position in screen, relative to the toplevel widgets origin, in pixels.
---
```
get_position(::Grid, ::Widget) -> Vector2i
```
Get row- and column-index of widget, 1-indexed.
---
```
get_position(::Paned) -> Int32
```
Get the offset of the handle from the center.
"""

@document get_program_id """
```
get_program_id(::Shader) -> Cuint
```
Get native handle of the OpenGL shader program.
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
Get phase at which the event controller will capture events.
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
Get relative position of the popover relative to its attachment.
"""

@document get_revealed """
```
get_revealed(::Revealer) -> Bool
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
Get distance between two rows.
"""

@document get_rows_homogeneous """
```
get_rows_homogeneous(::Grid) -> Bool
```
Get whether all rows should allocate the same height.
"""

@document get_scale_delta """
```
get_scale_delta(::PinchZoomEventController) -> Float32
```
Get the difference between the current scale of the pinch-zoom-gesture, and the scale at the point the gesture started.
"""

@document get_scale_mode """
```
get_scale_mode(::TextureObject) -> ScaleMode
```
Get OpenGL scale mode the texture uses.
"""

@document get_scope """
```
get_scope(::ShortcutEventController) -> ShortcutScope
```
Get scope in which the controller listens for shortcut events.
"""

@document get_scrollbar_placement """
```
get_scrollbar_placement(::Viewport) -> CornerPlacement
```
Get position of both scrollbars relative to the viewports center.
"""

@document get_selectable """
```
get_selectable(::Label) -> Bool
```
Get whether the user can select part of the label, as would be needed to copy its text.
"""

@document get_selected """
```
get_selected(::DropDown) -> DropDownID
```
Get the ID of the currently selected item
"""

@document get_selection """
```
get_selection(::SelectionModel) -> Vector{Int64}
```
Get all currently selected items, 1-based.
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

@document get_shortcuts """
```
get_shortcuts(action::Action) -> Vector{ShortcutTrigger}
```
Get all registered shortcuts.
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
Get whether the spin button should over- / underflow when reaching the upper or lower end of its range.
"""

@document get_show_arrow """
```
get_show_arrow(::DropDown) -> Bool
```
Get whether an arrow should be drawn next to the widget of the currently selected item.
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

@document get_show_title_buttons """
```
get_show_title_buttons(::HeaderBar) -> Bool
```
Get whether the "close", "minimize", and/or "maximize" button should be visible.
"""

@document get_single_click_activate """
```
get_single_click_activate(::ListView) -> Bool
get_single_click_activate(::GridView) -> Bool
get_single_click_activate(::ColumnView) -> Bool
```
Get whether simply hovering above a child will select it.
"""

@document get_size """
```
get_size(::TextureObject) -> Vector2i
get_size(::Icon) -> Vector2i
get_size(::Image) -> Vector2i
```
Get resolution of the underlying image.
--
```
get_size(::Grid, ::Widget) -> Vector2i
```
Get number of rows and columns.
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
Get size request, or `(0, 0)` if not size was requested.
"""

@document get_spacing """
```
get_spacing(::Box) -> Float32
```
Get distance drawn between any two items, in pixels.
"""

@document get_start_child_resizable """
```
get_start_child_resizable(::Paned) -> Bool
```
Get whether the start child should resize itself when the paned is resized.
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
Get position at which the drag gesture was first recognized, in pixels, relative to the origin of the widget capturing events.
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
get_step_increment(::Adjusment) -> Float32
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
an argument for the callback.
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
Get whether the text entry is in "password mode"
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
Get window title.
---
```
get_title(::ColumnViewColumn) -> String 
```
Get the title for this column.
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

@document get_transition_duration """
```
get_transition_duration(::Stack) -> Time
get_transition_duration(::Revealer) -> Time
```
Get animation duration.
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
Get float registered as uniform, or `0.0` if no such uniform was registered.
"""

@document get_uniform_int """
```
get_uniform_int(::RenderTask, name::String) -> Cint
```
Get int registered as uniform, or `0` if no such uniform was registered.
"""

@document get_uniform_location """
```
get_uniform_location(::Shader, name::String) -> Cuint
```
Get OpenGL shader program uniform location for the given uniform name, or `0` if no such uniform exists.
"""

@document get_uniform_rgba """
```
get_uniform_rgba(task::RenderTask, name::String) -> RGBA
```
Get uniform vec4, or `RGBA(0, 0, 0, 0)` if no such uniform exists.
"""

@document get_uniform_transform """
```
get_uniform_transform(task::RenderTask, name::String) -> GLTransform
```
Get uniform mat4x4, or the identity transfrm if no such uniform exists.
"""

@document get_uniform_uint """
```
get_uniform_uint(::RenderTask, name::String) -> Cuint
```
Get uniform uint, or `0` if no such uniform exists.
"""

@document get_uniform_vec2 """
```
get_uniform_vec2(task::RenderTask, name::String) -> Vector2f
```
Get uniform vec2, or `Vector2f(0, 0)` if no such uniform exists.
"""

@document get_uniform_vec3 """
```
get_uniform_vec3(task::RenderTask, name::String) 
```
Get uniform vec3, or `Vector3f(0, 0, 0)` if no such uniform exists.
"""

@document get_uniform_vec4 """
```
get_uniform_vec4(task::RenderTask, name::String) 
```
Get uniform vec4, or `Vector4f(0, 0, 0, 0)` if no such uniform exists.
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
Get URI to file location, even if it does not point to an existing file.
"""

@document get_use_markup """
```
get_use_markup(::Label) -> Bool
```
Get whether the label should use pango markup, `true` by default.
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
get_value(file::KeyFile, group::String, key::String, type::Type{<:AbstractFloat}) 
get_value(file::KeyFile, group::String, key::String, type::Type{<:Signed}) 
get_value(file::KeyFile, group::String, key::String, type::Type{<:Unsigned}) 
get_value(file::KeyFile, group::String, key::String, type::Type{Vector{T}}) where T<:AbstractFloat 
get_value(file::KeyFile, group::String, key::String, type::Type{Vector{T}}) where T<:Signed 
get_value(file::KeyFile, group::String, key::String, type::Type{Vector{T}}) where T<:Unsigned 
get_value(file::KeyFile, group::String, key::String, type::Type{Bool}) 
get_value(file::KeyFile, group::String, key::String, type::Type{String}) 
get_value(file::KeyFile, group::String, key::String, type::Type{RGBA}) 
get_value(file::KeyFile, group::String, key::String, type::Type{Image}) 
get_value(file::KeyFile, group::String, key::String, type::Type{Vector{Bool}}) 
get_value(file::KeyFile, group::String, key::String, type::Type{Vector{String}}) 
```
Deserialize a value from the keyfile. Returns a default value if the key-value pair or group does not
"""

@document get_velocity """
```
get_velocity(SwipeEventController) -> Vector2f
```
Get current velcity, in pixles.
"""

@document get_vertex_color """
```
get_vertex_color(::Shape, index::Integer) -> RGBA
```
Get color of vertex at given index.
"""

@document get_vertex_color_location """
```
get_vertex_color_location() -> Cuint
```
Get native uniform location for `_vertex_color` input value of all vertex shaders.
"""

@document get_vertex_position """
```
get_vertex_position(::Shape, ::Integer) -> Vector2f
```
Get position of vertex at given index, in OpenGL coordinates.
"""

@document get_vertex_position_location """
```
get_vertex_position_location() -> Cuint
```
Get native uniform location for `_vertex_position` input value of all vertex shaders.
"""

@document get_vertex_shader_id """
```
get_vertex_shader_id(::Shader) -> Cuint
```
Get native OpenGL handle of vertex shader component of a shader program.
"""

@document get_vertex_texture_coordinate """
```
get_vertex_texture_coordinate(::Shape, index::Integer) -> Vector2f
```
Get texture coordinate of vertex at given index.
"""

@document get_vertex_texture_coordinate_location """
```
get_vertex_texture_coordinate_location() -> Cuint
```
Get native uniform location for `_vertex_texture_coordinate` input value of all vertex shaders.
"""

@document get_vertical_adjustment """
```
get_vertical_adjustment(::Viewport) -> Adjustment
```
Get underlying adjustment of the vertical scrollbar.
"""

@document get_vertical_alignment """
```
get_vertical_alignment(::Widget) -> Alignment
```
Get alignment along the y-axis.
"""

@document get_vertical_scrollbar_policy """
```
get_vertical_scrollbar_policy(::Viewport) -> ScrollbarPolicy
```
Get policy of vertical scrollbar.
"""

@document get_visible_child """
```
get_visible_child(stack::Stack) -> StackID
```
Get ID of currently selected child.
"""

@document get_was_modified """
```
get_was_modified(::TextView) -> Bool
```
Get whether the "was modified" flag of a textview was set to `true`.
"""

@document get_wrap_mode """
```
get_wrap_mode(::TextureObject) -> TextureWrapMode
```
Get OpenGL texture wrap mode.
---
```
get_wrap_mode(::Label) -> LabelWrapMode
```
Get wrap mode use to determine at which point in a line a linebreak will be inserted.
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
Get vertical alignment of the labels text.
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
has_axis(::StylusEventController, axis::mousetrap.detail._DeviceAxis) 
```
TODO
"""

@document has_column_with_title """
```
has_column_with_title(column_view::ColumnView, title::String) 
```
TODO
"""

@document has_group """
```
has_group(::KeyFile, group::String) 
```
TODO
"""

@document has_icon """
```
has_icon(theme::IconTheme, icon::Icon) 
has_icon(theme::IconTheme, id::String) 
```
TODO
"""

@document has_key """
```
has_key(::KeyFile, group::String, key::String) 
```
TODO
"""

@document hide! """
```
hide!(::Widget) 
```
TODO
"""

@document hold! """
```
hold!(::Application) 
```
TODO
"""

@document hsva_to_rgba """
```
hsva_to_rgba(hsva::HSVA) 
```
TODO
"""

@document html_code_to_rgba """
```
html_code_to_rgba(code::String) 
```
TODO
"""

@document insert! """
```
insert!(f, drop_down::DropDown, inde::Integer, list_::Widget, label_::Widget) 
insert!(f, drop_down::DropDown, inde::Integer, list_::Widget, label_::Widget, data::Data_t) where Data_t 
insert!(list_view::ListView, ::Widget, inde::Integer) 
insert!(list_view::ListView, ::Widget, inde::Integer, iterator::ListViewIterator) 
insert!(grid_view::GridView, inde::Integer, ::Widget) 
insert!(grid::Grid, ::Widget, row_i::Signed, column_i::Signed; n_horizontal_cells, n_vertical_cells) 
insert!(notebook::Notebook, inde::Integer, child_::Widget, label_::Widget) 
```
TODO
"""

@document insert_after! """
```
insert_after!(bo::Box, to_append::Widget, after::Widget) 
```
TODO
"""

@document insert_column! """
```
insert_column!(column_view::ColumnView, inde::Integer, title::String) 
```
TODO
"""

@document insert_column_at! """
```
insert_column_at!(grid::Grid, column_i::Signed) 
```
TODO
"""

@document insert_row_at! """
```
insert_row_at!(grid::Grid, row_i::Signed) 
```
TODO
"""

@document is_cancelled """
```
is_cancelled(::FileMonitor) 
```
TODO
"""

@document is_file """
```
is_file(::FileDescriptor) 
```
TODO
"""

@document is_folder """
```
is_folder(::FileDescriptor) 
```
TODO
"""

@document is_local """
```
is_local(::Clipboard) 
```
TODO
"""

@document is_symlink """
```
is_symlink(::FileDescriptor) 
```
TODO
"""

@document is_valid_html_code """
```
is_valid_html_code(code::String) 
```
TODO
"""

@document main """
```
main(f; application_id) 
```
TODO
"""

@document make_current """
```
make_current(::RenderArea) 
```
TODO
"""

@document mark_as_busy! """
```
mark_as_busy!(::Application) 
```
TODO
"""

@document microseconds """
```
microseconds(n::AbstractFloat) 
```
TODO
"""

@document milliseconds """
```
milliseconds(n::AbstractFloat) 
```
TODO
"""

@document minutes """
```
minutes(n::AbstractFloat) 
```
TODO
"""

@document mouse_button_01_pressed """
```
mouse_button_01_pressed(modifier_state::mousetrap.detail._ModifierState) 
```
TODO
"""

@document mouse_button_02_pressed """
```
mouse_button_02_pressed(modifier_state::mousetrap.detail._ModifierState) 
```
TODO
"""

@document move! """
```
move!(from::FileDescriptor, to::FileDescriptor, allow_overwrite::Bool; make_backup, follow_symlink) 
```
TODO
"""

@document nanoseconds """
```
nanoseconds(n::Int64) 
```
TODO
"""

@document next_page! """
```
next_page!(::Notebook) 
```
TODO
"""

@document on_accept! """
```
on_accept!(f, chooser::FileChooser) 
on_accept!(f, chooser::FileChooser, data::Data_t) where Data_t 
```
TODO
"""

@document on_cancel! """
```
on_cancel!(f, chooser::FileChooser) 
on_cancel!(f, chooser::FileChooser, data::Data_t) where Data_t 
```
TODO
"""

@document on_file_changed! """
```
on_file_changed!(f, monitor::FileMonitor) 
on_file_changed!(f, monitor::FileMonitor, data::Data_t) where Data_t 
```
TODO
"""

@document popdown! """
```
popdown!(::Popover) 
popdown!(::PopoverButton) 
```
TODO
"""

@document popoup! """
```
popoup!(::PopoverButton) 
```
TODO
"""

@document popup! """
```
popup!(::Popover) 
```
TODO
"""

@document present! """
```
present!(::Window) 
present!(::FileChooser) 
present!(::Popover) 
```
TODO
"""

@document previous_page! """
```
previous_page!(::Notebook) 
```
TODO
"""

@document pulse """
```
pulse(::ProgressBar) 
```
TODO
"""

@document push_back! """
```
push_back!(bo::Box, ::Widget) 
push_back!(f, drop_down::DropDown, list_::Widget, label_::Widget) 
push_back!(f, drop_down::DropDown, list_::Widget, label_::Widget, data::Data_t) where Data_t 
push_back!(list_view::ListView, ::Widget) 
push_back!(list_view::ListView, ::Widget, iterator::ListViewIterator) 
push_back!(grid_view::GridView, ::Widget) 
push_back!(notebook::Notebook, child_::Widget, label_::Widget) 
push_back!(header_bar::HeaderBar, ::Widget) 
```
TODO
"""

@document push_back_column! """
```
push_back_column!(column_view::ColumnView, title::String) 
```
TODO
"""

@document push_back_row! """
```
push_back_row!(column_view::ColumnView, widgets::Widget...) 
```
TODO
"""

@document push_front! """
```
push_front!(bo::Box, ::Widget) 
push_front!(f, drop_down::DropDown, list_::Widget, label_::Widget) 
push_front!(f, drop_down::DropDown, list_::Widget, label_::Widget, data::Data_t) where Data_t 
push_front!(list_view::ListView, ::Widget) 
push_front!(list_view::ListView, ::Widget, iterator::ListViewIterator) 
push_front!(grid_view::GridView, ::Widget) 
push_front!(notebook::Notebook, child_::Widget, label_::Widget) 
push_front!(header_bar::HeaderBar, ::Widget) 
```
TODO
"""

@document push_front_column! """
```
push_front_column!(column_view::ColumnView, title::String) 
```
TODO
"""

@document push_front_row! """
```
push_front_row!(column_view::ColumnView, widgets::Widget...) 
```
TODO
"""

@document query_info """
```
query_info(::FileDescriptor) 
```
TODO
"""

@document queue_render """
```
queue_render(::RenderArea) 
```
TODO
"""

@document quit! """
```
quit!(::Application) 
```
TODO
"""

@document radians """
```
radians(::Number) 
```
TODO
"""

@document read_symlink """
```
read_symlink(self::FileDescriptor) 
```
TODO
"""

@document redo! """
```
redo!(::TextView) 
```
TODO
"""

@document release! """
```
release!(::Application) 
```
TODO
"""

@document remove! """
```
remove!(bo::Box, ::Widget) 
remove!(list_view::ListView, inde::Integer) 
remove!(list_view::ListView, inde::Integer, iterator::ListViewIterator) 
remove!(grid_view::GridView, ::Widget) 
remove!(grid::Grid, ::Widget) 
remove!(header_bar::HeaderBar, ::Widget) 
remove!(::DropDown, id::String) 
remove!(::Notebook, position::Int64) 
```
TODO
"""

@document remove_action! """
```
remove_action!(::Application, id::String) 
```
TODO
"""

@document remove_center_child! """
```
remove_center_child!(::CenterBox) 
```
TODO
"""

@document remove_child """
```
remove_child(::Viewport) 
```
TODO
"""

@document remove_child! """
```
remove_child!(fixed::Fixed, child::Widget) 
remove_child!(::Window) 
remove_child!(::AspectFrame) 
remove_child!(::Button) 
remove_child!(::CheckButton) 
remove_child!(::ToggleButton) 
remove_child!(::Expander) 
remove_child!(::Frame) 
remove_child!(overlay::Overlay) 
remove_child!(::Popover) 
remove_child!(::PopoverButton) 
remove_child!(stack::Stack, id::String) 
remove_child!(::Revealer) 
```
TODO
"""

@document remove_column! """
```
remove_column!(column_view::ColumnView, column::ColumnViewColumn) 
```
TODO
"""

@document remove_controller! """
```
remove_controller!(::Widget, controller::EventController) 
```
TODO
"""

@document remove_end_child """
```
remove_end_child(::Paned) 
```
TODO
"""

@document remove_end_child! """
```
remove_end_child!(::CenterBox) 
```
TODO
"""

@document remove_label_widget! """
```
remove_label_widget!(::Expander) 
remove_label_widget!(::Frame) 
```
TODO
"""

@document remove_marker! """
```
remove_marker!(::LevelBar, name::String) 
```
TODO
"""

@document remove_overlay! """
```
remove_overlay!(overlay::Overlay, child::Widget) 
```
TODO
"""

@document remove_popover! """
```
remove_popover!(::PopoverButton) 
```
TODO
"""

@document remove_primary_icon! """
```
remove_primary_icon!(::Entry) 
```
TODO
"""

@document remove_row_at! """
```
remove_row_at!(grid::Grid, row_i::Signed) 
```
TODO
"""

@document remove_secondary_icon! """
```
remove_secondary_icon!(::Entry) 
```
TODO
"""

@document remove_start_child """
```
remove_start_child(::Paned) 
```
TODO
"""

@document remove_start_child! """
```
remove_start_child!(::CenterBox) 
```
TODO
"""

@document remove_tick_callback! """
```
remove_tick_callback!(::Widget) 
```
TODO
"""

@document remove_titlebar_widget! """
```
remove_titlebar_widget!(::Window) 
```
TODO
"""

@document remove_tooltip_widget! """
```
remove_tooltip_widget!(::Widget) 
```
TODO
"""

@document render """
```
render(shape::Shape, shader::Shader, transform::GLTransform) 
render(::RenderTask) 
```
TODO
"""

@document render_render_tasks """
```
render_render_tasks(::RenderArea) 
```
TODO
"""

@document reset! """
```
reset!(::GLTransform) 
```
TODO
"""

@document reset_text_to_value_function! """
```
reset_text_to_value_function!(::SpinButton) 
```
TODO
"""

@document reset_value_to_text_function! """
```
reset_value_to_text_function!(::SpinButton) 
```
TODO
"""

@document restart! """
```
restart!(clock::Clock) 
```
TODO
"""

@document rgba_to_hsva """
```
rgba_to_hsva(rgba::RGBA) 
```
TODO
"""

@document rgba_to_html_code """
```
rgba_to_html_code(rgba::RGBA) 
```
TODO
"""

@document rotate! """
```
rotate!(transform::GLTransform, angle::Angle) 
rotate!(transform::GLTransform, angle::Angle, origin::Vector2f) 
rotate!(::Shape, angle::Angle) 
rotate!(::Shape, angle::Angle, origin::Vector2f) 
```
TODO
"""

@document run! """
```
run!(app::Application) 
```
TODO
"""

@document save_to_file """
```
save_to_file(::Image, path::String) 
save_to_file(::KeyFile, path::String) 
```
TODO
"""

@document scale! """
```
scale!(transform::GLTransform, x_scale::AbstractFloat, y_scale::AbstractFloat) 
```
TODO
"""

@document seconds """
```
seconds(n::AbstractFloat) 
```
TODO
"""

@document select! """
```
select!(model::SelectionModel, i::Integer) 
select!(model::SelectionModel, i::Integer, unselect_others::Bool) 
```
TODO
"""

@document select_all! """
```
select_all!(::SelectionModel) 
```
TODO
"""

@document self_is_focused """
```
self_is_focused(::FocusEventController) 
```
TODO
"""

@document self_or_child_is_focused """
```
self_or_child_is_focused(::FocusEventController) 
```
TODO
"""

@document set_acceleration_rate! """
```
set_acceleration_rate!(::SpinButton, factor::AbstractFloat) 
```
TODO
"""

@document set_accept_label! """
```
set_accept_label!(::FileChooser, label::String) 
```
TODO
"""

@document set_action! """
```
set_action!(button::Button, action::Action) 
```
TODO
"""

@document set_alignment! """
```
set_alignment!(::Widget, both::mousetrap.detail._Alignment) 
```
TODO
"""

@document set_allow_only_numeric! """
```
set_allow_only_numeric!(::SpinButton, b::Bool) 
```
TODO
"""

@document set_always_show_arrow! """
```
set_always_show_arrow!(::PopoverButton, b::Bool) 
```
TODO
"""

@document set_application! """
```
set_application!(window::Window, app::Application) 
```
TODO
"""

@document set_autohide! """
```
set_autohide!(::Popover, b::Bool) 
```
TODO
"""

@document set_bottom_margin! """
```
set_bottom_margin!(::TextView, margin::AbstractFloat) 
```
TODO
"""

@document set_can_respond_to_input! """
```
set_can_respond_to_input!(::Widget, b::Bool) 
```
TODO
"""

@document set_center_child! """
```
set_center_child!(center_bo::CenterBox, child::Widget) 
```
TODO
"""

@document set_centroid! """
```
set_centroid!(::Shape, centroid::Vector2f) 
```
TODO
"""

@document set_child! """
```
set_child!(window::Window, child::Widget) 
set_child!(aspect_frame::AspectFrame, child::Widget) 
set_child!(button::Button, child::Widget) 
set_child!(check_button::CheckButton, child::Widget) 
set_child!(toggle_button::ToggleButton, child::Widget) 
set_child!(viewport::Viewport, child::Widget) 
set_child!(expander::Expander, child::Widget) 
set_child!(frame::Frame, child::Widget) 
set_child!(overlay::Overlay, child::Widget) 
set_child!(popover::Popover, child::Widget) 
set_child!(popover_button::PopoverButton, child::Widget) 
set_child!(revealer::Revealer, child::Widget) 
```
TODO
"""

@document set_child_position! """
```
set_child_position!(fixed::Fixed, child::Widget, position::Vector2f) 
```
TODO
"""

@document set_child_x_alignment! """
```
set_child_x_alignment!(::AspectFrame, alignment::AbstractFloat) 
```
TODO
"""

@document set_child_y_alignment! """
```
set_child_y_alignment!(::AspectFrame, alignment::AbstractFloat) 
```
TODO
"""

@document set_column_spacing! """
```
set_column_spacing!(::Grid, spacing::AbstractFloat) 
```
TODO
"""

@document set_columns_homogeneous! """
```
set_columns_homogeneous!(::Grid, b::Bool) 
```
TODO
"""

@document set_comment_above! """
```
set_comment_above!(file::KeyFile, group::String, comment::String) 
set_comment_above!(file::KeyFile, group::String, key::String, comment::String) 
```
TODO
"""

@document set_comment_above_group! """
```
set_comment_above_group!(::KeyFile, group::String, comment::String) 
```
TODO
"""

@document set_comment_above_key! """
```
set_comment_above_key!(::KeyFile, group::String, key::String, comment::String) 
```
TODO
"""

@document set_current_blend_mode """
```
set_current_blend_mode(blend_mode::mousetrap.detail._BlendMode; allow_alpha_blending) 
```
TODO
"""

@document set_cursor! """
```
set_cursor!(::Widget, cursor::mousetrap.detail._CursorType) 
```
TODO
"""

@document set_cursor_from_image! """
```
set_cursor_from_image!(::Widget, image::Image, offset::StaticArraysCore.SVector{2, Int32}) 
```
TODO
"""

@document set_cursor_visible! """
```
set_cursor_visible!(::TextView, b::Bool) 
```
TODO
"""

@document set_default_widget! """
```
set_default_widget!(window::Window, ::Widget) 
```
TODO
"""

@document set_delay_factor """
```
set_delay_factor(::LongPressEventController, factor::AbstractFloat) 
```
TODO
"""

@document set_destroy_with_parent! """
```
set_destroy_with_parent!(::Window, n::Bool) 
```
TODO
"""

@document set_display_mode! """
```
set_display_mode!(::ProgressBar, mode::mousetrap.detail._ProgressBarDisplayMode) 
```
TODO
"""

@document set_editable! """
```
set_editable!(::TextView, b::Bool) 
```
TODO
"""

@document set_ellipsize_mode! """
```
set_ellipsize_mode!(::Label, mode::mousetrap.detail._EllipsizeMode) 
```
TODO
"""

@document set_enable_rubberband_selection """
```
set_enable_rubberband_selection(::ListView, b::Bool) 
set_enable_rubberband_selection(::GridView, b::Bool) 
set_enable_rubberband_selection(::ColumnView, b::Bool) 
```
TODO
"""

@document set_enabled! """
```
set_enabled!(::Action, b::Bool) 
```
TODO
"""

@document set_end_child! """
```
set_end_child!(center_bo::CenterBox, child::Widget) 
set_end_child!(paned::Paned, child::Widget) 
```
TODO
"""

@document set_end_child_resizable! """
```
set_end_child_resizable!(::Paned, b::Bool) 
```
TODO
"""

@document set_end_child_shrinkable """
```
set_end_child_shrinkable(::Paned, b::Bool) 
```
TODO
"""

@document set_expand! """
```
set_expand!(::Widget, b::Bool) 
```
TODO
"""

@document set_expand_horizontally! """
```
set_expand_horizontally!(::Widget, b::Bool) 
```
TODO
"""

@document set_expand_vertically! """
```
set_expand_vertically!(::Widget, b::Bool) 
```
TODO
"""

@document set_file! """
```
set_file!(clipboard::Clipboard, file::FileDescriptor) 
```
TODO
"""

@document set_fixed_width """
```
set_fixed_width(::ColumnViewColumn, width::AbstractFloat) 
```
TODO
"""

@document set_focus_on_click! """
```
set_focus_on_click!(::Widget, b::Bool) 
```
TODO
"""

@document set_focus_visible! """
```
set_focus_visible!(::Window, b::Bool) 
```
TODO
"""

@document set_fraction! """
```
set_fraction!(::ProgressBar, zero_to_one::AbstractFloat) 
```
TODO
"""

@document set_fullscreen! """
```
set_fullscreen!(::Window) 
```
TODO
"""

@document set_function! """
```
set_function!(f, action::Action) 
set_function!(f, action::Action, data::Data_t) where Data_t 
```
TODO
"""

@document set_has_base_arrow! """
```
set_has_base_arrow!(::Popover, b::Bool) 
```
TODO
"""

@document set_has_border! """
```
set_has_border!(::Notebook, b::Bool) 
```
TODO
"""

@document set_has_close_button! """
```
set_has_close_button!(::Window, b::Bool) 
```
TODO
"""

@document set_has_frame """
```
set_has_frame(::PopoverButton, b::Bool) 
```
TODO
"""

@document set_has_frame! """
```
set_has_frame!(::Button, b::Bool) 
set_has_frame!(::Viewport, b::Bool) 
set_has_frame!(::Entry, b::Bool) 
```
TODO
"""

@document set_has_wide_handle """
```
set_has_wide_handle(::Paned, b::Bool) 
```
TODO
"""

@document set_header_menu! """
```
set_header_menu!(column::ColumnViewColumn, model::MenuModel) 
```
TODO
"""

@document set_hide_on_close! """
```
set_hide_on_close!(::Window, b::Bool) 
```
TODO
"""

@document set_hide_on_overflow! """
```
set_hide_on_overflow!(::Widget, b::Bool) 
```
TODO
"""

@document set_homogeneous! """
```
set_homogeneous!(::Box, b::Bool) 
```
TODO
"""

@document set_horizontal_alignment! """
```
set_horizontal_alignment!(::Widget, alignment::mousetrap.detail._Alignment) 
```
TODO
"""

@document set_horizontal_scrollbar_policy! """
```
set_horizontal_scrollbar_policy!(::Viewport, policy::mousetrap.detail._ScrollbarVisibilityPolicy) 
```
TODO
"""

@document set_icon! """
```
set_icon!(button::Button, icon::Icon) 
```
TODO
"""

@document set_image! """
```
set_image!(clipboard::Clipboard, image::Image) 
```
TODO
"""

@document set_inverted! """
```
set_inverted!(::LevelBar, b::Bool) 
```
TODO
"""

@document set_is_active! """
```
set_is_active!(::Switch, b::Bool) 
set_is_active!(::ToggleButton, b::Bool) 
```
TODO
"""

@document set_is_circular """
```
set_is_circular(::Button, b::Bool) 
set_is_circular(::ToggleButton, b::Bool) 
```
TODO
"""

@document set_is_circular! """
```
set_is_circular!(::PopoverButton, b::Bool) 
```
TODO
"""

@document set_is_decorated! """
```
set_is_decorated!(::Window, b::Bool) 
```
TODO
"""

@document set_is_focusable! """
```
set_is_focusable!(::Widget, b::Bool) 
```
TODO
"""

@document set_is_horizontally_homogeneous """
```
set_is_horizontally_homogeneous(::Stack, b::Bool) 
```
TODO
"""

@document set_is_inverted! """
```
set_is_inverted!(::ProgressBar, b::Bool) 
```
TODO
"""

@document set_is_modal! """
```
set_is_modal!(::Window, b::Bool) 
set_is_modal!(::FileChooser, modal::Bool) 
```
TODO
"""

@document set_is_resizable! """
```
set_is_resizable!(::ColumnViewColumn, b::Bool) 
```
TODO
"""

@document set_is_scrollable! """
```
set_is_scrollable!(::Notebook, b::Bool) 
```
TODO
"""

@document set_is_spinning! """
```
set_is_spinning!(::Spinner, b::Bool) 
```
TODO
"""

@document set_is_vertically_homogeneous """
```
set_is_vertically_homogeneous(::Stack, b::Bool) 
```
TODO
"""

@document set_is_visible! """
```
set_is_visible!(::Widget, b::Bool) 
set_is_visible!(::ColumnViewColumn, b::Bool) 
set_is_visible!(::Shape, b::Bool) 
```
TODO
"""

@document set_justify_mode! """
```
set_justify_mode!(::Label, mode::mousetrap.detail._JustifyMode) 
set_justify_mode!(::TextView, mode::mousetrap.detail._JustifyMode) 
```
TODO
"""

@document set_kinetic_scrolling_enabled! """
```
set_kinetic_scrolling_enabled!(::Viewport, b::Bool) 
```
TODO
"""

@document set_label_widget! """
```
set_label_widget!(expander::Expander, child::Widget) 
set_label_widget!(frame::Frame, label::Widget) 
```
TODO
"""

@document set_label_x_alignment! """
```
set_label_x_alignment!(::Frame, ::AbstractFloat) 
```
TODO
"""

@document set_layout! """
```
set_layout!(::HeaderBar, layout::String) 
```
TODO
"""

@document set_left_margin! """
```
set_left_margin!(::TextView, margin::AbstractFloat) 
```
TODO
"""

@document set_log_file """
```
set_log_file(path::String) 
```
TODO
"""

@document set_lower! """
```
set_lower!(adjustment::Adjustment, ::Number) 
set_lower!(::Scale, value::AbstractFloat) 
set_lower!(::SpinButton, value::AbstractFloat) 
```
TODO
"""

@document set_margin_bottom! """
```
set_margin_bottom!(::Widget, margin::AbstractFloat) 
```
TODO
"""

@document set_margin_end! """
```
set_margin_end!(::Widget, margin::AbstractFloat) 
```
TODO
"""

@document set_margin_horizontal! """
```
set_margin_horizontal!(::Widget, margin::AbstractFloat) 
```
TODO
"""

@document set_margin_margin! """
```
set_margin_margin!(::Widget, margin::AbstractFloat) 
```
TODO
"""

@document set_margin_start! """
```
set_margin_start!(::Widget, margin::AbstractFloat) 
```
TODO
"""

@document set_margin_top! """
```
set_margin_top!(::Widget, margin::AbstractFloat) 
```
TODO
"""

@document set_margin_vertical! """
```
set_margin_vertical!(::Widget, margin::AbstractFloat) 
```
TODO
"""

@document set_max_length! """
```
set_max_length!(::Entry, n::Integer) 
```
TODO
"""

@document set_max_n_columns! """
```
set_max_n_columns!(grid_view::GridView, n::Integer) 
```
TODO
"""

@document set_max_value! """
```
set_max_value!(::LevelBar, value::AbstractFloat) 
```
TODO
"""

@document set_max_width_chars! """
```
set_max_width_chars!(::Label, n::Integer) 
```
TODO
"""

@document set_maximized! """
```
set_maximized!(::Window) 
```
TODO
"""

@document set_min_n_columns! """
```
set_min_n_columns!(grid_view::GridView, n::Integer) 
```
TODO
"""

@document set_min_value! """
```
set_min_value!(::LevelBar, value::AbstractFloat) 
```
TODO
"""

@document set_mode! """
```
set_mode!(::LevelBar, mode::mousetrap.detail._LevelBarMode) 
```
TODO
"""

@document set_n_digits! """
```
set_n_digits!(::SpinButton, n::Integer) 
```
TODO
"""

@document set_only_listens_to_button! """
```
set_only_listens_to_button!(gesture::SingleClickGesture, button::mousetrap.detail._ButtonID) 
```
TODO
"""

@document set_opacity! """
```
set_opacity!(::Widget, opacity::AbstractFloat) 
```
TODO
"""

@document set_orientation """
```
set_orientation(::ListView, orientation::mousetrap.detail._Orientation) 
set_orientation(::GridView, orientation::mousetrap.detail._Orientation) 
set_orientation(::Paned, orientation::mousetrap.detail._Orientation) 
```
TODO
"""

@document set_orientation! """
```
set_orientation!(::Box, orientation::mousetrap.detail._Orientation) 
set_orientation!(::CenterBox, orientation::mousetrap.detail._Orientation) 
set_orientation!(::LevelBar, orientation::mousetrap.detail._Orientation) 
set_orientation!(pan_controller::PanEventController) 
set_orientation!(::Grid, orientation::mousetrap.detail._Orientation) 
set_orientation!(::ProgressBar, orientation::mousetrap.detail._Orientation) 
set_orientation!(::Scrollbar, orientation::mousetrap.detail._Orientation) 
set_orientation!(::Separator, orientation::mousetrap.detail._Orientation) 
```
TODO
"""

@document set_pixel! """
```
set_pixel!(image::Image, ::Integer, y::Integer, color::RGBA) 
set_pixel!(image::Image, ::Integer, y::Integer, color::HSVA) 
```
TODO
"""

@document set_popover! """
```
set_popover!(popover_button::PopoverButton, popover::Popover) 
```
TODO
"""

@document set_popover_menu! """
```
set_popover_menu!(popover_button::PopoverButton, popover_menu::PopoverMenu) 
```
TODO
"""

@document set_popover_position! """
```
set_popover_position!(::PopoverButton, position::mousetrap.detail._RelativePosition) 
```
TODO
"""

@document set_position! """
```
set_position!(::Paned, position::Integer) 
```
TODO
"""

@document set_primary_icon! """
```
set_primary_icon!(entry::Entry, icon::Icon) 
```
TODO
"""

@document set_propagate_natural_height! """
```
set_propagate_natural_height!(::Viewport, b::Bool) 
```
TODO
"""

@document set_propagate_natural_width! """
```
set_propagate_natural_width!(::Viewport, b::Bool) 
```
TODO
"""

@document set_propagation_phase! """
```
set_propagation_phase!(controller::EventController) 
```
TODO
"""

@document set_quick_change_menu_enabled! """
```
set_quick_change_menu_enabled!(::Notebook, b::Bool) 
```
TODO
"""

@document set_ratio! """
```
set_ratio!(::AspectFrame, ratio::AbstractFloat) 
```
TODO
"""

@document set_relative_position! """
```
set_relative_position!(::Popover, position::mousetrap.detail._RelativePosition) 
```
TODO
"""

@document set_resource_path! """
```
set_resource_path!(::IconTheme, path::String) 
```
TODO
"""

@document set_revealed! """
```
set_revealed!(::Revealer, child_visible::Bool) 
```
TODO
"""

@document set_right_margin! """
```
set_right_margin!(::TextView, margin::AbstractFloat) 
```
TODO
"""

@document set_row_spacing! """
```
set_row_spacing!(::Grid, spacingadd::AbstractFloat) 
```
TODO
"""

@document set_rows_homogeneous! """
```
set_rows_homogeneous!(::Grid, b::Bool) 
```
TODO
"""

@document set_scale! """
```
set_scale!(::ImageDisplay, scale::Integer) 
```
TODO
"""

@document set_scale_mode! """
```
set_scale_mode!(texture::mousetrap.TextureObject, mode::mousetrap.detail._TextureWrapMode) 
```
TODO
"""

@document set_scope! """
```
set_scope!(controller::ShortcutEventController, scope::mousetrap.detail._ShortcutScope) 
```
TODO
"""

@document set_scrollbar_placement! """
```
set_scrollbar_placement!(::Viewport, placement::mousetrap.detail._CornerPlacement) 
```
TODO
"""

@document set_secondary_icon! """
```
set_secondary_icon!(entry::Entry, icon::Icon) 
```
TODO
"""

@document set_selectable! """
```
set_selectable!(::Label, b::Bool) 
```
TODO
"""

@document set_selected """
```
set_selected(::DropDown, id::String) 
```
TODO
"""

@document set_should_interpolate_size """
```
set_should_interpolate_size(::Stack, b::Bool) 
```
TODO
"""

@document set_should_snap_to_ticks! """
```
set_should_snap_to_ticks!(::SpinButton, b::Bool) 
```
TODO
"""

@document set_should_wrap! """
```
set_should_wrap!(::SpinButton, b::Bool) 
```
TODO
"""

@document set_show_arrow! """
```
set_show_arrow!(::DropDown, b::Bool) 
```
TODO
"""

@document set_show_column_separators """
```
set_show_column_separators(::ColumnView, b::Bool) 
```
TODO
"""

@document set_show_row_separators """
```
set_show_row_separators(::ColumnView, b::Bool) 
```
TODO
"""

@document set_show_separators """
```
set_show_separators(::ListView, b::Bool) 
```
TODO
"""

@document set_show_title_buttons! """
```
set_show_title_buttons!(::HeaderBar, b::Bool) 
```
TODO
"""

@document set_single_click_activate """
```
set_single_click_activate(::ListView, b::Bool) 
```
TODO
"""

@document set_single_click_activate! """
```
set_single_click_activate!(::ColumnView, b::Bool) 
```
TODO
"""

@document set_size_request! """
```
set_size_request!(::Widget, size::Vector2f) 
```
TODO
"""

@document set_spacing! """
```
set_spacing!(bo::Box, spacing::Number) 
```
TODO
"""

@document set_start_child! """
```
set_start_child!(center_bo::CenterBox, child::Widget) 
set_start_child!(paned::Paned, child::Widget) 
```
TODO
"""

@document set_start_child_resizable! """
```
set_start_child_resizable!(::Paned, b::Bool) 
```
TODO
"""

@document set_start_child_shrinkable """
```
set_start_child_shrinkable(::Paned, b::Bool) 
```
TODO
"""

@document set_startup_notification_identifier! """
```
set_startup_notification_identifier!(::Window, id::String) 
```
TODO
"""

@document set_state! """
```
set_state!(::Action, b::Bool) 
set_state!(::CheckButton, state::mousetrap.detail._CheckButtonState) 
```
TODO
"""

@document set_stateful_function! """
```
set_stateful_function!(f, action::Action) 
set_stateful_function!(f, action::Action, data::Data_t) where Data_t 
```
TODO
"""

@document set_step_increment! """
```
set_step_increment!(::Adjustment, value::AbstractFloat) 
set_step_increment!(::Scale, value::AbstractFloat) 
set_step_increment!(::SpinButton, value::AbstractFloat) 
```
TODO
"""

@document set_string! """
```
set_string!(clipboard::Clipboard, string::String) 
```
TODO
"""

@document set_surpress_debug """
```
set_surpress_debug(domain::String, b::Bool) 
```
TODO
"""

@document set_surpress_info """
```
set_surpress_info(domain::String, b::Bool) 
```
TODO
"""

@document set_tab_position! """
```
set_tab_position!(::Notebook, relative_position::mousetrap.detail._RelativePosition) 
```
TODO
"""

@document set_tabs_reorderable! """
```
set_tabs_reorderable!(::Notebook, b::Bool) 
```
TODO
"""

@document set_tabs_visible! """
```
set_tabs_visible!(::Notebook, b::Bool) 
```
TODO
"""

@document set_text! """
```
set_text!(::Entry, text::String) 
set_text!(::Label, text::String) 
set_text!(::TextView, text::String) 
set_text!(::ProgressBar, text::String) 
```
TODO
"""

@document set_text_to_value_function! """
```
set_text_to_value_function!(f, spin_button::SpinButton) 
set_text_to_value_function!(f, spin_button::SpinButton, data::Data_t) where Data_t 
```
TODO
"""

@document set_text_visible! """
```
set_text_visible!(::Entry, b::Bool) 
```
TODO
"""

@document set_texture! """
```
set_texture!(::Shape, texture::mousetrap.TextureObject) 
```
TODO
"""

@document set_tick_callback! """
```
set_tick_callback!(f, ::Widget) 
set_tick_callback!(f, ::Widget, data::Data_t) where Data_t 
```
TODO
"""

@document set_title """
```
set_title(::ColumnViewColumn, title::String) 
```
TODO
"""

@document set_title! """
```
set_title!(::Window, title::String) 
```
TODO
"""

@document set_title_widget! """
```
set_title_widget!(header_bar::HeaderBar, ::Widget) 
```
TODO
"""

@document set_titlebar_widget! """
```
set_titlebar_widget!(window::Window, titlebar::Widget) 
```
TODO
"""

@document set_tooltip_text! """
```
set_tooltip_text!(::Widget, text::String) 
```
TODO
"""

@document set_tooltip_widget! """
```
set_tooltip_widget!(::Widget, tooltip::Widget) 
```
TODO
"""

@document set_top_left! """
```
set_top_left!(::Shape, top_left::Vector2f) 
```
TODO
"""

@document set_top_margin! """
```
set_top_margin!(::TextView, margin::AbstractFloat) 
```
TODO
"""

@document set_touch_only! """
```
set_touch_only!(gesture::SingleClickGesture) 
```
TODO
"""

@document set_transient_for! """
```
set_transient_for!(self::Window, other::Window) 
```
TODO
"""

@document set_transition_duration! """
```
set_transition_duration!(stack::Stack, duration::Time) 
set_transition_duration!(revealer::Revealer, duration::Time) 
```
TODO
"""

@document set_transition_type """
```
set_transition_type(::Stack, transition::mousetrap.detail._StackTransitionType) 
```
TODO
"""

@document set_transition_type! """
```
set_transition_type!(::Revealer, type::mousetrap.detail._RevealerTransitionType) 
```
TODO
"""

@document set_uniform_float! """
```
set_uniform_float!(::Shader, name::String, float::Float32) 
set_uniform_float!(::RenderTask, name::String, v::Float32) 
```
TODO
"""

@document set_uniform_hsva! """
```
set_uniform_hsva!(task::RenderTask, name::String, hsva::RGBA) 
```
TODO
"""

@document set_uniform_int! """
```
set_uniform_int!(::Shader, name::String, float::Int32) 
set_uniform_int!(::RenderTask, name::String, v::Int32) 
```
TODO
"""

@document set_uniform_rgba! """
```
set_uniform_rgba!(task::RenderTask, name::String, rgba::RGBA) 
```
TODO
"""

@document set_uniform_transform! """
```
set_uniform_transform!(shader::Shader, name::String, transform::GLTransform) 
set_uniform_transform!(task::RenderTask, name::String, transform::GLTransform) 
```
TODO
"""

@document set_uniform_uint! """
```
set_uniform_uint!(::Shader, name::String, float::UInt32) 
set_uniform_uint!(::RenderTask, name::String, v::UInt32) 
```
TODO
"""

@document set_uniform_vec2! """
```
set_uniform_vec2!(shader::Shader, name::String, vec2::Vector2f) 
set_uniform_vec2!(task::RenderTask, name::String, v::Vector2f) 
```
TODO
"""

@document set_uniform_vec3! """
```
set_uniform_vec3!(shader::Shader, name::String, vec2::Vector2f) 
set_uniform_vec3!(task::RenderTask, name::String, v::StaticArraysCore.SVector{3, Float32}) 
```
TODO
"""

@document set_uniform_vec4! """
```
set_uniform_vec4!(shader::Shader, name::String, vec2::Vector2f) 
set_uniform_vec4!(task::RenderTask, name::String, v::StaticArraysCore.SVector{4, Float32}) 
```
TODO
"""

@document set_upper! """
```
set_upper!(adjustment::Adjustment, ::Number) 
set_upper!(::Scale, value::AbstractFloat) 
set_upper!(::SpinButton, value::AbstractFloat) 
```
TODO
"""

@document set_use_markup! """
```
set_use_markup!(::Label, b::Bool) 
```
TODO
"""

@document set_value! """
```
set_value!(::SpinButton, value::AbstractFloat) 
set_value!(::Scale, value::AbstractFloat) 
set_value!(::LevelBar, value::AbstractFloat) 
set_value!(file::KeyFile, group::String, key::String, value::AbstractFloat) 
set_value!(file::KeyFile, group::String, key::String, value::Signed) 
set_value!(file::KeyFile, group::String, key::String, value::Unsigned) 
set_value!(file::KeyFile, group::String, key::String, value::Vector{<:AbstractFloat}) 
set_value!(file::KeyFile, group::String, key::String, value::Vector{<:Signed}) 
set_value!(file::KeyFile, group::String, key::String, value::Vector{<:Unsigned}) 
set_value!(file::KeyFile, group::String, key::String, value::Bool) 
set_value!(file::KeyFile, group::String, key::String, value::String) 
set_value!(file::KeyFile, group::String, key::String, value::RGBA) 
set_value!(file::KeyFile, group::String, key::String, value::Image) 
set_value!(file::KeyFile, group::String, key::String, value::Vector{Bool}) 
set_value!(file::KeyFile, group::String, key::String, value::Vector{String}) 
set_value!(adjustment::Adjustment, ::Number) 
```
TODO
"""

@document set_value_to_text_function! """
```
set_value_to_text_function!(f, spin_button::SpinButton) 
set_value_to_text_function!(f, spin_button::SpinButton, data::Data_t) where Data_t 
```
TODO
"""

@document set_vertex_color! """
```
set_vertex_color!(::Shape, inde::Integer, color::RGBA) 
```
TODO
"""

@document set_vertex_position! """
```
set_vertex_position!(::Shape, inde::Integer, position::StaticArraysCore.SVector{3, Float32}) 
```
TODO
"""

@document set_vertex_texture_coordinate """
```
set_vertex_texture_coordinate(::Shape, inde::Integer, coordinate::Vector2f) 
```
TODO
"""

@document set_vertical_alignment! """
```
set_vertical_alignment!(::Widget, alignment::mousetrap.detail._Alignment) 
```
TODO
"""

@document set_vertical_scrollbar_policy! """
```
set_vertical_scrollbar_policy!(::Viewport, policy::mousetrap.detail._ScrollbarVisibilityPolicy) 
```
TODO
"""

@document set_visible_child! """
```
set_visible_child!(stack::Stack, id::String) 
```
TODO
"""

@document set_was_modified! """
```
set_was_modified!(::TextView, b::Bool) 
```
TODO
"""

@document set_widget! """
```
set_widget!(column_view::ColumnView, column::ColumnViewColumn, row_i::Integer, ::Widget) 
```
TODO
"""

@document set_widget_at! """
```
set_widget_at!(list_view::ListView, inde::Integer, ::Widget) 
set_widget_at!(list_view::ListView, inde::Integer, ::Widget, iterator::ListViewIterator) 
```
TODO
"""

@document set_wrap_mode! """
```
set_wrap_mode!(texture::mousetrap.TextureObject, mode::mousetrap.detail._TextureWrapMode) 
set_wrap_mode!(::Label, mode::mousetrap.detail._LabelWrapMode) 
```
TODO
"""

@document set_x_alignment! """
```
set_x_alignment!(::Label, ::AbstractFloat) 
```
TODO
"""

@document set_y_alignment! """
```
set_y_alignment!(::Label, ::AbstractFloat) 
```
TODO
"""

@document shift_pressed """
```
shift_pressed(modifier_state::mousetrap.detail._ModifierState) 
```
TODO
"""

@document should_shortcut_trigger_trigger """
```
should_shortcut_trigger_trigger(::KeyEventController, trigger::String) 
```
TODO
"""

@document show! """
```
show!(::Widget) 
```
TODO
"""

@document start! """
```
start!(::Spinner) 
```
TODO
"""

@document stop! """
```
stop!(::Spinner) 
```
TODO
"""

@document to_gl_coordinates """
```
to_gl_coordinates(area::RenderArea, absolute_widget_space_coordinates::Vector2f) 
```
TODO
"""

@document translate! """
```
translate!(transform::GLTransform, offset::Vector2f) 
```
TODO
"""

@document unbind """
```
unbind(texture::mousetrap.TextureObject) 
```
TODO
"""

@document unbind_as_render_target """
```
unbind_as_render_target(render_texture::RenderTexture) 
```
TODO
"""

@document undo! """
```
undo!(::TextView) 
```
TODO
"""

@document unmark_as_busy! """
```
unmark_as_busy!(::Application) 
```
TODO
"""

@document unparent! """
```
unparent!(::Widget) 
```
TODO
"""

@document unselect! """
```
unselect!(model::SelectionModel, i::Integer) 
```
TODO
"""

@document unselect_all! """
```
unselect_all!(::SelectionModel) 
```
TODO
"""
