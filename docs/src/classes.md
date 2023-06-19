## Action
```@docs
Action
activate
add_action!
add_icon!
add_shortcut!
clear_shortcuts!
get_enabled
get_id
get_is_stateful
get_shortcuts
get_state
set_action!
set_enabled!
set_function!
set_state!
set_stateful_function!
```
---

## Adjustment
```@docs
Adjustment
get_lower
get_step_increment
get_upper
get_value
set_lower!
set_step_increment!
set_upper!
set_value!
```
---

## Alignment
```@docs
Alignment
set_alignment!
set_horizontal_alignment!
set_vertical_alignment!
```
---

## Angle
```@docs
Angle
as_degrees
as_radians
rotate!
```
---

## Application
```@docs
Application
add_action!
get_action
get_id
has_action
hold!
mark_as_busy!
quit!
release!
remove_action!
run!
set_application!
unmark_as_busy!
```
---

## ApplicationID
```@docs
ApplicationID
```
---

## AspectFrame
```@docs
AspectFrame
get_child_x_alignment
get_child_y_alignment
get_ratio
remove_child!
set_child!
set_child_x_alignment!
set_child_y_alignment!
set_ratio!
```
---

## AxisAlignedRectangle
```@docs
AxisAlignedRectangle
```
---

## BlendMode
```@docs
BlendMode
set_current_blend_mode
```
---

## Box
```@docs
Box
clear!
get_homogeneous
get_n_items
get_orientation
get_spacing
insert_after!
push_back!
push_front!
remove!
set_homogeneous!
set_orientation!
set_spacing!
```
---

## Button
```@docs
Button
get_has_frame
get_is_circular
remove_child!
set_action!
set_child!
set_has_frame!
set_icon!
set_is_circular!
```
---

## ButtonID
```@docs
ButtonID
set_only_listens_to_button!
```
---

## CenterBox
```@docs
CenterBox
get_orientation
remove_center_child!
remove_end_child!
remove_start_child!
set_center_child!
set_end_child!
set_orientation!
set_start_child!
```
---

## CheckButton
```@docs
CheckButton
get_is_active
get_state
remove_child!
set_active!
set_child!
set_state!
```
---

## CheckButtonState
```@docs
CheckButtonState
set_state!
```
---

## ClickEventController
```@docs
ClickEventController
```
---

## Clipboard
```@docs
Clipboard
contains_file
contains_image
contains_string
get_image
get_string
is_local
set_file!
set_image!
set_string!
```
---

## Clock
```@docs
Clock
elapsed
restart!
```
---

## ColumnView
```@docs
ColumnView
get_column_at
get_column_with_title
get_enabled_rubberband_selection
get_n_columns
get_n_rows
get_selection_model
get_show_column_separators
get_show_row_separators
get_single_click_activate
has_column_with_title
insert_column!
push_back_column!
push_back_row!
push_front_column!
push_front_row!
remove_column!
set_enable_rubberband_selection
set_show_column_separators
set_show_row_separators
set_single_click_activate!
set_widget!
```
---

## ColumnViewColumn
```@docs
ColumnViewColumn
get_fixed_width
get_is_resizable
get_is_visible
get_title
remove_column!
set_fixed_width
set_header_menu!
set_is_resizable!
set_is_visible!
set_title!
set_widget!
```
---

## CornerPlacement
```@docs
CornerPlacement
set_scrollbar_placement!
```
---

## CursorType
```@docs
CursorType
set_cursor!
```
---

## DeviceAxis
```@docs
DeviceAxis
device_axis_to_string
has_axis
```
---

## DragEventController
```@docs
DragEventController
get_current_offset
get_start_position
```
---

## DropDown
```@docs
DropDown
get_always_show_arrow
get_item_at
get_selected
push_back!
push_front!
remove!
set_always_show_arrow!
set_selected
```
---

## DropDownItemID
```@docs
DropDownItemID
```
---

## EllipsizeMode
```@docs
EllipsizeMode
set_ellipsize_mode!
```
---

## Entry
```@docs
Entry
get_has_frame
get_max_width_chars
get_text
get_text_visible
remove_primary_icon!
remove_secondary_icon!
set_has_frame!
set_max_width_chars!
set_primary_icon!
set_secondary_icon!
set_text!
set_text_visible!
```
---

## EventController
```@docs
EventController
add_controller!
get_propagation_phase
remove_controller!
set_propagation_phase!
```
---

## Expander
```@docs
Expander
remove_child!
remove_label_widget!
set_child!
set_label_widget!
```
---

## FileChooser
```@docs
FileChooser
cancel!
get_accept_label
get_is_modal
on_accept!
on_cancel!
present!
set_accept_label!
set_is_modal!
```
---

