# Index: Classes
## Action
```@docs
Action
```
#### Functions that operate on this type:
+ [`activate!`](@ref)
+ [`add_action!`](@ref)
+ [`add_shortcut!`](@ref)
+ [`clear_shortcuts!`](@ref)
+ [`get_enabled`](@ref)
+ [`get_id`](@ref)
+ [`get_shortcuts`](@ref)
+ [`remove_action!`](@ref)
+ [`set_action!`](@ref)
+ [`set_button_action!`](@ref)
+ [`set_enabled!`](@ref)
+ [`set_function!`](@ref)
+ [`set_listens_for_shortcut_action!`](@ref)


+ [`connect_signal_activated!`](@ref)
+ [`disconnect_signal_activated!`](@ref)
+ [`emit_signal_activated`](@ref)
+ [`get_signal_activated_blocked`](@ref)
+ [`set_signal_activated_blocked!`](@ref)


---
## ActionBar
```@docs
ActionBar
```
#### Functions that operate on this type:
+ [`get_is_revealed`](@ref)
+ [`push_back!`](@ref)
+ [`push_front!`](@ref)
+ [`remove!`](@ref)
+ [`remove_center_child!`](@ref)
+ [`set_is_revealed!`](@ref)


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## Adjustment
```@docs
Adjustment
```
#### Functions that operate on this type:
+ [`get_lower`](@ref)
+ [`get_step_increment`](@ref)
+ [`get_upper`](@ref)
+ [`get_value`](@ref)
+ [`set_lower!`](@ref)
+ [`set_step_increment!`](@ref)
+ [`set_upper!`](@ref)
+ [`set_value!`](@ref)


+ [`connect_signal_properties_changed!`](@ref)
+ [`disconnect_signal_properties_changed!`](@ref)
+ [`emit_signal_properties_changed`](@ref)
+ [`get_signal_properties_changed_blocked`](@ref)
+ [`set_signal_properties_changed_blocked!`](@ref)




+ [`connect_signal_value_changed!`](@ref)
+ [`disconnect_signal_value_changed!`](@ref)
+ [`emit_signal_value_changed`](@ref)
+ [`get_signal_value_changed_blocked`](@ref)
+ [`set_signal_value_changed_blocked!`](@ref)




---
## AlertDialog
```@docs
AlertDialog
```
#### Functions that operate on this type:
+ [`add_button!`](@ref)
+ [`close!`](@ref)
+ [`get_button_label`](@ref)
+ [`get_detailed_description`](@ref)
+ [`get_is_modal`](@ref)
+ [`get_message`](@ref)
+ [`get_n_buttons`](@ref)
+ [`on_selection!`](@ref)
+ [`present!`](@ref)
+ [`remove_extra_widget!`](@ref)
+ [`set_button_label!`](@ref)
+ [`set_default_button!`](@ref)
+ [`set_detailed_description!`](@ref)
+ [`set_extra_widget!`](@ref)
+ [`set_is_modal!`](@ref)
+ [`set_message!`](@ref)


---
## Angle
```@docs
Angle
```
#### Functions that operate on this type:
+ [`as_degrees`](@ref)
+ [`as_radians`](@ref)
+ [`rotate!`](@ref)


---
## Animation
```@docs
Animation
```
#### Functions that operate on this type:
+ [`get_duration`](@ref)
+ [`get_is_reversed`](@ref)
+ [`get_lower`](@ref)
+ [`get_repeat_count`](@ref)
+ [`get_state`](@ref)
+ [`get_timing_function`](@ref)
+ [`get_upper`](@ref)
+ [`get_value`](@ref)
+ [`on_done!`](@ref)
+ [`on_tick!`](@ref)
+ [`pause!`](@ref)
+ [`play!`](@ref)
+ [`reset!`](@ref)
+ [`set_duration!`](@ref)
+ [`set_is_reversed!`](@ref)
+ [`set_lower!`](@ref)
+ [`set_repeat_count!`](@ref)
+ [`set_timing_function!`](@ref)
+ [`set_upper!`](@ref)


---
## Application
```@docs
Application
```
#### Functions that operate on this type:
+ [`add_action!`](@ref)
+ [`get_action`](@ref)
+ [`get_current_theme`](@ref)
+ [`get_id`](@ref)
+ [`get_is_holding`](@ref)
+ [`get_is_marked_as_busy`](@ref)
+ [`has_action`](@ref)
+ [`hold!`](@ref)
+ [`mark_as_busy!`](@ref)
+ [`quit!`](@ref)
+ [`release!`](@ref)
+ [`remove_action!`](@ref)
+ [`run!`](@ref)
+ [`set_application!`](@ref)
+ [`set_current_theme!`](@ref)
+ [`unmark_as_busy!`](@ref)


+ [`connect_signal_activate!`](@ref)
+ [`disconnect_signal_activate!`](@ref)
+ [`emit_signal_activate`](@ref)
+ [`get_signal_activate_blocked`](@ref)
+ [`set_signal_activate_blocked!`](@ref)


+ [`connect_signal_shutdown!`](@ref)
+ [`disconnect_signal_shutdown!`](@ref)
+ [`emit_signal_shutdown`](@ref)
+ [`get_signal_shutdown_blocked`](@ref)
+ [`set_signal_shutdown_blocked!`](@ref)


---
## ApplicationID
```@docs
ApplicationID
```
#### Functions that operate on this type:


