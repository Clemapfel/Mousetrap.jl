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
## ProgressBar
```@docs
ProgressBar
```
#### Functions that operate on this type:
+ [`get_fraction`](@ref)
+ [`get_is_inverted`](@ref)
+ [`get_orientation`](@ref)
+ [`get_show_text`](@ref)
+ [`get_text`](@ref)
+ [`pulse`](@ref)
+ [`set_fraction!`](@ref)
+ [`set_is_inverted!`](@ref)
+ [`set_orientation!`](@ref)
+ [`set_show_text!`](@ref)
+ [`set_text!`](@ref)


---
## RGBA
```@docs
RGBA
```
#### Functions that operate on this type:
+ [`rgba_to_hsva`](@ref)
+ [`rgba_to_html_code`](@ref)
+ [`set_color!`](@ref)


---
## RenderArea
```@docs
RenderArea
```
#### Functions that operate on this type:
+ [`add_render_task!`](@ref)
+ [`clear`](@ref)
+ [`clear_render_tasks!`](@ref)
+ [`flush`](@ref)
+ [`from_gl_coordinates`](@ref)
+ [`make_current`](@ref)
+ [`queue_render`](@ref)
+ [`render_render_tasks`](@ref)
+ [`to_gl_coordinates`](@ref)


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


+ [`connect_signal_render!`](@ref)
+ [`disconnect_signal_render!`](@ref)
+ [`emit_signal_render`](@ref)
+ [`get_signal_render_blocked`](@ref)
+ [`set_signal_render_blocked!`](@ref)


+ [`connect_signal_resize!`](@ref)
+ [`disconnect_signal_resize!`](@ref)
+ [`emit_signal_resize`](@ref)
+ [`get_signal_resize_blocked`](@ref)
+ [`set_signal_resize_blocked!`](@ref)


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
## RenderTask
```@docs
RenderTask
```
#### Functions that operate on this type:
+ [`add_render_task!`](@ref)
+ [`get_uniform_float`](@ref)
+ [`get_uniform_hsva`](@ref)
+ [`get_uniform_int`](@ref)
+ [`get_uniform_rgba`](@ref)
+ [`get_uniform_transform`](@ref)
+ [`get_uniform_uint`](@ref)
+ [`get_uniform_vec2`](@ref)
+ [`get_uniform_vec3`](@ref)
+ [`get_uniform_vec4`](@ref)
+ [`render`](@ref)
+ [`set_uniform_float!`](@ref)
+ [`set_uniform_hsva!`](@ref)
+ [`set_uniform_int!`](@ref)
+ [`set_uniform_rgba!`](@ref)
+ [`set_uniform_transform!`](@ref)
+ [`set_uniform_uint!`](@ref)
+ [`set_uniform_vec2!`](@ref)
+ [`set_uniform_vec3!`](@ref)
+ [`set_uniform_vec4!`](@ref)


---
## RenderTexture
```@docs
RenderTexture
```
#### Functions that operate on this type:
+ [`bind_as_render_target`](@ref)
+ [`unbind_as_render_target`](@ref)


---
## Revealer
```@docs
Revealer
```
#### Functions that operate on this type:
+ [`get_is_revealed`](@ref)
+ [`get_transition_duration`](@ref)
+ [`get_transition_type`](@ref)
+ [`remove_child!`](@ref)
+ [`set_child!`](@ref)
+ [`set_is_revealed!`](@ref)
+ [`set_transition_duration!`](@ref)
+ [`set_transition_type!`](@ref)


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


+ [`connect_signal_revealed!`](@ref)
+ [`disconnect_signal_revealed!`](@ref)
+ [`emit_signal_revealed`](@ref)
+ [`get_signal_revealed_blocked`](@ref)
+ [`set_signal_revealed_blocked!`](@ref)


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
## RotateEventController
```@docs
RotateEventController
```
#### Functions that operate on this type:
+ [`get_angle_delta`](@ref)


+ [`connect_signal_rotation_changed!`](@ref)
+ [`disconnect_signal_rotation_changed!`](@ref)
+ [`emit_signal_rotation_changed`](@ref)
+ [`get_signal_rotation_changed_blocked`](@ref)
+ [`set_signal_rotation_changed_blocked!`](@ref)