## FileChooserAction
```@docs
FileChooserAction
```
---

## FileDescriptor
```@docs
FileDescriptor
create_as_file_preview!
create_directory_at!
create_file_at!
create_from_path!
create_from_uri!
create_monitor
delete_at!
exists
get_children
get_content_type
get_file_extension
get_name
get_parent
get_path
get_path_relative_to
get_uri
is_file
is_folder
is_symlink
move!
query_info
read_symlink
set_file!
```
---

## FileFilter
```@docs
FileFilter
add_allow_all_supported_image_formats!
add_allowed_mime_type!
add_allowed_pattern!
add_allowed_suffix!
get_name
```
---

## FileMonitor
```@docs
FileMonitor
cancel!
is_cancelled
on_file_changed!
```
---

## FileMonitorEvent
```@docs
FileMonitorEvent
```
---

## Fixed
```@docs
Fixed
add_child!
get_child_position
remove_child!
set_child_position!
```
---

## FocusEventController
```@docs
FocusEventController
self_is_focused
self_or_child_is_focused
```
---

## Frame
```@docs
Frame
get_label_x_alignment!
remove_child!
remove_label_widget!
set_child!
set_label_widget!
set_label_x_alignment!
```
---

## FrameClock
```@docs
FrameClock
get_target_frame_duration
get_time_since_last_frame
```
---

## GLTransform
```@docs
GLTransform
apply_to
combine_with
render
reset!
rotate!
scale!
set_uniform_transform!
translate!
```
---

## Grid
```@docs
Grid
get_column_spacing
get_columns_homogeneous
get_orientation
get_position
get_row_spacing
get_rows_homogeneous
get_size
insert_column_at!
insert_row_at!
remove!
remove_row_at!
set_column_spacing!
set_columns_homogeneous!
set_orientation!
set_row_spacing!
set_rows_homogeneous!
```
---

## GridView
```@docs
GridView
clear!
get_enabled_rubberband_selection
get_max_n_columns
get_min_n_columns
get_n_items
get_orientation
get_selection_model
get_single_click_activate
push_back!
push_front!
remove!
set_enable_rubberband_selection
set_max_n_columns!
set_min_n_columns!
set_orientation!
set_single_click_activate!
```
---

## GroupID
```@docs
GroupID
```
---

## HSVA
```@docs
HSVA
hsva_to_rgba
set_pixel!
```
---

## HeaderBar
```@docs
HeaderBar
get_layout
get_show_title_buttons
push_back!
push_front!
remove!
set_layout!
set_show_title_buttons!
set_title_widget!
```
---

## Icon
```@docs
Icon
add_icon!
create_from_file!
create_from_icon!
create_from_theme!
get_name
get_size
has_icon
set_icon!
set_primary_icon!
set_secondary_icon!
```
---

## IconID
```@docs
IconID
```
---

## IconTheme
```@docs
IconTheme
add_resource_path!
create_from_theme!
get_icon_names
has_icon
set_resource_path!
```
---

## Image
```@docs
Image
as_cropped
as_scaled
create!
create_from_file!
create_from_image!
get_n_pixels
get_pixel
get_size
save_to_file
set_cursor_from_image!
set_image!
set_pixel!
set_value!
```
---

## ImageDisplay
```@docs
ImageDisplay
clear!
create_as_file_preview!
create_from_file!
create_from_icon!
create_from_image!
set_scale!
```
---

## InterpolationType
```@docs
InterpolationType
as_scaled
```
---

## JustifyMode
```@docs
JustifyMode
set_justify_mode!
```
---

## KeyCode
```@docs
KeyCode
set_uniform_int!
```
---

## KeyEventController
```@docs
KeyEventController
should_shortcut_trigger_trigger
```
---

## KeyFile
```@docs
KeyFile
as_string
create_from_file!
create_from_string!
get_comment_above!
get_comment_above_group
get_comment_above_key
get_groups
get_keys
get_value
has_group
has_key
save_to_file
set_comment_above!
set_value!
```
---

## KeyID
```@docs
KeyID
```
---

## Label
```@docs
Label
get_ellipsize_mode
get_justify_mode
get_max_width_chars
get_selectable
get_text
get_use_markup
get_wrap_mode
get_x_alignment
get_y_alignment
set_ellipsize_mode!
set_justify_mode!
set_max_width_chars!
set_selectable!
set_text!
set_use_markup!
set_wrap_mode!
set_x_alignment!
set_y_alignment!
```
---

## LabelWrapMode
```@docs
LabelWrapMode
set_wrap_mode!
```
---