---
## AspectFrame
```@docs
AspectFrame
```
#### Functions that operate on this type:
+ [`get_child_x_alignment`](@ref)
+ [`get_child_y_alignment`](@ref)
+ [`get_ratio`](@ref)
+ [`remove_child!`](@ref)
+ [`set_child!`](@ref)
+ [`set_child_x_alignment!`](@ref)
+ [`set_child_y_alignment!`](@ref)
+ [`set_ratio!`](@ref)


---
## AxisAlignedRectangle
```@docs
AxisAlignedRectangle
```
---
## Box
```@docs
Box
```
#### Functions that operate on this type:
+ [`clear!`](@ref)
+ [`get_homogeneous`](@ref)
+ [`get_n_items`](@ref)
+ [`get_orientation`](@ref)
+ [`get_spacing`](@ref)
+ [`insert_after!`](@ref)
+ [`push_back!`](@ref)
+ [`push_front!`](@ref)
+ [`remove!`](@ref)
+ [`set_homogeneous!`](@ref)
+ [`set_orientation!`](@ref)
+ [`set_spacing!`](@ref)


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## Button
```@docs
Button
```
#### Functions that operate on this type:
+ [`get_has_frame`](@ref)
+ [`get_is_circular`](@ref)
+ [`remove_child!`](@ref)
+ [`set_action!`](@ref)
+ [`set_child!`](@ref)
+ [`set_has_frame!`](@ref)
+ [`set_icon!`](@ref)
+ [`set_is_circular!`](@ref)


+ [`connect_signal_clicked!`](@ref)
+ [`disconnect_signal_clicked!`](@ref)
+ [`emit_signal_clicked`](@ref)
+ [`get_signal_clicked_blocked`](@ref)
+ [`set_signal_clicked_blocked!`](@ref)


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## CenterBox
```@docs
CenterBox
```
#### Functions that operate on this type:
+ [`get_orientation`](@ref)
+ [`remove_center_child!`](@ref)
+ [`remove_end_child!`](@ref)
+ [`remove_start_child!`](@ref)
+ [`set_center_child!`](@ref)
+ [`set_end_child!`](@ref)
+ [`set_orientation!`](@ref)
+ [`set_start_child!`](@ref)


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## CheckButton
```@docs
CheckButton
```
#### Functions that operate on this type:
+ [`get_is_active`](@ref)
+ [`get_state`](@ref)
+ [`remove_child!`](@ref)
+ [`set_child!`](@ref)
+ [`set_is_active!`](@ref)
+ [`set_state!`](@ref)


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_toggled!`](@ref)
+ [`disconnect_signal_toggled!`](@ref)
+ [`emit_signal_toggled`](@ref)
+ [`get_signal_toggled_blocked`](@ref)
+ [`set_signal_toggled_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## ClampFrame
```@docs
ClampFrame
```
#### Functions that operate on this type:
+ [`get_maximum_size`](@ref)
+ [`get_orientation`](@ref)
+ [`remove_child!`](@ref)
+ [`set_child!`](@ref)
+ [`set_maximum_size!`](@ref)
+ [`set_orientation!`](@ref)


---
## ClickEventController
```@docs
ClickEventController
```
#### Functions that operate on this type:


+ [`connect_signal_click_pressed!`](@ref)
+ [`connect_signal_click_released!`](@ref)
+ [`connect_signal_click_stopped!`](@ref)
+ [`disconnect_signal_click_pressed!`](@ref)
+ [`disconnect_signal_click_released!`](@ref)
+ [`disconnect_signal_click_stopped!`](@ref)
+ [`emit_signal_click_pressed`](@ref)
+ [`emit_signal_click_released`](@ref)
+ [`emit_signal_click_stopped`](@ref)
+ [`get_signal_click_pressed_blocked`](@ref)
+ [`get_signal_click_released_blocked`](@ref)
+ [`get_signal_click_stopped_blocked`](@ref)
+ [`set_signal_click_pressed_blocked!`](@ref)
+ [`set_signal_click_released_blocked!`](@ref)
+ [`set_signal_click_stopped_blocked!`](@ref)








---
## Clipboard
```@docs
Clipboard
```
#### Functions that operate on this type:
+ [`contains_file`](@ref)
+ [`contains_image`](@ref)
+ [`contains_string`](@ref)
+ [`get_image`](@ref)
+ [`get_is_local`](@ref)
+ [`get_string`](@ref)
+ [`set_file!`](@ref)
+ [`set_image!`](@ref)
+ [`set_string!`](@ref)


---
## Clock
```@docs
Clock
```
#### Functions that operate on this type:
+ [`elapsed`](@ref)
+ [`restart!`](@ref)


---
## ColorChooser
```@docs
ColorChooser
```
#### Functions that operate on this type:
+ [`get_color`](@ref)
+ [`get_is_modal`](@ref)
+ [`get_title`](@ref)
+ [`on_accept!`](@ref)
+ [`on_cancel!`](@ref)
+ [`present!`](@ref)
+ [`set_is_modal!`](@ref)
+ [`set_title!`](@ref)


---
## ColumnView
```@docs
ColumnView
```
#### Functions that operate on this type:
+ [`get_column_at`](@ref)
+ [`get_column_with_title`](@ref)
+ [`get_enable_rubberband_selection`](@ref)
+ [`get_n_columns`](@ref)
+ [`get_n_rows`](@ref)
+ [`get_selection_model`](@ref)
+ [`get_show_column_separators`](@ref)
+ [`get_show_row_separators`](@ref)
+ [`get_single_click_activate`](@ref)
+ [`has_column_with_title`](@ref)
+ [`insert_column_at!`](@ref)
+ [`insert_row_at!`](@ref)
+ [`push_back_column!`](@ref)
+ [`push_back_row!`](@ref)
+ [`push_front_column!`](@ref)
+ [`push_front_row!`](@ref)
+ [`remove_column!`](@ref)
+ [`set_enable_rubberband_selection!`](@ref)
+ [`set_show_column_separators`](@ref)
+ [`set_show_row_separators`](@ref)
+ [`set_single_click_activate!`](@ref)
+ [`set_widget_at!`](@ref)