---
## Scale
```@docs
Scale
```
#### Functions that operate on this type:
+ [`add_mark!`](@ref)
+ [`clear_marks!`](@ref)
+ [`get_adjustment`](@ref)
+ [`get_has_origin`](@ref)
+ [`get_lower`](@ref)
+ [`get_orientation`](@ref)
+ [`get_should_draw_value`](@ref)
+ [`get_step_increment`](@ref)
+ [`get_upper`](@ref)
+ [`get_value`](@ref)
+ [`set_has_origin!`](@ref)
+ [`set_lower!`](@ref)
+ [`set_orientation!`](@ref)
+ [`set_should_draw_value!`](@ref)
+ [`set_step_increment!`](@ref)
+ [`set_upper!`](@ref)
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


+ [`connect_signal_value_changed!`](@ref)
+ [`disconnect_signal_value_changed!`](@ref)
+ [`emit_signal_value_changed`](@ref)
+ [`get_signal_value_changed_blocked`](@ref)
+ [`set_signal_value_changed_blocked!`](@ref)




---
## ScrollEventController
```@docs
ScrollEventController
```
#### Functions that operate on this type:
+ [`get_kinetic_scrolling_enabled`](@ref)
+ [`set_kinetic_scrolling_enabled!`](@ref)


+ [`connect_signal_kinetic_scroll_decelerate!`](@ref)
+ [`disconnect_signal_kinetic_scroll_decelerate!`](@ref)
+ [`emit_signal_kinetic_scroll_decelerate`](@ref)
+ [`get_signal_kinetic_scroll_decelerate_blocked`](@ref)
+ [`set_signal_kinetic_scroll_decelerate_blocked!`](@ref)




+ [`connect_signal_scroll!`](@ref)
+ [`connect_signal_scroll_begin!`](@ref)
+ [`connect_signal_scroll_end!`](@ref)
+ [`disconnect_signal_scroll!`](@ref)
+ [`disconnect_signal_scroll_begin!`](@ref)
+ [`disconnect_signal_scroll_end!`](@ref)
+ [`emit_signal_scroll`](@ref)
+ [`emit_signal_scroll_begin`](@ref)
+ [`emit_signal_scroll_end`](@ref)
+ [`get_signal_scroll_begin_blocked`](@ref)
+ [`get_signal_scroll_blocked`](@ref)
+ [`get_signal_scroll_end_blocked`](@ref)
+ [`set_signal_scroll_begin_blocked!`](@ref)
+ [`set_signal_scroll_blocked!`](@ref)
+ [`set_signal_scroll_end_blocked!`](@ref)






---
## Scrollbar
```@docs
Scrollbar
```
#### Functions that operate on this type:
+ [`get_adjustment`](@ref)
+ [`get_orientation`](@ref)
+ [`set_orientation!`](@ref)


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
## SelectionModel
```@docs
SelectionModel
```
#### Functions that operate on this type:
+ [`get_n_items`](@ref)
+ [`get_selection`](@ref)
+ [`get_selection_mode`](@ref)
+ [`select!`](@ref)
+ [`select_all!`](@ref)
+ [`unselect!`](@ref)
+ [`unselect_all!`](@ref)


+ [`connect_signal_selection_changed!`](@ref)
+ [`disconnect_signal_selection_changed!`](@ref)
+ [`emit_signal_selection_changed`](@ref)
+ [`get_signal_selection_changed_blocked`](@ref)
+ [`set_signal_selection_changed_blocked!`](@ref)




---
## Separator
```@docs
Separator
```
#### Functions that operate on this type:
+ [`get_orientation`](@ref)
+ [`set_orientation!`](@ref)


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
## Shader
```@docs
Shader
```
#### Functions that operate on this type:
+ [`create_from_file!`](@ref)
+ [`create_from_string!`](@ref)
+ [`get_fragment_shader_id`](@ref)
+ [`get_program_id`](@ref)
+ [`get_uniform_location`](@ref)
+ [`get_vertex_shader_id`](@ref)
+ [`render`](@ref)
+ [`set_uniform_float!`](@ref)
+ [`set_uniform_int!`](@ref)
+ [`set_uniform_transform!`](@ref)
+ [`set_uniform_uint!`](@ref)
+ [`set_uniform_vec2!`](@ref)
+ [`set_uniform_vec3!`](@ref)
+ [`set_uniform_vec4!`](@ref)