## LevelBar
```@docs
LevelBar
add_marker!
get_inverted
get_min_value
get_mode
get_orientation
get_value
remove_marker!
set_inverted!
set_max_value!
set_min_value!
set_mode!
set_orientation!
set_value!
```
---

## LevelBarMode
```@docs
LevelBarMode
set_mode!
```
---

## ListView
```@docs
ListView
clear!
get_enabled_rubberband_selection
get_n_items
get_orientation
get_selection_model
get_show_separators
get_single_click_activate
push_back!
push_front!
remove!
set_enable_rubberband_selection
set_orientation!
set_show_separators
set_single_click_activate!
set_widget_at!
```
---

## ListViewIterator
```@docs
ListViewIterator
clear!
push_back!
push_front!
remove!
set_widget_at!
```
---

## LogDomain
```@docs
LogDomain
```
---

## LongPressEventController
```@docs
LongPressEventController
get_delay_factor
set_delay_factor
```
---

## MenuBar
```@docs
MenuBar
```
---

## MenuModel
```@docs
MenuModel
add_action!
add_icon!
add_section!
add_submenu!
add_widget!
set_header_menu!
```
---

## ModifierState
```@docs
ModifierState
alt_pressed
control_pressed
mouse_button_01_pressed
mouse_button_02_pressed
shift_pressed
```
---

## MotionEventController
```@docs
MotionEventController
```
---

## Notebook
```@docs
Notebook
get_current_page
get_has_border
get_is_scrollable
get_n_pages
get_quick_change_menu_enabled
get_tab_position
get_tabs_reorderable
get_tabs_visible
goto_page!
next_page!
previous_page!
push_back!
push_front!
remove!
set_has_border!
set_is_scrollable!
set_quick_change_menu_enabled!
set_tab_position!
set_tabs_reorderable!
set_tabs_visible!
```
---

## Orientation
```@docs
Orientation
set_orientation!
```
---

## Overlay
```@docs
Overlay
add_overlay!
remove_child!
remove_overlay!
set_child!
```
---

## PanDirection
```@docs
PanDirection
```
---

## PanEventController
```@docs
PanEventController
get_orientation
set_orientation!
```
---

## Paned
```@docs
Paned
get_end_child_resizable
get_end_child_shrinkable
get_has_wide_handle
get_orientation
get_position
get_start_child_resizable
get_start_child_shrinkable
remove_end_child!
remove_start_child!
set_end_child!
set_end_child_resizable!
set_end_child_shrinkable
set_has_wide_handle!
set_orientation!
set_position!
set_start_child!
set_start_child_resizable!
set_start_child_shrinkable
```
---

## PinchZoomEventController
```@docs
PinchZoomEventController
get_scale_delta
```
---

## Popover
```@docs
Popover
attach_to!
get_autohide
get_has_base_arrow
get_relative_position
popdown!
popup!
present!
remove_child!
set_autohide!
set_child!
set_has_base_arrow!
set_popover!
set_relative_position!
```
---

## PopoverButton
```@docs
PopoverButton
get_always_show_arrow
get_has_frame
get_is_circular
get_relative_position
popdown!
popup!
remove_child!
remove_popover!
set_always_show_arrow!
set_child!
set_has_frame!
set_is_circular!
set_popover!
set_popover_menu!
set_popover_position!
```
---

## PopoverMenu
```@docs
PopoverMenu
set_popover_menu!
```
---

## ProgressBar
```@docs
ProgressBar
get_display_mode
get_fraction
get_is_inverted
get_orientation
get_text
pulse
set_display_mode!
set_fraction!
set_is_inverted!
set_orientation!
set_text!
```
---

## ProgressBarDisplayMode
```@docs
ProgressBarDisplayMode
set_display_mode!
```
---

## PropagationPhase
```@docs
PropagationPhase
```
---

## RGBA
```@docs
RGBA
create!
rgba_to_hsva
rgba_to_html_code
set_pixel!
set_uniform_hsva!
set_uniform_rgba!
set_value!
set_vertex_color!
```
---

## RelativePosition
```@docs
RelativePosition
set_popover_position!
set_relative_position!
set_tab_position!
```
---

## RenderArea
```@docs
RenderArea
add_render_task!
clear
clear_render_tasks!
from_gl_coordinates
make_current
queue_render
render_render_tasks
to_gl_coordinates
```
---