+ [`connect_signal_activate!`](@ref)
+ [`disconnect_signal_activate!`](@ref)
+ [`emit_signal_activate`](@ref)
+ [`get_signal_activate_blocked`](@ref)
+ [`set_signal_activate_blocked!`](@ref)


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## ColumnViewColumn
```@docs
ColumnViewColumn
```
#### Functions that operate on this type:
+ [`get_fixed_width`](@ref)
+ [`get_is_resizable`](@ref)
+ [`get_is_visible`](@ref)
+ [`get_title`](@ref)
+ [`remove_column!`](@ref)
+ [`set_fixed_width!`](@ref)
+ [`set_header_menu!`](@ref)
+ [`set_is_resizable!`](@ref)
+ [`set_is_visible!`](@ref)
+ [`set_title!`](@ref)
+ [`set_widget_at!`](@ref)


---
## DragEventController
```@docs
DragEventController
```
#### Functions that operate on this type:
+ [`get_current_offset`](@ref)
+ [`get_start_position`](@ref)


+ [`connect_signal_drag!`](@ref)
+ [`connect_signal_drag_begin!`](@ref)
+ [`connect_signal_drag_end!`](@ref)
+ [`disconnect_signal_drag!`](@ref)
+ [`disconnect_signal_drag_begin!`](@ref)
+ [`disconnect_signal_drag_end!`](@ref)
+ [`emit_signal_drag`](@ref)
+ [`emit_signal_drag_begin`](@ref)
+ [`emit_signal_drag_end`](@ref)
+ [`get_signal_drag_begin_blocked`](@ref)
+ [`get_signal_drag_blocked`](@ref)
+ [`get_signal_drag_end_blocked`](@ref)
+ [`set_signal_drag_begin_blocked!`](@ref)
+ [`set_signal_drag_blocked!`](@ref)
+ [`set_signal_drag_end_blocked!`](@ref)






---
## DropDown
```@docs
DropDown
```
#### Functions that operate on this type:
+ [`get_always_show_arrow`](@ref)
+ [`get_item_at`](@ref)
+ [`get_selected`](@ref)
+ [`insert_at!`](@ref)
+ [`push_back!`](@ref)
+ [`push_front!`](@ref)
+ [`remove!`](@ref)
+ [`set_always_show_arrow!`](@ref)
+ [`set_selected!`](@ref)


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## DropDownItemID
```@docs
DropDownItemID
```
#### Functions that operate on this type:
+ [`remove!`](@ref)
+ [`set_selected!`](@ref)


---
## Entry
```@docs
Entry
```
#### Functions that operate on this type:
+ [`get_has_frame`](@ref)
+ [`get_max_width_chars`](@ref)
+ [`get_text`](@ref)
+ [`get_text_visible`](@ref)
+ [`remove_primary_icon!`](@ref)
+ [`remove_secondary_icon!`](@ref)
+ [`set_has_frame!`](@ref)
+ [`set_max_width_chars!`](@ref)
+ [`set_primary_icon!`](@ref)
+ [`set_secondary_icon!`](@ref)
+ [`set_text!`](@ref)
+ [`set_text_visible!`](@ref)