---
## Shape
```@docs
Shape
```
#### Functions that operate on this type:
+ [`Outline`](@ref)
+ [`as_circle!`](@ref)
+ [`as_circular_ring!`](@ref)
+ [`as_ellipse!`](@ref)
+ [`as_elliptical_ring!`](@ref)
+ [`as_line!`](@ref)
+ [`as_line_strip!`](@ref)
+ [`as_lines!`](@ref)
+ [`as_outline!`](@ref)
+ [`as_point!`](@ref)
+ [`as_points!`](@ref)
+ [`as_polygon!`](@ref)
+ [`as_rectangle!`](@ref)
+ [`as_rectangular_frame!`](@ref)
+ [`as_triangle!`](@ref)
+ [`as_wireframe!`](@ref)
+ [`get_bounding_box`](@ref)
+ [`get_centroid`](@ref)
+ [`get_is_visible`](@ref)
+ [`get_n_vertices`](@ref)
+ [`get_native_handle`](@ref)
+ [`get_size`](@ref)
+ [`get_top_left`](@ref)
+ [`get_vertex_color`](@ref)
+ [`get_vertex_position`](@ref)
+ [`get_vertex_texture_coordinate`](@ref)
+ [`remove_texture!`](@ref)
+ [`render`](@ref)
+ [`rotate!`](@ref)
+ [`set_centroid!`](@ref)
+ [`set_color!`](@ref)
+ [`set_is_visible!`](@ref)
+ [`set_texture!`](@ref)
+ [`set_top_left!`](@ref)
+ [`set_vertex_color!`](@ref)
+ [`set_vertex_position!`](@ref)
+ [`set_vertex_texture_coordinate!`](@ref)


---
## ShortcutEventController
```@docs
ShortcutEventController
```
#### Functions that operate on this type:
+ [`add_action!`](@ref)
+ [`get_scope`](@ref)
+ [`remove_action!`](@ref)
+ [`set_scope!`](@ref)


---
## ShortcutTrigger
```@docs
ShortcutTrigger
```
#### Functions that operate on this type:


---
## SignalEmitter
```@docs
SignalEmitter
```
---
## SingleClickGesture
```@docs
SingleClickGesture
```
#### Functions that operate on this type:
+ [`get_current_button`](@ref)
+ [`get_only_listens_to_button`](@ref)
+ [`get_touch_only`](@ref)
+ [`set_only_listens_to_button!`](@ref)
+ [`set_touch_only!`](@ref)


---
## SpinButton
```@docs
SpinButton
```
#### Functions that operate on this type:
+ [`get_acceleration_rate`](@ref)
+ [`get_adjustment`](@ref)
+ [`get_allow_only_numeric`](@ref)
+ [`get_lower`](@ref)
+ [`get_n_digits`](@ref)
+ [`get_orientation`](@ref)
+ [`get_should_snap_to_ticks`](@ref)
+ [`get_should_wrap`](@ref)
+ [`get_step_increment`](@ref)
+ [`get_upper`](@ref)
+ [`get_value`](@ref)
+ [`reset_text_to_value_function!`](@ref)
+ [`reset_value_to_text_function!`](@ref)
+ [`set_acceleration_rate!`](@ref)
+ [`set_allow_only_numeric!`](@ref)
+ [`set_lower!`](@ref)
+ [`set_n_digits!`](@ref)
+ [`set_orientation!`](@ref)
+ [`set_should_snap_to_ticks!`](@ref)
+ [`set_should_wrap!`](@ref)
+ [`set_step_increment!`](@ref)
+ [`set_text_to_value_function!`](@ref)
+ [`set_upper!`](@ref)
+ [`set_value!`](@ref)
+ [`set_value_to_text_function!`](@ref)


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


+ [`connect_signal_value_changed!`](@ref)
+ [`disconnect_signal_value_changed!`](@ref)
+ [`emit_signal_value_changed`](@ref)
+ [`get_signal_value_changed_blocked`](@ref)
+ [`set_signal_value_changed_blocked!`](@ref)




+ [`connect_signal_wrapped!`](@ref)
+ [`disconnect_signal_wrapped!`](@ref)
+ [`emit_signal_wrapped`](@ref)
+ [`get_signal_wrapped_blocked`](@ref)
+ [`set_signal_wrapped_blocked!`](@ref)