## RenderTask
```@docs
RenderTask
add_render_task!
get_uniform_float
get_uniform_int
get_uniform_rgba
get_uniform_transform
get_uniform_uint
get_uniform_vec2
get_uniform_vec3
get_uniform_vec4
render
set_uniform_float!
set_uniform_hsva!
set_uniform_int!
set_uniform_rgba!
set_uniform_transform!
set_uniform_uint!
set_uniform_vec2!
set_uniform_vec3!
set_uniform_vec4!
```
---

## RenderTexture
```@docs
RenderTexture
bind_as_render_target
unbind_as_render_target
```
---

## Revealer
```@docs
Revealer
get_revealed
get_transition_duration
get_transition_type
remove_child!
set_child!
set_revealed!
set_transition_duration!
set_transition_type!
```
---

## RevealerTransitionType
```@docs
RevealerTransitionType
set_transition_type!
```
---

## RotateEventController
```@docs
RotateEventController
```
---

## Scale
```@docs
Scale
get_adjustment
get_lower
get_step_increment
get_upper
get_value
set_lower!
set_step_increment!
set_upper!
set_value!
```
---

## ScrollEventController
```@docs
ScrollEventController
```
---

## ScrollType
```@docs
ScrollType
```
---

## Scrollbar
```@docs
Scrollbar
get_adjustment
get_orientation
set_orientation!
```
---

## ScrollbarVisibilityPolicy
```@docs
ScrollbarVisibilityPolicy
set_horizontal_scrollbar_policy!
set_vertical_scrollbar_policy!
```
---

## SectionFormat
```@docs
SectionFormat
add_section!
```
---

## SelectionMode
```@docs
SelectionMode
```
---

## SelectionModel
```@docs
SelectionModel
get_selection
select!
select_all!
unselect!
unselect_all!
```
---

## Separator
```@docs
Separator
get_orientation
set_orientation!
```
---

## Shader
```@docs
Shader
create_from_file!
create_from_string!
get_fragment_shader_id
get_program_id
get_uniform_location
get_vertex_shader_id
render
set_uniform_float!
set_uniform_int!
set_uniform_transform!
set_uniform_uint!
set_uniform_vec2!
set_uniform_vec3!
set_uniform_vec4!
```
---

## ShaderType
```@docs
ShaderType
create_from_file!
create_from_string!
```
---

## Shape
```@docs
Shape
Outline
as_circle!
as_circular_ring!
as_ellipse!
as_elliptical_ring!
as_line!
as_line_strip!
as_lines!
as_outline!
as_point!
as_points!
as_polygon!
as_rectangle!
as_rectangular_frame!
as_triangle!
as_wireframe!
get_bounding_box
get_centroid
get_is_visible
get_n_vertices
get_native_handle
get_size
get_top_left
get_vertex_color
get_vertex_position
get_vertex_texture_coordinate
render
rotate!
set_centroid!
set_is_visible!
set_texture!
set_top_left!
set_vertex_color!
set_vertex_position!
set_vertex_texture_coordinate
```
---

## ShortcutEventController
```@docs
ShortcutEventController
add_action!
get_scope
set_scope!
```
---

## ShortcutScope
```@docs
ShortcutScope
set_scope!
```
---

## ShortcutTrigger
```@docs
ShortcutTrigger
```
---

## SignalEmitter
```@docs
SignalEmitter
```
---

## SingleClickGesture
```@docs
SingleClickGesture
get_current_button
get_only_listens_to_button
get_touch_only
set_only_listens_to_button!
set_touch_only!
```
---

## SpinButton
```@docs
SpinButton
get_acceleration_rate
get_adjustment
get_allow_only_numeric
get_lower
get_n_digits
get_should_snap_to_ticks
get_should_wrap
get_step_increment
get_upper
get_value
reset_text_to_value_function!
reset_value_to_text_function!
set_acceleration_rate!
set_allow_only_numeric!
set_lower!
set_n_digits!
set_should_snap_to_ticks!
set_should_wrap!
set_step_increment!
set_text_to_value_function!
set_upper!
set_value!
set_value_to_text_function!
```
---

## Spinner
```@docs
Spinner
get_is_spinning
set_is_spinning!
start!
stop!
```
---

## Stack
```@docs
Stack
add_child!
get_is_horizontally_homogeneous
get_is_vertically_homogeneous
get_selection_model
get_should_interpolate_size
get_transition_duration
get_transition_type
get_visible_child
remove_child!
set_is_horizontally_homogeneous
set_is_vertically_homogeneous
set_should_interpolate_size
set_transition_duration!
set_transition_type!
set_visible_child!
```
---

## StackID
```@docs
StackID
```
---

## StackSidebar
```@docs
StackSidebar
```
---

## StackSwitcher
```@docs
StackSwitcher
```
---

## StackTransitionType
```@docs
StackTransitionType
set_transition_type!
```
---