+ [`connect_signal_activate!`](@ref)
+ [`disconnect_signal_activate!`](@ref)
+ [`emit_signal_activate`](@ref)
+ [`get_signal_activate_blocked`](@ref)
+ [`set_signal_activate_blocked!`](@ref)


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_text_changed!`](@ref)
+ [`disconnect_signal_text_changed!`](@ref)
+ [`emit_signal_text_changed`](@ref)
+ [`get_signal_text_changed_blocked`](@ref)
+ [`set_signal_text_changed_blocked!`](@ref)




+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## EventController
```@docs
EventController
```
#### Functions that operate on this type:
+ [`add_controller!`](@ref)
+ [`get_propagation_phase`](@ref)
+ [`remove_controller!`](@ref)
+ [`set_propagation_phase!`](@ref)


---
## Expander
```@docs
Expander
```
#### Functions that operate on this type:
+ [`get_is_expanded`](@ref)
+ [`remove_child!`](@ref)
+ [`remove_label_widget!`](@ref)
+ [`set_child!`](@ref)
+ [`set_is_expanded!`](@ref)
+ [`set_label_widget!`](@ref)


+ [`connect_signal_activate!`](@ref)
+ [`disconnect_signal_activate!`](@ref)
+ [`emit_signal_activate`](@ref)
+ [`get_signal_activate_blocked`](@ref)
+ [`set_signal_activate_blocked!`](@ref)


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## FileChooser
```@docs
FileChooser
```
#### Functions that operate on this type:
+ [`add_filter!`](@ref)
+ [`cancel!`](@ref)
+ [`clear_filters!`](@ref)
+ [`get_accept_label`](@ref)
+ [`get_file_chooser_action`](@ref)
+ [`get_is_modal`](@ref)
+ [`get_title`](@ref)
+ [`on_accept!`](@ref)
+ [`on_cancel!`](@ref)
+ [`present!`](@ref)
+ [`set_accept_label!`](@ref)
+ [`set_file_chooser_action!`](@ref)
+ [`set_initial_file!`](@ref)
+ [`set_initial_filter!`](@ref)
+ [`set_initial_folder!`](@ref)
+ [`set_initial_name!`](@ref)
+ [`set_is_modal!`](@ref)
+ [`set_title!`](@ref)


---
## FileDescriptor
```@docs
FileDescriptor
```
#### Functions that operate on this type:
+ [`copy!`](@ref)
+ [`create_as_file_preview!`](@ref)
+ [`create_directory_at!`](@ref)
+ [`create_file_at!`](@ref)
+ [`create_from_path!`](@ref)
+ [`create_from_uri!`](@ref)
+ [`create_monitor`](@ref)
+ [`delete_at!`](@ref)
+ [`exists`](@ref)
+ [`get_children`](@ref)
+ [`get_content_type`](@ref)
+ [`get_file_extension`](@ref)
+ [`get_name`](@ref)
+ [`get_parent`](@ref)
+ [`get_path`](@ref)
+ [`get_path_relative_to`](@ref)
+ [`get_uri`](@ref)
+ [`is_executable`](@ref)
+ [`is_file`](@ref)
+ [`is_folder`](@ref)
+ [`is_symlink`](@ref)
+ [`move!`](@ref)
+ [`move_to_trash!`](@ref)
+ [`open_file`](@ref)
+ [`open_url`](@ref)
+ [`query_info`](@ref)
+ [`read_symlink`](@ref)
+ [`set_file!`](@ref)
+ [`set_initial_file!`](@ref)
+ [`set_initial_folder!`](@ref)
+ [`show_in_file_explorer`](@ref)


---
## FileFilter
```@docs
FileFilter
```
#### Functions that operate on this type:
+ [`add_allow_all_supported_image_formats!`](@ref)
+ [`add_allowed_mime_type!`](@ref)
+ [`add_allowed_pattern!`](@ref)
+ [`add_allowed_suffix!`](@ref)
+ [`add_filter!`](@ref)
+ [`get_name`](@ref)
+ [`set_initial_filter!`](@ref)


---
## FileMonitor
```@docs
FileMonitor
```
#### Functions that operate on this type:
+ [`cancel!`](@ref)
+ [`is_cancelled`](@ref)
+ [`on_file_changed!`](@ref)


---
## Fixed
```@docs
Fixed
```
#### Functions that operate on this type:
+ [`add_child!`](@ref)
+ [`remove_child!`](@ref)
+ [`set_child_position!`](@ref)


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## FlowBox
```@docs
FlowBox
```
#### Functions that operate on this type:
+ [`clear!`](@ref)
+ [`get_column_spacing`](@ref)
+ [`get_homogeneous`](@ref)
+ [`get_n_items`](@ref)
+ [`get_orientation`](@ref)
+ [`get_row_spacing`](@ref)
+ [`insert_at!`](@ref)
+ [`push_back!`](@ref)
+ [`push_front!`](@ref)
+ [`remove!`](@ref)
+ [`set_column_spacing!`](@ref)
+ [`set_homogeneous!`](@ref)
+ [`set_orientation!`](@ref)
+ [`set_row_spacing!`](@ref)


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## FocusEventController
```@docs
FocusEventController
```
#### Functions that operate on this type:
+ [`self_is_focused`](@ref)
+ [`self_or_child_is_focused`](@ref)


+ [`connect_signal_focus_gained!`](@ref)
+ [`connect_signal_focus_lost!`](@ref)
+ [`disconnect_signal_focus_gained!`](@ref)
+ [`disconnect_signal_focus_lost!`](@ref)
+ [`emit_signal_focus_gained`](@ref)
+ [`emit_signal_focus_lost`](@ref)
+ [`get_signal_focus_gained_blocked`](@ref)
+ [`get_signal_focus_lost_blocked`](@ref)
+ [`set_signal_focus_gained_blocked!`](@ref)
+ [`set_signal_focus_lost_blocked!`](@ref)






---
## Frame
```@docs
Frame
```
#### Functions that operate on this type:
+ [`get_label_x_alignment`](@ref)
+ [`remove_child!`](@ref)
+ [`remove_label_widget!`](@ref)
+ [`set_child!`](@ref)
+ [`set_label_widget!`](@ref)
+ [`set_label_x_alignment!`](@ref)


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## FrameClock
```@docs
FrameClock
```
#### Functions that operate on this type:
+ [`get_target_frame_duration`](@ref)
+ [`get_time_since_last_frame`](@ref)


+ [`connect_signal_paint!`](@ref)
+ [`disconnect_signal_paint!`](@ref)
+ [`emit_signal_paint`](@ref)
+ [`get_signal_paint_blocked`](@ref)
+ [`set_signal_paint_blocked!`](@ref)


+ [`connect_signal_update!`](@ref)
+ [`disconnect_signal_update!`](@ref)
+ [`emit_signal_update`](@ref)
+ [`get_signal_update_blocked`](@ref)
+ [`set_signal_update_blocked!`](@ref)


---
## GLTransform
```@docs
GLTransform
```
#### Functions that operate on this type:
+ [`apply_to`](@ref)
+ [`combine_with`](@ref)
+ [`reset!`](@ref)
+ [`rotate!`](@ref)
+ [`scale!`](@ref)
+ [`translate!`](@ref)


---
## Grid
```@docs
Grid
```
#### Functions that operate on this type:
+ [`get_column_spacing`](@ref)
+ [`get_columns_homogeneous`](@ref)
+ [`get_orientation`](@ref)
+ [`get_position`](@ref)
+ [`get_row_spacing`](@ref)
+ [`get_rows_homogeneous`](@ref)
+ [`get_size`](@ref)
+ [`insert_at!`](@ref)
+ [`insert_column_at!`](@ref)
+ [`insert_next_to!`](@ref)
+ [`insert_row_at!`](@ref)
+ [`remove!`](@ref)
+ [`remove_column_at!`](@ref)
+ [`remove_row_at!`](@ref)
+ [`set_column_spacing!`](@ref)
+ [`set_columns_homogeneous!`](@ref)
+ [`set_orientation!`](@ref)
+ [`set_row_spacing!`](@ref)
+ [`set_rows_homogeneous!`](@ref)


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## GridView
```@docs
GridView
```
#### Functions that operate on this type:
+ [`clear!`](@ref)
+ [`find`](@ref)
+ [`get_enable_rubberband_selection`](@ref)
+ [`get_max_n_columns`](@ref)
+ [`get_min_n_columns`](@ref)
+ [`get_n_items`](@ref)
+ [`get_orientation`](@ref)
+ [`get_selection_model`](@ref)
+ [`get_single_click_activate`](@ref)
+ [`insert_at!`](@ref)
+ [`push_back!`](@ref)
+ [`push_front!`](@ref)
+ [`remove!`](@ref)
+ [`set_enable_rubberband_selection!`](@ref)
+ [`set_max_n_columns!`](@ref)
+ [`set_min_n_columns!`](@ref)
+ [`set_orientation!`](@ref)
+ [`set_single_click_activate!`](@ref)


+ [`connect_signal_activate_item!`](@ref)
+ [`disconnect_signal_activate_item!`](@ref)
+ [`emit_signal_activate_item`](@ref)
+ [`get_signal_activate_item_blocked`](@ref)
+ [`set_signal_activate_item_blocked!`](@ref)




+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## GroupID
```@docs
GroupID
```
#### Functions that operate on this type:


---
## HSVA
```@docs
HSVA
```
#### Functions that operate on this type:
+ [`hsva_to_rgba`](@ref)
+ [`serialize`](@ref)
+ [`set_color!`](@ref)


---
## HeaderBar
```@docs
HeaderBar
```
#### Functions that operate on this type:
+ [`get_layout`](@ref)
+ [`get_show_title_buttons`](@ref)
+ [`push_back!`](@ref)
+ [`push_front!`](@ref)
+ [`remove!`](@ref)
+ [`remove_title_widget!`](@ref)
+ [`set_layout!`](@ref)
+ [`set_show_title_buttons!`](@ref)
+ [`set_title_widget!`](@ref)


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## Icon
```@docs
Icon
```
#### Functions that operate on this type:
+ [`add_icon!`](@ref)
+ [`create_from_file!`](@ref)
+ [`create_from_icon!`](@ref)
+ [`create_from_theme!`](@ref)
+ [`get_name`](@ref)
+ [`get_size`](@ref)
+ [`has_icon`](@ref)
+ [`set_icon!`](@ref)
+ [`set_primary_icon!`](@ref)
+ [`set_secondary_icon!`](@ref)


---
## IconID
```@docs
IconID
```
#### Functions that operate on this type:


---
## IconTheme
```@docs
IconTheme
```
#### Functions that operate on this type:
+ [`add_resource_path!`](@ref)
+ [`create_from_theme!`](@ref)
+ [`get_icon_names`](@ref)
+ [`has_icon`](@ref)
+ [`set_resource_path!`](@ref)


---
## Image
```@docs
Image
```
#### Functions that operate on this type:
+ [`as_cropped`](@ref)
+ [`as_flipped`](@ref)
+ [`as_scaled`](@ref)
+ [`create!`](@ref)
+ [`create_from_file!`](@ref)
+ [`create_from_image!`](@ref)
+ [`get_n_pixels`](@ref)
+ [`get_pixel`](@ref)
+ [`get_size`](@ref)
+ [`save_to_file`](@ref)
+ [`set_cursor_from_image!`](@ref)
+ [`set_image!`](@ref)
+ [`set_pixel!`](@ref)


---
## ImageDisplay
```@docs
ImageDisplay
```
#### Functions that operate on this type:
+ [`clear!`](@ref)
+ [`create_as_file_preview!`](@ref)
+ [`create_from_file!`](@ref)
+ [`create_from_icon!`](@ref)
+ [`create_from_image!`](@ref)
+ [`get_scale`](@ref)
+ [`get_size`](@ref)
+ [`set_scale!`](@ref)


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## KeyCode
```@docs
KeyCode
```
#### Functions that operate on this type:


+ [`emit_signal_key_pressed`](@ref)
+ [`emit_signal_key_released`](@ref)


---
## KeyEventController
```@docs
KeyEventController
```
#### Functions that operate on this type:
+ [`should_shortcut_trigger_trigger`](@ref)


+ [`connect_signal_key_pressed!`](@ref)
+ [`connect_signal_key_released!`](@ref)
+ [`disconnect_signal_key_pressed!`](@ref)
+ [`disconnect_signal_key_released!`](@ref)
+ [`emit_signal_key_pressed`](@ref)
+ [`emit_signal_key_released`](@ref)
+ [`get_signal_key_pressed_blocked`](@ref)
+ [`get_signal_key_released_blocked`](@ref)
+ [`set_signal_key_pressed_blocked!`](@ref)
+ [`set_signal_key_released_blocked!`](@ref)






+ [`connect_signal_modifiers_changed!`](@ref)
+ [`disconnect_signal_modifiers_changed!`](@ref)
+ [`emit_signal_modifiers_changed`](@ref)
+ [`get_signal_modifiers_changed_blocked`](@ref)
+ [`set_signal_modifiers_changed_blocked!`](@ref)




---
## KeyFile
```@docs
KeyFile
```
#### Functions that operate on this type:
+ [`as_string`](@ref)
+ [`create_from_file!`](@ref)
+ [`create_from_string!`](@ref)
+ [`get_comment_above`](@ref)
+ [`get_groups`](@ref)
+ [`get_keys`](@ref)
+ [`get_value`](@ref)
+ [`has_group`](@ref)
+ [`has_key`](@ref)
+ [`save_to_file`](@ref)
+ [`set_comment_above!`](@ref)
+ [`set_value!`](@ref)


---
## KeyID
```@docs
KeyID
```
#### Functions that operate on this type:


---
## Label
```@docs
Label
```
#### Functions that operate on this type:
+ [`get_ellipsize_mode`](@ref)
+ [`get_is_selectable`](@ref)
+ [`get_justify_mode`](@ref)
+ [`get_max_width_chars`](@ref)
+ [`get_text`](@ref)
+ [`get_use_markup`](@ref)
+ [`get_wrap_mode`](@ref)
+ [`get_x_alignment`](@ref)
+ [`get_y_alignment`](@ref)
+ [`set_ellipsize_mode!`](@ref)
+ [`set_is_selectable!`](@ref)
+ [`set_justify_mode!`](@ref)
+ [`set_max_width_chars!`](@ref)
+ [`set_text!`](@ref)
+ [`set_use_markup!`](@ref)
+ [`set_wrap_mode!`](@ref)
+ [`set_x_alignment!`](@ref)
+ [`set_y_alignment!`](@ref)


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## LevelBar
```@docs
LevelBar
```
#### Functions that operate on this type:
+ [`add_marker!`](@ref)
+ [`get_inverted`](@ref)
+ [`get_max_value`](@ref)
+ [`get_min_value`](@ref)
+ [`get_mode`](@ref)
+ [`get_orientation`](@ref)
+ [`get_value`](@ref)
+ [`remove_marker!`](@ref)
+ [`set_inverted!`](@ref)
+ [`set_max_value!`](@ref)
+ [`set_min_value!`](@ref)
+ [`set_mode!`](@ref)
+ [`set_orientation!`](@ref)
+ [`set_value!`](@ref)


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## ListView
```@docs
ListView
```
#### Functions that operate on this type:
+ [`clear!`](@ref)
+ [`find`](@ref)
+ [`get_enable_rubberband_selection`](@ref)
+ [`get_n_items`](@ref)
+ [`get_orientation`](@ref)
+ [`get_selection_model`](@ref)
+ [`get_show_separators`](@ref)
+ [`get_single_click_activate`](@ref)
+ [`insert_at!`](@ref)
+ [`push_back!`](@ref)
+ [`push_front!`](@ref)
+ [`remove!`](@ref)
+ [`set_enable_rubberband_selection!`](@ref)
+ [`set_orientation!`](@ref)
+ [`set_show_separators!`](@ref)
+ [`set_single_click_activate!`](@ref)
+ [`set_widget_at!`](@ref)


+ [`connect_signal_activate_item!`](@ref)
+ [`disconnect_signal_activate_item!`](@ref)
+ [`emit_signal_activate_item`](@ref)
+ [`get_signal_activate_item_blocked`](@ref)
+ [`set_signal_activate_item_blocked!`](@ref)




+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## ListViewIterator
```@docs
ListViewIterator
```
#### Functions that operate on this type:
+ [`clear!`](@ref)


---
## LogDomain
```@docs
LogDomain
```
#### Functions that operate on this type:


---
## LongPressEventController
```@docs
LongPressEventController
```
#### Functions that operate on this type:
+ [`get_delay_factor`](@ref)
+ [`set_delay_factor!`](@ref)


+ [`connect_signal_press_cancelled!`](@ref)
+ [`connect_signal_pressed!`](@ref)
+ [`disconnect_signal_press_cancelled!`](@ref)
+ [`disconnect_signal_pressed!`](@ref)
+ [`emit_signal_press_cancelled`](@ref)
+ [`emit_signal_pressed`](@ref)
+ [`get_signal_press_cancelled_blocked`](@ref)
+ [`get_signal_pressed_blocked`](@ref)
+ [`set_signal_press_cancelled_blocked!`](@ref)
+ [`set_signal_pressed_blocked!`](@ref)






---
## MenuBar
```@docs
MenuBar
```
#### Functions that operate on this type:


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## MenuModel
```@docs
MenuModel
```
#### Functions that operate on this type:
+ [`add_action!`](@ref)
+ [`add_icon!`](@ref)
+ [`add_section!`](@ref)
+ [`add_submenu!`](@ref)
+ [`add_widget!`](@ref)
+ [`set_header_menu!`](@ref)


+ [`connect_signal_items_changed!`](@ref)
+ [`disconnect_signal_items_changed!`](@ref)
+ [`emit_signal_items_changed`](@ref)
+ [`get_signal_items_changed_blocked`](@ref)
+ [`set_signal_items_changed_blocked!`](@ref)




---
## ModifierState
```@docs
ModifierState
```
#### Functions that operate on this type:
+ [`alt_pressed`](@ref)
+ [`control_pressed`](@ref)
+ [`mouse_button_01_pressed`](@ref)
+ [`mouse_button_02_pressed`](@ref)
+ [`shift_pressed`](@ref)


+ [`emit_signal_key_pressed`](@ref)
+ [`emit_signal_key_released`](@ref)


+ [`emit_signal_modifiers_changed`](@ref)


---
## MotionEventController
```@docs
MotionEventController
```
#### Functions that operate on this type:


+ [`connect_signal_motion!`](@ref)
+ [`connect_signal_motion_enter!`](@ref)
+ [`connect_signal_motion_leave!`](@ref)
+ [`disconnect_signal_motion!`](@ref)
+ [`disconnect_signal_motion_enter!`](@ref)
+ [`disconnect_signal_motion_leave!`](@ref)
+ [`emit_signal_motion`](@ref)
+ [`emit_signal_motion_enter`](@ref)
+ [`emit_signal_motion_leave`](@ref)
+ [`get_signal_motion_blocked`](@ref)
+ [`get_signal_motion_enter_blocked`](@ref)
+ [`get_signal_motion_leave_blocked`](@ref)
+ [`set_signal_motion_blocked!`](@ref)
+ [`set_signal_motion_enter_blocked!`](@ref)
+ [`set_signal_motion_leave_blocked!`](@ref)






---
## Notebook
```@docs
Notebook
```
#### Functions that operate on this type:
+ [`get_current_page`](@ref)
+ [`get_has_border`](@ref)
+ [`get_is_scrollable`](@ref)
+ [`get_n_pages`](@ref)
+ [`get_quick_change_menu_enabled`](@ref)
+ [`get_tab_position`](@ref)
+ [`get_tabs_reorderable`](@ref)
+ [`get_tabs_visible`](@ref)
+ [`goto_page!`](@ref)
+ [`insert_at!`](@ref)
+ [`move_page_to!`](@ref)
+ [`next_page!`](@ref)
+ [`previous_page!`](@ref)
+ [`push_back!`](@ref)
+ [`push_front!`](@ref)
+ [`remove!`](@ref)
+ [`set_has_border!`](@ref)
+ [`set_is_scrollable!`](@ref)
+ [`set_quick_change_menu_enabled!`](@ref)
+ [`set_tab_position!`](@ref)
+ [`set_tabs_reorderable!`](@ref)
+ [`set_tabs_visible!`](@ref)


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_page_added!`](@ref)
+ [`connect_signal_page_removed!`](@ref)
+ [`connect_signal_page_reordered!`](@ref)
+ [`connect_signal_page_selection_changed!`](@ref)
+ [`disconnect_signal_page_added!`](@ref)
+ [`disconnect_signal_page_removed!`](@ref)
+ [`disconnect_signal_page_reordered!`](@ref)
+ [`disconnect_signal_page_selection_changed!`](@ref)
+ [`emit_signal_page_added`](@ref)
+ [`emit_signal_page_removed`](@ref)
+ [`emit_signal_page_reordered`](@ref)
+ [`emit_signal_page_selection_changed`](@ref)
+ [`get_signal_page_added_blocked`](@ref)
+ [`get_signal_page_removed_blocked`](@ref)
+ [`get_signal_page_reordered_blocked`](@ref)
+ [`get_signal_page_selection_changed_blocked`](@ref)
+ [`set_signal_page_added_blocked!`](@ref)
+ [`set_signal_page_removed_blocked!`](@ref)
+ [`set_signal_page_reordered_blocked!`](@ref)
+ [`set_signal_page_selection_changed_blocked!`](@ref)