---
## Spinner
```@docs
Spinner
```
#### Functions that operate on this type:
+ [`get_is_spinning`](@ref)
+ [`set_is_spinning!`](@ref)
+ [`start!`](@ref)
+ [`stop!`](@ref)


---
## Stack
```@docs
Stack
```
#### Functions that operate on this type:
+ [`add_child!`](@ref)
+ [`get_child_at`](@ref)
+ [`get_is_horizontally_homogeneous`](@ref)
+ [`get_is_vertically_homogeneous`](@ref)
+ [`get_selection_model`](@ref)
+ [`get_should_interpolate_size`](@ref)
+ [`get_transition_duration`](@ref)
+ [`get_transition_type`](@ref)
+ [`get_visible_child`](@ref)
+ [`remove_child!`](@ref)
+ [`set_is_horizontally_homogeneous!`](@ref)
+ [`set_is_vertically_homogeneous!`](@ref)
+ [`set_should_interpolate_size!`](@ref)
+ [`set_transition_duration!`](@ref)
+ [`set_transition_type!`](@ref)
+ [`set_visible_child!`](@ref)


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
## StackID
```@docs
StackID
```
#### Functions that operate on this type:


---
## StackSidebar
```@docs
StackSidebar
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
## StackSwitcher
```@docs
StackSwitcher
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
## StylusEventController
```@docs
StylusEventController
```
#### Functions that operate on this type:
+ [`get_axis_value`](@ref)
+ [`get_hardware_id`](@ref)
+ [`get_tool_type`](@ref)
+ [`has_axis`](@ref)


+ [`connect_signal_motion!`](@ref)
+ [`disconnect_signal_motion!`](@ref)
+ [`emit_signal_motion`](@ref)
+ [`get_signal_motion_blocked`](@ref)
+ [`set_signal_motion_blocked!`](@ref)


+ [`connect_signal_proximity!`](@ref)
+ [`disconnect_signal_proximity!`](@ref)
+ [`emit_signal_proximity`](@ref)
+ [`get_signal_proximity_blocked`](@ref)
+ [`set_signal_proximity_blocked!`](@ref)


+ [`connect_signal_stylus_down!`](@ref)
+ [`connect_signal_stylus_up!`](@ref)
+ [`disconnect_signal_stylus_down!`](@ref)
+ [`disconnect_signal_stylus_up!`](@ref)
+ [`emit_signal_stylus_down`](@ref)
+ [`emit_signal_stylus_up`](@ref)
+ [`get_signal_stylus_down_blocked`](@ref)
+ [`get_signal_stylus_up_blocked`](@ref)
+ [`set_signal_stylus_down_blocked!`](@ref)
+ [`set_signal_stylus_up_blocked!`](@ref)






---
## SwipeEventController
```@docs
SwipeEventController
```
#### Functions that operate on this type:
+ [`get_velocity`](@ref)


+ [`connect_signal_swipe!`](@ref)
+ [`disconnect_signal_swipe!`](@ref)
+ [`emit_signal_swipe`](@ref)
+ [`get_signal_swipe_blocked`](@ref)
+ [`set_signal_swipe_blocked!`](@ref)


---
## Switch
```@docs
Switch
```
#### Functions that operate on this type:
+ [`get_is_active`](@ref)
+ [`set_is_active!`](@ref)


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


+ [`connect_signal_switched!`](@ref)
+ [`disconnect_signal_switched!`](@ref)
+ [`emit_signal_switched`](@ref)
+ [`get_signal_switched_blocked`](@ref)
+ [`set_signal_switched_blocked!`](@ref)


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
## TextView
```@docs
TextView
```
#### Functions that operate on this type:
+ [`get_bottom_margin`](@ref)
+ [`get_cursor_visible`](@ref)
+ [`get_editable`](@ref)
+ [`get_justify_mode`](@ref)
+ [`get_left_margin`](@ref)
+ [`get_right_margin`](@ref)
+ [`get_text`](@ref)
+ [`get_top_margin`](@ref)
+ [`get_was_modified`](@ref)
+ [`redo!`](@ref)
+ [`set_bottom_margin!`](@ref)
+ [`set_cursor_visible!`](@ref)
+ [`set_editable!`](@ref)
+ [`set_justify_mode!`](@ref)
+ [`set_left_margin!`](@ref)
+ [`set_right_margin!`](@ref)
+ [`set_text!`](@ref)
+ [`set_top_margin!`](@ref)
+ [`set_was_modified!`](@ref)
+ [`undo!`](@ref)


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
## Texture
```@docs
Texture
```
---
## TextureObject
```@docs
TextureObject
```
#### Functions that operate on this type:
+ [`bind`](@ref)
+ [`create!`](@ref)
+ [`create_from_image!`](@ref)
+ [`download`](@ref)
+ [`get_native_handle`](@ref)
+ [`get_scale_mode`](@ref)
+ [`get_size`](@ref)
+ [`get_wrap_mode`](@ref)
+ [`set_scale_mode!`](@ref)
+ [`set_texture!`](@ref)
+ [`set_wrap_mode!`](@ref)
+ [`unbind`](@ref)