## StylusEventController
```@docs
StylusEventController
get_hardware_id
get_tool_type
has_axis
```
---

## SwipeEventController
```@docs
SwipeEventController
get_velocity
```
---

## Switch
```@docs
Switch
get_is_active
set_is_active!
```
---

## TextView
```@docs
TextView
get_bottom_margin
get_cursor_visible
get_editable
get_justify_mode
get_left_margin
get_right_margin
get_text
get_top_margin
get_was_modified
redo!
set_bottom_margin!
set_cursor_visible!
set_editable!
set_justify_mode!
set_left_margin!
set_right_margin!
set_text!
set_top_margin!
set_was_modified!
undo!
```
---

## Texture
```@docs
Texture
```
---

## TextureObject
```@docs
TextureObject
create!
create_from_image!
get_native_handle
get_scale_mode
get_size
get_wrap_mode
set_scale_mode!
set_texture!
set_wrap_mode!
unbind
```
---

## TextureScaleMode
```@docs
TextureScaleMode
```
---

## TextureWrapMode
```@docs
TextureWrapMode
set_scale_mode!
set_wrap_mode!
```
---

## TickCallbackResult
```@docs
TickCallbackResult
```
---

## Time
```@docs
Time
as_microseconds
as_milliseconds
as_minutes
as_nanoseconds
as_seconds
set_transition_duration!
```
---

## ToggleButton
```@docs
ToggleButton
get_is_active
get_is_circular
remove_child!
set_child!
set_is_active!
set_is_circular!
```
---

## ToolType
```@docs
ToolType
```
---

## TypedFunction
```@docs
TypedFunction
```
---

## Vector2
```@docs
Vector2
```
---

## Vector3
```@docs
Vector3
```
---

## Vector4
```@docs
Vector4
```
---

## Viewport
```@docs
Viewport
get_has_frame
get_horizontal_adjustment
get_horizontal_scrollbar_policy
get_kinetic_scrolling_enabled
get_propagate_natural_height
get_propagate_natural_width
get_scrollbar_placement
get_vertical_adjustment
get_vertical_scrollbar_policy
remove_child!
set_child!
set_has_frame!
set_horizontal_scrollbar_policy!
set_kinetic_scrolling_enabled!
set_propagate_natural_height!
set_propagate_natural_width!
set_scrollbar_placement!
set_vertical_scrollbar_policy!
```
---

## Widget
```@docs
Widget
activate!
add_child!
add_controller!
add_overlay!
add_widget!
attach_to!
get_allocated_size
get_can_respond_to_input
get_child_position
get_clipboard
get_expand_horizontally
get_expand_vertically
get_focus_on_click
get_frame_clock
get_has_focus
get_hide_on_overflow
get_horizontal_alignemtn
get_is_focusable
get_is_realized
get_is_visible
get_margin_bottom
get_margin_end
get_margin_start
get_margin_top
get_minimum_size
get_natural_size
get_opacity
get_position
get_size
get_size_request
get_vertical_alignment
grab_focus!
hide!
insert_after!
push_back!
push_front!
remove!
remove_child!
remove_controller!
remove_overlay!
remove_tick_callback!
remove_tooltip_widget!
set_alignment!
set_can_respond_to_input!
set_center_child!
set_child!
set_child_position!
set_cursor!
set_cursor_from_image!
set_default_widget!
set_end_child!
set_expand!
set_expand_horizontally!
set_expand_vertically!
set_focus_on_click!
set_hide_on_overflow!
set_horizontal_alignment!
set_is_focusable!
set_is_visible!
set_label_widget!
set_margin!
set_margin_bottom!
set_margin_end!
set_margin_horizontal!
set_margin_start!
set_margin_top!
set_margin_vertical!
set_opacity!
set_size_request!
set_start_child!
set_tick_callback!
set_title_widget!
set_titlebar_widget!
set_tooltip_text!
set_tooltip_widget!
set_vertical_alignment!
set_widget!
set_widget_at!
show!
unparent!
```
---

## Window
```@docs
Window
close!
get_destroy_with_parent
get_focus_visible
get_has_close_button
get_is_decorated
get_is_modal
get_title
present!
remove_child!
remove_titlebar_widget!
set_application!
set_child!
set_default_widget!
set_destroy_with_parent!
set_focus_visible!
set_fullscreen!
set_has_close_button!
set_hide_on_close!
set_is_decorated!
set_is_modal!
set_maximized!
set_startup_notification_identifier!
set_title!
set_titlebar_widget!
set_transient_for!
```
---

## WindowCloseRequestResult
```@docs
WindowCloseRequestResult
```
---