+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## Overlay
```@docs
Overlay
```
#### Functions that operate on this type:
+ [`add_overlay!`](@ref)
+ [`remove_child!`](@ref)
+ [`remove_overlay!`](@ref)
+ [`set_child!`](@ref)


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## PanEventController
```@docs
PanEventController
```
#### Functions that operate on this type:
+ [`get_orientation`](@ref)
+ [`set_orientation!`](@ref)


+ [`connect_signal_pan!`](@ref)
+ [`disconnect_signal_pan!`](@ref)
+ [`emit_signal_pan`](@ref)
+ [`get_signal_pan_blocked`](@ref)
+ [`set_signal_pan_blocked!`](@ref)


---
## Paned
```@docs
Paned
```
#### Functions that operate on this type:
+ [`get_end_child_resizable`](@ref)
+ [`get_end_child_shrinkable`](@ref)
+ [`get_has_wide_handle`](@ref)
+ [`get_orientation`](@ref)
+ [`get_position`](@ref)
+ [`get_start_child_resizable`](@ref)
+ [`get_start_child_shrinkable`](@ref)
+ [`remove_end_child!`](@ref)
+ [`remove_start_child!`](@ref)
+ [`set_end_child!`](@ref)
+ [`set_end_child_resizable!`](@ref)
+ [`set_end_child_shrinkable!`](@ref)
+ [`set_has_wide_handle!`](@ref)
+ [`set_orientation!`](@ref)
+ [`set_position!`](@ref)
+ [`set_start_child!`](@ref)
+ [`set_start_child_resizable!`](@ref)
+ [`set_start_child_shrinkable!`](@ref)