---
## Time
```@docs
Time
```
#### Functions that operate on this type:
+ [`as_microseconds`](@ref)
+ [`as_milliseconds`](@ref)
+ [`as_minutes`](@ref)
+ [`as_nanoseconds`](@ref)
+ [`as_seconds`](@ref)
+ [`set_transition_duration!`](@ref)


---
## ToggleButton
```@docs
ToggleButton
```
#### Functions that operate on this type:
+ [`get_is_active`](@ref)
+ [`get_is_circular`](@ref)
+ [`remove_child!`](@ref)
+ [`set_child!`](@ref)
+ [`set_icon!`](@ref)
+ [`set_is_active!`](@ref)
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
```
#### Functions that operate on this type:
+ [`get_has_frame`](@ref)
+ [`get_horizontal_adjustment`](@ref)
+ [`get_horizontal_scrollbar_policy`](@ref)
+ [`get_kinetic_scrolling_enabled`](@ref)
+ [`get_propagate_natural_height`](@ref)
+ [`get_propagate_natural_width`](@ref)
+ [`get_scrollbar_placement`](@ref)
+ [`get_vertical_adjustment`](@ref)
+ [`get_vertical_scrollbar_policy`](@ref)
+ [`remove_child!`](@ref)
+ [`set_child!`](@ref)
+ [`set_has_frame!`](@ref)
+ [`set_horizontal_scrollbar_policy!`](@ref)
+ [`set_kinetic_scrolling_enabled!`](@ref)
+ [`set_propagate_natural_height!`](@ref)
+ [`set_propagate_natural_width!`](@ref)
+ [`set_scrollbar_placement!`](@ref)
+ [`set_vertical_scrollbar_policy!`](@ref)


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


+ [`connect_signal_scroll_child!`](@ref)
+ [`disconnect_signal_scroll_child!`](@ref)
+ [`emit_signal_scroll_child`](@ref)
+ [`get_signal_scroll_child_blocked`](@ref)
+ [`set_signal_scroll_child_blocked!`](@ref)




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
## Widget
```@docs
Widget
```
#### Functions that operate on this type:
+ [`activate!`](@ref)
+ [`add_child!`](@ref)
+ [`add_controller!`](@ref)
+ [`add_overlay!`](@ref)
+ [`add_widget!`](@ref)
+ [`find`](@ref)
+ [`get_allocated_size`](@ref)
+ [`get_can_respond_to_input`](@ref)
+ [`get_clipboard`](@ref)
+ [`get_expand_horizontally`](@ref)
+ [`get_expand_vertically`](@ref)
+ [`get_focus_on_click`](@ref)
+ [`get_has_focus`](@ref)
+ [`get_hide_on_overflow`](@ref)
+ [`get_horizontal_alignment`](@ref)
+ [`get_is_focusable`](@ref)
+ [`get_is_realized`](@ref)
+ [`get_is_visible`](@ref)
+ [`get_margin_bottom`](@ref)
+ [`get_margin_end`](@ref)
+ [`get_margin_start`](@ref)
+ [`get_margin_top`](@ref)
+ [`get_minimum_size`](@ref)
+ [`get_natural_size`](@ref)
+ [`get_opacity`](@ref)
+ [`get_position`](@ref)
+ [`get_size`](@ref)
+ [`get_size_request`](@ref)
+ [`get_vertical_alignment`](@ref)
+ [`grab_focus!`](@ref)
+ [`hide!`](@ref)
+ [`insert_after!`](@ref)
+ [`insert_at!`](@ref)
+ [`insert_next_to!`](@ref)
+ [`push_back!`](@ref)
+ [`push_front!`](@ref)
+ [`remove!`](@ref)
+ [`remove_child!`](@ref)
+ [`remove_controller!`](@ref)
+ [`remove_overlay!`](@ref)
+ [`remove_tick_callback!`](@ref)
+ [`remove_tooltip_widget!`](@ref)
+ [`set_alignment!`](@ref)
+ [`set_can_respond_to_input!`](@ref)
+ [`set_center_child!`](@ref)
+ [`set_child!`](@ref)
+ [`set_child_position!`](@ref)
+ [`set_cursor!`](@ref)
+ [`set_cursor_from_image!`](@ref)
+ [`set_default_widget!`](@ref)
+ [`set_end_child!`](@ref)
+ [`set_expand!`](@ref)
+ [`set_expand_horizontally!`](@ref)
+ [`set_expand_vertically!`](@ref)
+ [`set_extra_widget!`](@ref)
+ [`set_focus_on_click!`](@ref)
+ [`set_hide_on_overflow!`](@ref)
+ [`set_horizontal_alignment!`](@ref)
+ [`set_is_focusable!`](@ref)
+ [`set_is_visible!`](@ref)
+ [`set_label_widget!`](@ref)
+ [`set_listens_for_shortcut_action!`](@ref)
+ [`set_margin!`](@ref)
+ [`set_margin_bottom!`](@ref)
+ [`set_margin_end!`](@ref)
+ [`set_margin_horizontal!`](@ref)
+ [`set_margin_start!`](@ref)
+ [`set_margin_top!`](@ref)
+ [`set_margin_vertical!`](@ref)
+ [`set_opacity!`](@ref)
+ [`set_size_request!`](@ref)
+ [`set_start_child!`](@ref)
+ [`set_tick_callback!`](@ref)
+ [`set_title_widget!`](@ref)
+ [`set_tooltip_text!`](@ref)
+ [`set_tooltip_widget!`](@ref)
+ [`set_vertical_alignment!`](@ref)
+ [`show!`](@ref)
+ [`unparent!`](@ref)


---
## Window
```@docs
Window
```
#### Functions that operate on this type:
+ [`close!`](@ref)
+ [`destroy!`](@ref)
+ [`get_destroy_with_parent`](@ref)
+ [`get_focus_visible`](@ref)
+ [`get_has_close_button`](@ref)
+ [`get_header_bar`](@ref)
+ [`get_hide_on_close`](@ref)
+ [`get_is_decorated`](@ref)
+ [`get_is_modal`](@ref)
+ [`get_title`](@ref)
+ [`present!`](@ref)
+ [`remove_child!`](@ref)
+ [`set_application!`](@ref)
+ [`set_child!`](@ref)
+ [`set_default_widget!`](@ref)
+ [`set_destroy_with_parent!`](@ref)
+ [`set_focus_visible!`](@ref)
+ [`set_fullscreen!`](@ref)
+ [`set_has_close_button!`](@ref)
+ [`set_hide_on_close!`](@ref)
+ [`set_is_decorated!`](@ref)
+ [`set_is_modal!`](@ref)
+ [`set_maximized!`](@ref)
+ [`set_minimized!`](@ref)
+ [`set_startup_notification_identifier!`](@ref)
+ [`set_title!`](@ref)
+ [`set_transient_for!`](@ref)


+ [`connect_signal_activate_default_widget!`](@ref)
+ [`disconnect_signal_activate_default_widget!`](@ref)
+ [`emit_signal_activate_default_widget`](@ref)
+ [`get_signal_activate_default_widget_blocked`](@ref)
+ [`set_signal_activate_default_widget_blocked!`](@ref)




+ [`connect_signal_activate_focused_widget!`](@ref)
+ [`disconnect_signal_activate_focused_widget!`](@ref)
+ [`emit_signal_activate_focused_widget`](@ref)
+ [`get_signal_activate_focused_widget_blocked`](@ref)
+ [`set_signal_activate_focused_widget_blocked!`](@ref)




+ [`connect_signal_close_request!`](@ref)
+ [`disconnect_signal_close_request!`](@ref)
+ [`emit_signal_close_request`](@ref)
+ [`get_signal_close_request_blocked`](@ref)
+ [`set_signal_close_request_blocked!`](@ref)




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