---
## PinchZoomEventController
```@docs
PinchZoomEventController
```
#### Functions that operate on this type:
+ [`get_scale_delta`](@ref)


+ [`connect_signal_scale_changed!`](@ref)
+ [`disconnect_signal_scale_changed!`](@ref)
+ [`emit_signal_scale_changed`](@ref)
+ [`get_signal_scale_changed_blocked`](@ref)
+ [`set_signal_scale_changed_blocked!`](@ref)




---
## Popover
```@docs
Popover
```
#### Functions that operate on this type:
+ [`get_autohide`](@ref)
+ [`get_has_base_arrow`](@ref)
+ [`get_relative_position`](@ref)
+ [`popdown!`](@ref)
+ [`popup!`](@ref)
+ [`remove_child!`](@ref)
+ [`set_autohide!`](@ref)
+ [`set_child!`](@ref)
+ [`set_has_base_arrow!`](@ref)
+ [`set_popover!`](@ref)
+ [`set_relative_position!`](@ref)


+ [`connect_signal_closed!`](@ref)
+ [`disconnect_signal_closed!`](@ref)
+ [`emit_signal_closed`](@ref)
+ [`get_signal_closed_blocked`](@ref)
+ [`set_signal_closed_blocked!`](@ref)


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## PopoverButton
```@docs
PopoverButton
```
#### Functions that operate on this type:
+ [`get_always_show_arrow`](@ref)
+ [`get_has_frame`](@ref)
+ [`get_is_circular`](@ref)
+ [`get_relative_position`](@ref)
+ [`popdown!`](@ref)
+ [`popup!`](@ref)
+ [`remove_child!`](@ref)
+ [`remove_popover!`](@ref)
+ [`set_always_show_arrow!`](@ref)
+ [`set_child!`](@ref)
+ [`set_has_frame!`](@ref)
+ [`set_icon!`](@ref)
+ [`set_is_circular!`](@ref)
+ [`set_popover!`](@ref)
+ [`set_popover_menu!`](@ref)
+ [`set_relative_position!`](@ref)


+ [`connect_signal_activate!`](@ref)
+ [`disconnect_signal_activate!`](@ref)
+ [`emit_signal_activate`](@ref)
+ [`get_signal_activate_blocked`](@ref)
+ [`set_signal_activate_blocked!`](@ref)


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## PopoverMenu
```@docs
PopoverMenu
```
#### Functions that operate on this type:
+ [`set_popover_menu!`](@ref)


+ [`connect_signal_closed!`](@ref)
+ [`disconnect_signal_closed!`](@ref)
+ [`emit_signal_closed`](@ref)
+ [`get_signal_closed_blocked`](@ref)
+ [`set_signal_closed_blocked!`](@ref)


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
## PopupMessage
```@docs
PopupMessage
```
#### Functions that operate on this type:
+ [`get_button_action_id`](@ref)
+ [`get_button_label`](@ref)
+ [`get_is_high_priority`](@ref)
+ [`get_timeout`](@ref)
+ [`get_title`](@ref)
+ [`set_button_action!`](@ref)
+ [`set_button_label!`](@ref)
+ [`set_is_high_priority!`](@ref)
+ [`set_timeout!`](@ref)
+ [`set_title!`](@ref)
+ [`show_message!`](@ref)


+ [`connect_signal_button_clicked!`](@ref)
+ [`disconnect_signal_button_clicked!`](@ref)
+ [`emit_signal_button_clicked`](@ref)
+ [`get_signal_button_clicked_blocked`](@ref)
+ [`set_signal_button_clicked_blocked!`](@ref)




+ [`connect_signal_dismissed!`](@ref)
+ [`disconnect_signal_dismissed!`](@ref)
+ [`emit_signal_dismissed`](@ref)
+ [`get_signal_dismissed_blocked`](@ref)
+ [`set_signal_dismissed_blocked!`](@ref)


---
## PopupMessageOverlay
```@docs
PopupMessageOverlay
```
#### Functions that operate on this type:
+ [`remove_child!`](@ref)
+ [`set_child!`](@ref)
+ [`show_message!`](@ref)


+ [`connect_signal_destroy!`](@ref)
+ [`disconnect_signal_destroy!`](@ref)
+ [`emit_signal_destroy`](@ref)
+ [`get_signal_destroy_blocked`](@ref)
+ [`set_signal_destroy_blocked!`](@ref)


+ [`connect_signal_hide!`](@ref)
+ [`disconnect_signal_hide!`](@ref)
+ [`emit_signal_hide`](@ref)
+ [`get_signal_hide_blocked`](@ref)
+ [`set_signal_hide_blocked!`](@ref)


+ [`connect_signal_map!`](@ref)
+ [`disconnect_signal_map!`](@ref)
+ [`emit_signal_map`](@ref)
+ [`get_signal_map_blocked`](@ref)
+ [`set_signal_map_blocked!`](@ref)


+ [`connect_signal_realize!`](@ref)
+ [`disconnect_signal_realize!`](@ref)
+ [`emit_signal_realize`](@ref)
+ [`get_signal_realize_blocked`](@ref)
+ [`set_signal_realize_blocked!`](@ref)


+ [`connect_signal_show!`](@ref)
+ [`disconnect_signal_show!`](@ref)
+ [`emit_signal_show`](@ref)
+ [`get_signal_show_blocked`](@ref)
+ [`set_signal_show_blocked!`](@ref)


+ [`connect_signal_unmap!`](@ref)
+ [`disconnect_signal_unmap!`](@ref)
+ [`emit_signal_unmap`](@ref)
+ [`get_signal_unmap_blocked`](@ref)
+ [`set_signal_unmap_blocked!`](@ref)


+ [`connect_signal_unrealize!`](@ref)
+ [`disconnect_signal_unrealize!`](@ref)
+ [`emit_signal_unrealize`](@ref)
+ [`get_signal_unrealize_blocked`](@ref)
+ [`set_signal_unrealize_blocked!`](@ref)


---
