# Index: Classes
## Action
```@docs
Action
```
#### Functions that operate on this type:
+ [`mousetrap.activate!`](@ref)
+ [`mousetrap.add_action!`](@ref)
+ [`mousetrap.add_shortcut!`](@ref)
+ [`mousetrap.clear_shortcuts!`](@ref)
+ [`mousetrap.get_enabled`](@ref)
+ [`mousetrap.get_id`](@ref)
+ [`mousetrap.get_shortcuts`](@ref)
+ [`mousetrap.remove_action!`](@ref)
+ [`mousetrap.set_action!`](@ref)
+ [`mousetrap.set_enabled!`](@ref)
+ [`mousetrap.set_function!`](@ref)
+ [`mousetrap.set_listens_for_shortcut_action!`](@ref)


+ [`mousetrap.connect_signal_activated!`](@ref)
+ [`mousetrap.disconnect_signal_activated!`](@ref)
+ [`mousetrap.emit_signal_activated`](@ref)
+ [`mousetrap.get_signal_activated_blocked`](@ref)
+ [`mousetrap.set_signal_activated_blocked!`](@ref)


---
## Adjustment
```@docs
Adjustment
```
#### Functions that operate on this type:
+ [`mousetrap.get_lower`](@ref)
+ [`mousetrap.get_step_increment`](@ref)
+ [`mousetrap.get_upper`](@ref)
+ [`mousetrap.get_value`](@ref)
+ [`mousetrap.set_lower!`](@ref)
+ [`mousetrap.set_step_increment!`](@ref)
+ [`mousetrap.set_upper!`](@ref)
+ [`mousetrap.set_value!`](@ref)


+ [`mousetrap.connect_signal_properties_changed!`](@ref)
+ [`mousetrap.disconnect_signal_properties_changed!`](@ref)
+ [`mousetrap.emit_signal_properties_changed`](@ref)
+ [`mousetrap.get_signal_properties_changed_blocked`](@ref)
+ [`mousetrap.set_signal_properties_changed_blocked!`](@ref)




+ [`mousetrap.connect_signal_value_changed!`](@ref)
+ [`mousetrap.disconnect_signal_value_changed!`](@ref)
+ [`mousetrap.emit_signal_value_changed`](@ref)
+ [`mousetrap.get_signal_value_changed_blocked`](@ref)
+ [`mousetrap.set_signal_value_changed_blocked!`](@ref)




---
## AlertDialog
```@docs
AlertDialog
```
#### Functions that operate on this type:
+ [`mousetrap.add_button!`](@ref)
+ [`mousetrap.get_button_label`](@ref)
+ [`mousetrap.get_detailed_description`](@ref)
+ [`mousetrap.get_is_modal`](@ref)
+ [`mousetrap.get_message`](@ref)
+ [`mousetrap.get_n_buttons`](@ref)
+ [`mousetrap.on_selection!`](@ref)
+ [`mousetrap.present!`](@ref)
+ [`mousetrap.remove_button!`](@ref)
+ [`mousetrap.set_button_label!`](@ref)
+ [`mousetrap.set_detailed_description!`](@ref)
+ [`mousetrap.set_is_modal!`](@ref)
+ [`mousetrap.set_message!`](@ref)


---
## Angle
```@docs
Angle
```
#### Functions that operate on this type:
+ [`mousetrap.as_degrees`](@ref)
+ [`mousetrap.as_radians`](@ref)
+ [`mousetrap.rotate!`](@ref)


---
## Application
```@docs
Application
```
#### Functions that operate on this type:
+ [`mousetrap.add_action!`](@ref)
+ [`mousetrap.get_action`](@ref)
+ [`mousetrap.get_id`](@ref)
+ [`mousetrap.get_is_holding`](@ref)
+ [`mousetrap.get_is_marked_as_busy`](@ref)
+ [`mousetrap.has_action`](@ref)
+ [`mousetrap.hold!`](@ref)
+ [`mousetrap.mark_as_busy!`](@ref)
+ [`mousetrap.quit!`](@ref)
+ [`mousetrap.release!`](@ref)
+ [`mousetrap.remove_action!`](@ref)
+ [`mousetrap.run!`](@ref)
+ [`mousetrap.set_application!`](@ref)
+ [`mousetrap.unmark_as_busy!`](@ref)


+ [`mousetrap.connect_signal_activate!`](@ref)
+ [`mousetrap.disconnect_signal_activate!`](@ref)
+ [`mousetrap.emit_signal_activate`](@ref)
+ [`mousetrap.get_signal_activate_blocked`](@ref)
+ [`mousetrap.set_signal_activate_blocked!`](@ref)


+ [`mousetrap.connect_signal_shutdown!`](@ref)
+ [`mousetrap.disconnect_signal_shutdown!`](@ref)
+ [`mousetrap.emit_signal_shutdown`](@ref)
+ [`mousetrap.get_signal_shutdown_blocked`](@ref)
+ [`mousetrap.set_signal_shutdown_blocked!`](@ref)


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
+ [`mousetrap.get_child_x_alignment`](@ref)
+ [`mousetrap.get_child_y_alignment`](@ref)
+ [`mousetrap.get_ratio`](@ref)
+ [`mousetrap.remove_child!`](@ref)
+ [`mousetrap.set_child!`](@ref)
+ [`mousetrap.set_child_x_alignment!`](@ref)
+ [`mousetrap.set_child_y_alignment!`](@ref)
+ [`mousetrap.set_ratio!`](@ref)


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
+ [`mousetrap.clear!`](@ref)
+ [`mousetrap.get_homogeneous`](@ref)
+ [`mousetrap.get_n_items`](@ref)
+ [`mousetrap.get_orientation`](@ref)
+ [`mousetrap.get_spacing`](@ref)
+ [`mousetrap.insert_after!`](@ref)
+ [`mousetrap.push_back!`](@ref)
+ [`mousetrap.push_front!`](@ref)
+ [`mousetrap.remove!`](@ref)
+ [`mousetrap.set_homogeneous!`](@ref)
+ [`mousetrap.set_orientation!`](@ref)
+ [`mousetrap.set_spacing!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## Button
```@docs
Button
```
#### Functions that operate on this type:
+ [`mousetrap.get_has_frame`](@ref)
+ [`mousetrap.get_is_circular`](@ref)
+ [`mousetrap.remove_child!`](@ref)
+ [`mousetrap.set_action!`](@ref)
+ [`mousetrap.set_child!`](@ref)
+ [`mousetrap.set_has_frame!`](@ref)
+ [`mousetrap.set_icon!`](@ref)
+ [`mousetrap.set_is_circular!`](@ref)


+ [`mousetrap.connect_signal_activate!`](@ref)
+ [`mousetrap.disconnect_signal_activate!`](@ref)
+ [`mousetrap.emit_signal_activate`](@ref)
+ [`mousetrap.get_signal_activate_blocked`](@ref)
+ [`mousetrap.set_signal_activate_blocked!`](@ref)


+ [`mousetrap.connect_signal_clicked!`](@ref)
+ [`mousetrap.disconnect_signal_clicked!`](@ref)
+ [`mousetrap.emit_signal_clicked`](@ref)
+ [`mousetrap.get_signal_clicked_blocked`](@ref)
+ [`mousetrap.set_signal_clicked_blocked!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## CenterBox
```@docs
CenterBox
```
#### Functions that operate on this type:
+ [`mousetrap.get_orientation`](@ref)
+ [`mousetrap.remove_center_child!`](@ref)
+ [`mousetrap.remove_end_child!`](@ref)
+ [`mousetrap.remove_start_child!`](@ref)
+ [`mousetrap.set_center_child!`](@ref)
+ [`mousetrap.set_end_child!`](@ref)
+ [`mousetrap.set_orientation!`](@ref)
+ [`mousetrap.set_start_child!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## CheckButton
```@docs
CheckButton
```
#### Functions that operate on this type:
+ [`mousetrap.get_is_active`](@ref)
+ [`mousetrap.get_state`](@ref)
+ [`mousetrap.remove_child!`](@ref)
+ [`mousetrap.set_child!`](@ref)
+ [`mousetrap.set_is_active!`](@ref)
+ [`mousetrap.set_state!`](@ref)


+ [`mousetrap.connect_signal_activate!`](@ref)
+ [`mousetrap.disconnect_signal_activate!`](@ref)
+ [`mousetrap.emit_signal_activate`](@ref)
+ [`mousetrap.get_signal_activate_blocked`](@ref)
+ [`mousetrap.set_signal_activate_blocked!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_toggled!`](@ref)
+ [`mousetrap.disconnect_signal_toggled!`](@ref)
+ [`mousetrap.emit_signal_toggled`](@ref)
+ [`mousetrap.get_signal_toggled_blocked`](@ref)
+ [`mousetrap.set_signal_toggled_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## ClickEventController
```@docs
ClickEventController
```
#### Functions that operate on this type:


+ [`mousetrap.connect_signal_click_pressed!`](@ref)
+ [`mousetrap.connect_signal_click_released!`](@ref)
+ [`mousetrap.connect_signal_click_stopped!`](@ref)
+ [`mousetrap.disconnect_signal_click_pressed!`](@ref)
+ [`mousetrap.disconnect_signal_click_released!`](@ref)
+ [`mousetrap.disconnect_signal_click_stopped!`](@ref)
+ [`mousetrap.emit_signal_click_pressed`](@ref)
+ [`mousetrap.emit_signal_click_released`](@ref)
+ [`mousetrap.emit_signal_click_stopped`](@ref)
+ [`mousetrap.get_signal_click_pressed_blocked`](@ref)
+ [`mousetrap.get_signal_click_released_blocked`](@ref)
+ [`mousetrap.get_signal_click_stopped_blocked`](@ref)
+ [`mousetrap.set_signal_click_pressed_blocked!`](@ref)
+ [`mousetrap.set_signal_click_released_blocked!`](@ref)
+ [`mousetrap.set_signal_click_stopped_blocked!`](@ref)








---
## Clipboard
```@docs
Clipboard
```
#### Functions that operate on this type:
+ [`mousetrap.contains_file`](@ref)
+ [`mousetrap.contains_image`](@ref)
+ [`mousetrap.contains_string`](@ref)
+ [`mousetrap.get_image`](@ref)
+ [`mousetrap.get_is_local`](@ref)
+ [`mousetrap.get_string`](@ref)
+ [`mousetrap.set_file!`](@ref)
+ [`mousetrap.set_image!`](@ref)
+ [`mousetrap.set_string!`](@ref)


---
## Clock
```@docs
Clock
```
#### Functions that operate on this type:
+ [`mousetrap.elapsed`](@ref)
+ [`mousetrap.restart!`](@ref)


---
## ColorChooser
```@docs
ColorChooser
```
#### Functions that operate on this type:
+ [`mousetrap.get_color`](@ref)
+ [`mousetrap.get_is_modal`](@ref)
+ [`mousetrap.on_accept!`](@ref)
+ [`mousetrap.on_cancel!`](@ref)
+ [`mousetrap.present!`](@ref)
+ [`mousetrap.set_is_modal!`](@ref)


---
## ColumnView
```@docs
ColumnView
```
#### Functions that operate on this type:
+ [`mousetrap.get_column_at`](@ref)
+ [`mousetrap.get_column_with_title`](@ref)
+ [`mousetrap.get_enable_rubberband_selection`](@ref)
+ [`mousetrap.get_n_columns`](@ref)
+ [`mousetrap.get_n_rows`](@ref)
+ [`mousetrap.get_selection_model`](@ref)
+ [`mousetrap.get_show_column_separators`](@ref)
+ [`mousetrap.get_show_row_separators`](@ref)
+ [`mousetrap.get_single_click_activate`](@ref)
+ [`mousetrap.has_column_with_title`](@ref)
+ [`mousetrap.insert_column!`](@ref)
+ [`mousetrap.push_back_column!`](@ref)
+ [`mousetrap.push_back_row!`](@ref)
+ [`mousetrap.push_front_column!`](@ref)
+ [`mousetrap.push_front_row!`](@ref)
+ [`mousetrap.remove_column!`](@ref)
+ [`mousetrap.set_enable_rubberband_selection!`](@ref)
+ [`mousetrap.set_show_column_separators`](@ref)
+ [`mousetrap.set_show_row_separators`](@ref)
+ [`mousetrap.set_single_click_activate!`](@ref)
+ [`mousetrap.set_widget_at!`](@ref)


+ [`mousetrap.connect_signal_activate!`](@ref)
+ [`mousetrap.disconnect_signal_activate!`](@ref)
+ [`mousetrap.emit_signal_activate`](@ref)
+ [`mousetrap.get_signal_activate_blocked`](@ref)
+ [`mousetrap.set_signal_activate_blocked!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## ColumnViewColumn
```@docs
ColumnViewColumn
```
#### Functions that operate on this type:
+ [`mousetrap.get_fixed_width`](@ref)
+ [`mousetrap.get_is_resizable`](@ref)
+ [`mousetrap.get_is_visible`](@ref)
+ [`mousetrap.get_title`](@ref)
+ [`mousetrap.remove_column!`](@ref)
+ [`mousetrap.set_fixed_width!`](@ref)
+ [`mousetrap.set_header_menu!`](@ref)
+ [`mousetrap.set_is_resizable!`](@ref)
+ [`mousetrap.set_is_visible!`](@ref)
+ [`mousetrap.set_title!`](@ref)
+ [`mousetrap.set_widget_at!`](@ref)


---
## DragEventController
```@docs
DragEventController
```
#### Functions that operate on this type:
+ [`mousetrap.get_current_offset`](@ref)
+ [`mousetrap.get_start_position`](@ref)


+ [`mousetrap.connect_signal_drag!`](@ref)
+ [`mousetrap.connect_signal_drag_begin!`](@ref)
+ [`mousetrap.connect_signal_drag_end!`](@ref)
+ [`mousetrap.disconnect_signal_drag!`](@ref)
+ [`mousetrap.disconnect_signal_drag_begin!`](@ref)
+ [`mousetrap.disconnect_signal_drag_end!`](@ref)
+ [`mousetrap.emit_signal_drag`](@ref)
+ [`mousetrap.emit_signal_drag_begin`](@ref)
+ [`mousetrap.emit_signal_drag_end`](@ref)
+ [`mousetrap.get_signal_drag_begin_blocked`](@ref)
+ [`mousetrap.get_signal_drag_blocked`](@ref)
+ [`mousetrap.get_signal_drag_end_blocked`](@ref)
+ [`mousetrap.set_signal_drag_begin_blocked!`](@ref)
+ [`mousetrap.set_signal_drag_blocked!`](@ref)
+ [`mousetrap.set_signal_drag_end_blocked!`](@ref)






---
## DropDown
```@docs
DropDown
```
#### Functions that operate on this type:
+ [`mousetrap.get_always_show_arrow`](@ref)
+ [`mousetrap.get_item_at`](@ref)
+ [`mousetrap.get_selected`](@ref)
+ [`mousetrap.insert_at!`](@ref)
+ [`mousetrap.push_back!`](@ref)
+ [`mousetrap.push_front!`](@ref)
+ [`mousetrap.remove!`](@ref)
+ [`mousetrap.set_always_show_arrow!`](@ref)
+ [`mousetrap.set_selected!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## DropDownItemID
```@docs
DropDownItemID
```
#### Functions that operate on this type:
+ [`mousetrap.remove!`](@ref)
+ [`mousetrap.set_selected!`](@ref)


---
## Entry
```@docs
Entry
```
#### Functions that operate on this type:
+ [`mousetrap.get_has_frame`](@ref)
+ [`mousetrap.get_max_width_chars`](@ref)
+ [`mousetrap.get_text`](@ref)
+ [`mousetrap.get_text_visible`](@ref)
+ [`mousetrap.remove_primary_icon!`](@ref)
+ [`mousetrap.remove_secondary_icon!`](@ref)
+ [`mousetrap.set_has_frame!`](@ref)
+ [`mousetrap.set_max_width_chars!`](@ref)
+ [`mousetrap.set_primary_icon!`](@ref)
+ [`mousetrap.set_secondary_icon!`](@ref)
+ [`mousetrap.set_text!`](@ref)
+ [`mousetrap.set_text_visible!`](@ref)


+ [`mousetrap.connect_signal_activate!`](@ref)
+ [`mousetrap.disconnect_signal_activate!`](@ref)
+ [`mousetrap.emit_signal_activate`](@ref)
+ [`mousetrap.get_signal_activate_blocked`](@ref)
+ [`mousetrap.set_signal_activate_blocked!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_text_changed!`](@ref)
+ [`mousetrap.disconnect_signal_text_changed!`](@ref)
+ [`mousetrap.emit_signal_text_changed`](@ref)
+ [`mousetrap.get_signal_text_changed_blocked`](@ref)
+ [`mousetrap.set_signal_text_changed_blocked!`](@ref)




+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## EventController
```@docs
EventController
```
#### Functions that operate on this type:
+ [`mousetrap.add_controller!`](@ref)
+ [`mousetrap.get_propagation_phase`](@ref)
+ [`mousetrap.remove_controller!`](@ref)
+ [`mousetrap.set_propagation_phase!`](@ref)


---
## Expander
```@docs
Expander
```
#### Functions that operate on this type:
+ [`mousetrap.get_is_expanded`](@ref)
+ [`mousetrap.remove_child!`](@ref)
+ [`mousetrap.remove_label_widget!`](@ref)
+ [`mousetrap.set_child!`](@ref)
+ [`mousetrap.set_is_expanded!`](@ref)
+ [`mousetrap.set_label_widget!`](@ref)


+ [`mousetrap.connect_signal_activate!`](@ref)
+ [`mousetrap.disconnect_signal_activate!`](@ref)
+ [`mousetrap.emit_signal_activate`](@ref)
+ [`mousetrap.get_signal_activate_blocked`](@ref)
+ [`mousetrap.set_signal_activate_blocked!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## FileChooser
```@docs
FileChooser
```
#### Functions that operate on this type:
+ [`mousetrap.add_filter!`](@ref)
+ [`mousetrap.cancel!`](@ref)
+ [`mousetrap.clear_filters!`](@ref)
+ [`mousetrap.get_accept_label`](@ref)
+ [`mousetrap.get_file_chooser_action`](@ref)
+ [`mousetrap.get_is_modal`](@ref)
+ [`mousetrap.on_accept!`](@ref)
+ [`mousetrap.on_cancel!`](@ref)
+ [`mousetrap.present!`](@ref)
+ [`mousetrap.set_accept_label!`](@ref)
+ [`mousetrap.set_file_chooser_action!`](@ref)
+ [`mousetrap.set_initial_file!`](@ref)
+ [`mousetrap.set_initial_filter!`](@ref)
+ [`mousetrap.set_initial_folder!`](@ref)
+ [`mousetrap.set_initial_name!`](@ref)
+ [`mousetrap.set_is_modal!`](@ref)


---
## FileDescriptor
```@docs
FileDescriptor
```
#### Functions that operate on this type:
+ [`mousetrap.copy!`](@ref)
+ [`mousetrap.create_as_file_preview!`](@ref)
+ [`mousetrap.create_directory_at!`](@ref)
+ [`mousetrap.create_file_at!`](@ref)
+ [`mousetrap.create_from_path!`](@ref)
+ [`mousetrap.create_from_uri!`](@ref)
+ [`mousetrap.create_monitor`](@ref)
+ [`mousetrap.delete_at!`](@ref)
+ [`mousetrap.exists`](@ref)
+ [`mousetrap.get_children`](@ref)
+ [`mousetrap.get_content_type`](@ref)
+ [`mousetrap.get_file_extension`](@ref)
+ [`mousetrap.get_name`](@ref)
+ [`mousetrap.get_parent`](@ref)
+ [`mousetrap.get_path`](@ref)
+ [`mousetrap.get_path_relative_to`](@ref)
+ [`mousetrap.get_uri`](@ref)
+ [`mousetrap.is_executable`](@ref)
+ [`mousetrap.is_file`](@ref)
+ [`mousetrap.is_folder`](@ref)
+ [`mousetrap.is_symlink`](@ref)
+ [`mousetrap.move!`](@ref)
+ [`mousetrap.move_to_trash!`](@ref)
+ [`mousetrap.open_file`](@ref)
+ [`mousetrap.open_url`](@ref)
+ [`mousetrap.query_info`](@ref)
+ [`mousetrap.read_symlink`](@ref)
+ [`mousetrap.set_file!`](@ref)
+ [`mousetrap.set_initial_file!`](@ref)
+ [`mousetrap.set_initial_folder!`](@ref)
+ [`mousetrap.show_in_file_explorer`](@ref)


---
## FileFilter
```@docs
FileFilter
```
#### Functions that operate on this type:
+ [`mousetrap.add_allow_all_supported_image_formats!`](@ref)
+ [`mousetrap.add_allowed_mime_type!`](@ref)
+ [`mousetrap.add_allowed_pattern!`](@ref)
+ [`mousetrap.add_allowed_suffix!`](@ref)
+ [`mousetrap.add_filter!`](@ref)
+ [`mousetrap.get_name`](@ref)
+ [`mousetrap.set_initial_filter!`](@ref)


---
## FileMonitor
```@docs
FileMonitor
```
#### Functions that operate on this type:
+ [`mousetrap.cancel!`](@ref)
+ [`mousetrap.is_cancelled`](@ref)
+ [`mousetrap.on_file_changed!`](@ref)


---
## Fixed
```@docs
Fixed
```
#### Functions that operate on this type:
+ [`mousetrap.add_child!`](@ref)
+ [`mousetrap.get_child_position`](@ref)
+ [`mousetrap.remove_child!`](@ref)
+ [`mousetrap.set_child_position!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## FocusEventController
```@docs
FocusEventController
```
#### Functions that operate on this type:
+ [`mousetrap.self_is_focused`](@ref)
+ [`mousetrap.self_or_child_is_focused`](@ref)


+ [`mousetrap.connect_signal_focus_gained!`](@ref)
+ [`mousetrap.connect_signal_focus_lost!`](@ref)
+ [`mousetrap.disconnect_signal_focus_gained!`](@ref)
+ [`mousetrap.disconnect_signal_focus_lost!`](@ref)
+ [`mousetrap.emit_signal_focus_gained`](@ref)
+ [`mousetrap.emit_signal_focus_lost`](@ref)
+ [`mousetrap.get_signal_focus_gained_blocked`](@ref)
+ [`mousetrap.get_signal_focus_lost_blocked`](@ref)
+ [`mousetrap.set_signal_focus_gained_blocked!`](@ref)
+ [`mousetrap.set_signal_focus_lost_blocked!`](@ref)






---
## Frame
```@docs
Frame
```
#### Functions that operate on this type:
+ [`mousetrap.get_label_x_alignment`](@ref)
+ [`mousetrap.remove_child!`](@ref)
+ [`mousetrap.remove_label_widget!`](@ref)
+ [`mousetrap.set_child!`](@ref)
+ [`mousetrap.set_label_widget!`](@ref)
+ [`mousetrap.set_label_x_alignment!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## FrameClock
```@docs
FrameClock
```
#### Functions that operate on this type:
+ [`mousetrap.get_target_frame_duration`](@ref)
+ [`mousetrap.get_time_since_last_frame`](@ref)


+ [`mousetrap.connect_signal_paint!`](@ref)
+ [`mousetrap.disconnect_signal_paint!`](@ref)
+ [`mousetrap.emit_signal_paint`](@ref)
+ [`mousetrap.get_signal_paint_blocked`](@ref)
+ [`mousetrap.set_signal_paint_blocked!`](@ref)


+ [`mousetrap.connect_signal_update!`](@ref)
+ [`mousetrap.disconnect_signal_update!`](@ref)
+ [`mousetrap.emit_signal_update`](@ref)
+ [`mousetrap.get_signal_update_blocked`](@ref)
+ [`mousetrap.set_signal_update_blocked!`](@ref)


---
## GLTransform
```@docs
GLTransform
```
#### Functions that operate on this type:
+ [`mousetrap.apply_to`](@ref)
+ [`mousetrap.combine_with`](@ref)
+ [`mousetrap.reset!`](@ref)
+ [`mousetrap.rotate!`](@ref)
+ [`mousetrap.scale!`](@ref)
+ [`mousetrap.translate!`](@ref)


---
## Grid
```@docs
Grid
```
#### Functions that operate on this type:
+ [`mousetrap.get_column_spacing`](@ref)
+ [`mousetrap.get_columns_homogeneous`](@ref)
+ [`mousetrap.get_orientation`](@ref)
+ [`mousetrap.get_position`](@ref)
+ [`mousetrap.get_row_spacing`](@ref)
+ [`mousetrap.get_rows_homogeneous`](@ref)
+ [`mousetrap.get_size`](@ref)
+ [`mousetrap.insert_at!`](@ref)
+ [`mousetrap.insert_column_at!`](@ref)
+ [`mousetrap.insert_next_to!`](@ref)
+ [`mousetrap.insert_row_at!`](@ref)
+ [`mousetrap.remove!`](@ref)
+ [`mousetrap.remove_column_at!`](@ref)
+ [`mousetrap.remove_row_at!`](@ref)
+ [`mousetrap.set_column_spacing!`](@ref)
+ [`mousetrap.set_columns_homogeneous!`](@ref)
+ [`mousetrap.set_orientation!`](@ref)
+ [`mousetrap.set_row_spacing!`](@ref)
+ [`mousetrap.set_rows_homogeneous!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## GridView
```@docs
GridView
```
#### Functions that operate on this type:
+ [`mousetrap.clear!`](@ref)
+ [`mousetrap.find`](@ref)
+ [`mousetrap.get_enable_rubberband_selection`](@ref)
+ [`mousetrap.get_max_n_columns`](@ref)
+ [`mousetrap.get_min_n_columns`](@ref)
+ [`mousetrap.get_n_items`](@ref)
+ [`mousetrap.get_orientation`](@ref)
+ [`mousetrap.get_selection_model`](@ref)
+ [`mousetrap.get_single_click_activate`](@ref)
+ [`mousetrap.insert_at!`](@ref)
+ [`mousetrap.push_back!`](@ref)
+ [`mousetrap.push_front!`](@ref)
+ [`mousetrap.remove!`](@ref)
+ [`mousetrap.set_enable_rubberband_selection!`](@ref)
+ [`mousetrap.set_max_n_columns!`](@ref)
+ [`mousetrap.set_min_n_columns!`](@ref)
+ [`mousetrap.set_orientation!`](@ref)
+ [`mousetrap.set_single_click_activate!`](@ref)


+ [`mousetrap.connect_signal_activate_item!`](@ref)
+ [`mousetrap.disconnect_signal_activate_item!`](@ref)
+ [`mousetrap.emit_signal_activate_item`](@ref)
+ [`mousetrap.get_signal_activate_item_blocked`](@ref)
+ [`mousetrap.set_signal_activate_item_blocked!`](@ref)




+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


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
+ [`mousetrap.hsva_to_rgba`](@ref)
+ [`mousetrap.set_color!`](@ref)


---
## HeaderBar
```@docs
HeaderBar
```
#### Functions that operate on this type:
+ [`mousetrap.get_layout`](@ref)
+ [`mousetrap.get_show_title_buttons`](@ref)
+ [`mousetrap.push_back!`](@ref)
+ [`mousetrap.push_front!`](@ref)
+ [`mousetrap.remove!`](@ref)
+ [`mousetrap.remove_title_widget!`](@ref)
+ [`mousetrap.set_layout!`](@ref)
+ [`mousetrap.set_show_title_buttons!`](@ref)
+ [`mousetrap.set_title_widget!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## Icon
```@docs
Icon
```
#### Functions that operate on this type:
+ [`mousetrap.add_icon!`](@ref)
+ [`mousetrap.create_from_file!`](@ref)
+ [`mousetrap.create_from_icon!`](@ref)
+ [`mousetrap.create_from_theme!`](@ref)
+ [`mousetrap.get_name`](@ref)
+ [`mousetrap.get_size`](@ref)
+ [`mousetrap.has_icon`](@ref)
+ [`mousetrap.set_icon!`](@ref)
+ [`mousetrap.set_primary_icon!`](@ref)
+ [`mousetrap.set_secondary_icon!`](@ref)


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
+ [`mousetrap.add_resource_path!`](@ref)
+ [`mousetrap.create_from_theme!`](@ref)
+ [`mousetrap.get_icon_names`](@ref)
+ [`mousetrap.has_icon`](@ref)
+ [`mousetrap.set_resource_path!`](@ref)


---
## Image
```@docs
Image
```
#### Functions that operate on this type:
+ [`mousetrap.as_cropped`](@ref)
+ [`mousetrap.as_flipped`](@ref)
+ [`mousetrap.as_scaled`](@ref)
+ [`mousetrap.create!`](@ref)
+ [`mousetrap.create_from_file!`](@ref)
+ [`mousetrap.create_from_image!`](@ref)
+ [`mousetrap.get_n_pixels`](@ref)
+ [`mousetrap.get_pixel`](@ref)
+ [`mousetrap.get_size`](@ref)
+ [`mousetrap.save_to_file`](@ref)
+ [`mousetrap.set_cursor_from_image!`](@ref)
+ [`mousetrap.set_image!`](@ref)
+ [`mousetrap.set_pixel!`](@ref)


---
## ImageDisplay
```@docs
ImageDisplay
```
#### Functions that operate on this type:
+ [`mousetrap.clear!`](@ref)
+ [`mousetrap.create_as_file_preview!`](@ref)
+ [`mousetrap.create_from_file!`](@ref)
+ [`mousetrap.create_from_icon!`](@ref)
+ [`mousetrap.create_from_image!`](@ref)
+ [`mousetrap.get_scale`](@ref)
+ [`mousetrap.get_size`](@ref)
+ [`mousetrap.set_scale!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## KeyCode
```@docs
KeyCode
```
#### Functions that operate on this type:


+ [`mousetrap.emit_signal_key_pressed`](@ref)
+ [`mousetrap.emit_signal_key_released`](@ref)


---
## KeyEventController
```@docs
KeyEventController
```
#### Functions that operate on this type:
+ [`mousetrap.should_shortcut_trigger_trigger`](@ref)


+ [`mousetrap.connect_signal_key_pressed!`](@ref)
+ [`mousetrap.connect_signal_key_released!`](@ref)
+ [`mousetrap.disconnect_signal_key_pressed!`](@ref)
+ [`mousetrap.disconnect_signal_key_released!`](@ref)
+ [`mousetrap.emit_signal_key_pressed`](@ref)
+ [`mousetrap.emit_signal_key_released`](@ref)
+ [`mousetrap.get_signal_key_pressed_blocked`](@ref)
+ [`mousetrap.get_signal_key_released_blocked`](@ref)
+ [`mousetrap.set_signal_key_pressed_blocked!`](@ref)
+ [`mousetrap.set_signal_key_released_blocked!`](@ref)






+ [`mousetrap.connect_signal_modifiers_changed!`](@ref)
+ [`mousetrap.disconnect_signal_modifiers_changed!`](@ref)
+ [`mousetrap.emit_signal_modifiers_changed`](@ref)
+ [`mousetrap.get_signal_modifiers_changed_blocked`](@ref)
+ [`mousetrap.set_signal_modifiers_changed_blocked!`](@ref)




---
## KeyFile
```@docs
KeyFile
```
#### Functions that operate on this type:
+ [`mousetrap.as_string`](@ref)
+ [`mousetrap.create_from_file!`](@ref)
+ [`mousetrap.create_from_string!`](@ref)
+ [`mousetrap.get_comment_above`](@ref)
+ [`mousetrap.get_groups`](@ref)
+ [`mousetrap.get_keys`](@ref)
+ [`mousetrap.get_value`](@ref)
+ [`mousetrap.has_group`](@ref)
+ [`mousetrap.has_key`](@ref)
+ [`mousetrap.save_to_file`](@ref)
+ [`mousetrap.set_comment_above!`](@ref)
+ [`mousetrap.set_value!`](@ref)


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
+ [`mousetrap.get_ellipsize_mode`](@ref)
+ [`mousetrap.get_is_selectable`](@ref)
+ [`mousetrap.get_justify_mode`](@ref)
+ [`mousetrap.get_max_width_chars`](@ref)
+ [`mousetrap.get_text`](@ref)
+ [`mousetrap.get_use_markup`](@ref)
+ [`mousetrap.get_wrap_mode`](@ref)
+ [`mousetrap.get_x_alignment`](@ref)
+ [`mousetrap.get_y_alignment`](@ref)
+ [`mousetrap.set_ellipsize_mode!`](@ref)
+ [`mousetrap.set_is_selectable!`](@ref)
+ [`mousetrap.set_justify_mode!`](@ref)
+ [`mousetrap.set_max_width_chars!`](@ref)
+ [`mousetrap.set_text!`](@ref)
+ [`mousetrap.set_use_markup!`](@ref)
+ [`mousetrap.set_wrap_mode!`](@ref)
+ [`mousetrap.set_x_alignment!`](@ref)
+ [`mousetrap.set_y_alignment!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## LevelBar
```@docs
LevelBar
```
#### Functions that operate on this type:
+ [`mousetrap.add_marker!`](@ref)
+ [`mousetrap.get_inverted`](@ref)
+ [`mousetrap.get_max_value`](@ref)
+ [`mousetrap.get_min_value`](@ref)
+ [`mousetrap.get_mode`](@ref)
+ [`mousetrap.get_orientation`](@ref)
+ [`mousetrap.get_value`](@ref)
+ [`mousetrap.remove_marker!`](@ref)
+ [`mousetrap.set_inverted!`](@ref)
+ [`mousetrap.set_max_value!`](@ref)
+ [`mousetrap.set_min_value!`](@ref)
+ [`mousetrap.set_mode!`](@ref)
+ [`mousetrap.set_orientation!`](@ref)
+ [`mousetrap.set_value!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## ListView
```@docs
ListView
```
#### Functions that operate on this type:
+ [`mousetrap.clear!`](@ref)
+ [`mousetrap.find`](@ref)
+ [`mousetrap.get_enable_rubberband_selection`](@ref)
+ [`mousetrap.get_n_items`](@ref)
+ [`mousetrap.get_orientation`](@ref)
+ [`mousetrap.get_selection_model`](@ref)
+ [`mousetrap.get_show_separators`](@ref)
+ [`mousetrap.get_single_click_activate`](@ref)
+ [`mousetrap.insert_at!`](@ref)
+ [`mousetrap.push_back!`](@ref)
+ [`mousetrap.push_front!`](@ref)
+ [`mousetrap.remove!`](@ref)
+ [`mousetrap.set_enable_rubberband_selection!`](@ref)
+ [`mousetrap.set_orientation!`](@ref)
+ [`mousetrap.set_show_separators!`](@ref)
+ [`mousetrap.set_single_click_activate!`](@ref)
+ [`mousetrap.set_widget_at!`](@ref)


+ [`mousetrap.connect_signal_activate_item!`](@ref)
+ [`mousetrap.disconnect_signal_activate_item!`](@ref)
+ [`mousetrap.emit_signal_activate_item`](@ref)
+ [`mousetrap.get_signal_activate_item_blocked`](@ref)
+ [`mousetrap.set_signal_activate_item_blocked!`](@ref)




+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## ListViewIterator
```@docs
ListViewIterator
```
#### Functions that operate on this type:
+ [`mousetrap.clear!`](@ref)


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
+ [`mousetrap.get_delay_factor`](@ref)
+ [`mousetrap.set_delay_factor!`](@ref)


+ [`mousetrap.connect_signal_press_cancelled!`](@ref)
+ [`mousetrap.connect_signal_pressed!`](@ref)
+ [`mousetrap.disconnect_signal_press_cancelled!`](@ref)
+ [`mousetrap.disconnect_signal_pressed!`](@ref)
+ [`mousetrap.emit_signal_press_cancelled`](@ref)
+ [`mousetrap.emit_signal_pressed`](@ref)
+ [`mousetrap.get_signal_press_cancelled_blocked`](@ref)
+ [`mousetrap.get_signal_pressed_blocked`](@ref)
+ [`mousetrap.set_signal_press_cancelled_blocked!`](@ref)
+ [`mousetrap.set_signal_pressed_blocked!`](@ref)






---
## MenuBar
```@docs
MenuBar
```
#### Functions that operate on this type:


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## MenuModel
```@docs
MenuModel
```
#### Functions that operate on this type:
+ [`mousetrap.add_action!`](@ref)
+ [`mousetrap.add_icon!`](@ref)
+ [`mousetrap.add_section!`](@ref)
+ [`mousetrap.add_submenu!`](@ref)
+ [`mousetrap.add_widget!`](@ref)
+ [`mousetrap.set_header_menu!`](@ref)


+ [`mousetrap.connect_signal_items_changed!`](@ref)
+ [`mousetrap.disconnect_signal_items_changed!`](@ref)
+ [`mousetrap.emit_signal_items_changed`](@ref)
+ [`mousetrap.get_signal_items_changed_blocked`](@ref)
+ [`mousetrap.set_signal_items_changed_blocked!`](@ref)




---
## ModifierState
```@docs
ModifierState
```
#### Functions that operate on this type:
+ [`mousetrap.alt_pressed`](@ref)
+ [`mousetrap.control_pressed`](@ref)
+ [`mousetrap.mouse_button_01_pressed`](@ref)
+ [`mousetrap.mouse_button_02_pressed`](@ref)
+ [`mousetrap.shift_pressed`](@ref)


+ [`mousetrap.emit_signal_key_pressed`](@ref)
+ [`mousetrap.emit_signal_key_released`](@ref)


+ [`mousetrap.emit_signal_modifiers_changed`](@ref)


---
## MotionEventController
```@docs
MotionEventController
```
#### Functions that operate on this type:


+ [`mousetrap.connect_signal_motion!`](@ref)
+ [`mousetrap.connect_signal_motion_enter!`](@ref)
+ [`mousetrap.connect_signal_motion_leave!`](@ref)
+ [`mousetrap.disconnect_signal_motion!`](@ref)
+ [`mousetrap.disconnect_signal_motion_enter!`](@ref)
+ [`mousetrap.disconnect_signal_motion_leave!`](@ref)
+ [`mousetrap.emit_signal_motion`](@ref)
+ [`mousetrap.emit_signal_motion_enter`](@ref)
+ [`mousetrap.emit_signal_motion_leave`](@ref)
+ [`mousetrap.get_signal_motion_blocked`](@ref)
+ [`mousetrap.get_signal_motion_enter_blocked`](@ref)
+ [`mousetrap.get_signal_motion_leave_blocked`](@ref)
+ [`mousetrap.set_signal_motion_blocked!`](@ref)
+ [`mousetrap.set_signal_motion_enter_blocked!`](@ref)
+ [`mousetrap.set_signal_motion_leave_blocked!`](@ref)






---
## Notebook
```@docs
Notebook
```
#### Functions that operate on this type:
+ [`mousetrap.get_current_page`](@ref)
+ [`mousetrap.get_has_border`](@ref)
+ [`mousetrap.get_is_scrollable`](@ref)
+ [`mousetrap.get_n_pages`](@ref)
+ [`mousetrap.get_quick_change_menu_enabled`](@ref)
+ [`mousetrap.get_tab_position`](@ref)
+ [`mousetrap.get_tabs_reorderable`](@ref)
+ [`mousetrap.get_tabs_visible`](@ref)
+ [`mousetrap.goto_page!`](@ref)
+ [`mousetrap.insert_at!`](@ref)
+ [`mousetrap.move_page_to!`](@ref)
+ [`mousetrap.next_page!`](@ref)
+ [`mousetrap.previous_page!`](@ref)
+ [`mousetrap.push_back!`](@ref)
+ [`mousetrap.push_front!`](@ref)
+ [`mousetrap.remove!`](@ref)
+ [`mousetrap.set_has_border!`](@ref)
+ [`mousetrap.set_is_scrollable!`](@ref)
+ [`mousetrap.set_quick_change_menu_enabled!`](@ref)
+ [`mousetrap.set_tab_position!`](@ref)
+ [`mousetrap.set_tabs_reorderable!`](@ref)
+ [`mousetrap.set_tabs_visible!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_page_added!`](@ref)
+ [`mousetrap.connect_signal_page_removed!`](@ref)
+ [`mousetrap.connect_signal_page_reordered!`](@ref)
+ [`mousetrap.connect_signal_page_selection_changed!`](@ref)
+ [`mousetrap.disconnect_signal_page_added!`](@ref)
+ [`mousetrap.disconnect_signal_page_removed!`](@ref)
+ [`mousetrap.disconnect_signal_page_reordered!`](@ref)
+ [`mousetrap.disconnect_signal_page_selection_changed!`](@ref)
+ [`mousetrap.emit_signal_page_added`](@ref)
+ [`mousetrap.emit_signal_page_removed`](@ref)
+ [`mousetrap.emit_signal_page_reordered`](@ref)
+ [`mousetrap.emit_signal_page_selection_changed`](@ref)
+ [`mousetrap.get_signal_page_added_blocked`](@ref)
+ [`mousetrap.get_signal_page_removed_blocked`](@ref)
+ [`mousetrap.get_signal_page_reordered_blocked`](@ref)
+ [`mousetrap.get_signal_page_selection_changed_blocked`](@ref)
+ [`mousetrap.set_signal_page_added_blocked!`](@ref)
+ [`mousetrap.set_signal_page_removed_blocked!`](@ref)
+ [`mousetrap.set_signal_page_reordered_blocked!`](@ref)
+ [`mousetrap.set_signal_page_selection_changed_blocked!`](@ref)












+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## Overlay
```@docs
Overlay
```
#### Functions that operate on this type:
+ [`mousetrap.add_overlay!`](@ref)
+ [`mousetrap.remove_child!`](@ref)
+ [`mousetrap.remove_overlay!`](@ref)
+ [`mousetrap.set_child!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## PanEventController
```@docs
PanEventController
```
#### Functions that operate on this type:
+ [`mousetrap.get_orientation`](@ref)
+ [`mousetrap.set_orientation!`](@ref)


+ [`mousetrap.connect_signal_pan!`](@ref)
+ [`mousetrap.disconnect_signal_pan!`](@ref)
+ [`mousetrap.emit_signal_pan`](@ref)
+ [`mousetrap.get_signal_pan_blocked`](@ref)
+ [`mousetrap.set_signal_pan_blocked!`](@ref)


---
## Paned
```@docs
Paned
```
#### Functions that operate on this type:
+ [`mousetrap.get_end_child_resizable`](@ref)
+ [`mousetrap.get_end_child_shrinkable`](@ref)
+ [`mousetrap.get_has_wide_handle`](@ref)
+ [`mousetrap.get_orientation`](@ref)
+ [`mousetrap.get_position`](@ref)
+ [`mousetrap.get_start_child_resizable`](@ref)
+ [`mousetrap.get_start_child_shrinkable`](@ref)
+ [`mousetrap.remove_end_child!`](@ref)
+ [`mousetrap.remove_start_child!`](@ref)
+ [`mousetrap.set_end_child!`](@ref)
+ [`mousetrap.set_end_child_resizable!`](@ref)
+ [`mousetrap.set_end_child_shrinkable!`](@ref)
+ [`mousetrap.set_has_wide_handle!`](@ref)
+ [`mousetrap.set_orientation!`](@ref)
+ [`mousetrap.set_position!`](@ref)
+ [`mousetrap.set_start_child!`](@ref)
+ [`mousetrap.set_start_child_resizable!`](@ref)
+ [`mousetrap.set_start_child_shrinkable!`](@ref)


---
## PinchZoomEventController
```@docs
PinchZoomEventController
```
#### Functions that operate on this type:
+ [`mousetrap.get_scale_delta`](@ref)


+ [`mousetrap.connect_signal_scale_changed!`](@ref)
+ [`mousetrap.disconnect_signal_scale_changed!`](@ref)
+ [`mousetrap.emit_signal_scale_changed`](@ref)
+ [`mousetrap.get_signal_scale_changed_blocked`](@ref)
+ [`mousetrap.set_signal_scale_changed_blocked!`](@ref)




---
## Popover
```@docs
Popover
```
#### Functions that operate on this type:
+ [`mousetrap.get_autohide`](@ref)
+ [`mousetrap.get_has_base_arrow`](@ref)
+ [`mousetrap.get_relative_position`](@ref)
+ [`mousetrap.popdown!`](@ref)
+ [`mousetrap.popup!`](@ref)
+ [`mousetrap.remove_child!`](@ref)
+ [`mousetrap.set_autohide!`](@ref)
+ [`mousetrap.set_child!`](@ref)
+ [`mousetrap.set_has_base_arrow!`](@ref)
+ [`mousetrap.set_popover!`](@ref)
+ [`mousetrap.set_relative_position!`](@ref)


+ [`mousetrap.connect_signal_closed!`](@ref)
+ [`mousetrap.disconnect_signal_closed!`](@ref)
+ [`mousetrap.emit_signal_closed`](@ref)
+ [`mousetrap.get_signal_closed_blocked`](@ref)
+ [`mousetrap.set_signal_closed_blocked!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## PopoverButton
```@docs
PopoverButton
```
#### Functions that operate on this type:
+ [`mousetrap.get_always_show_arrow`](@ref)
+ [`mousetrap.get_has_frame`](@ref)
+ [`mousetrap.get_is_circular`](@ref)
+ [`mousetrap.get_relative_position`](@ref)
+ [`mousetrap.popdown!`](@ref)
+ [`mousetrap.popup!`](@ref)
+ [`mousetrap.remove_child!`](@ref)
+ [`mousetrap.remove_popover!`](@ref)
+ [`mousetrap.set_always_show_arrow!`](@ref)
+ [`mousetrap.set_child!`](@ref)
+ [`mousetrap.set_has_frame!`](@ref)
+ [`mousetrap.set_is_circular!`](@ref)
+ [`mousetrap.set_popover!`](@ref)
+ [`mousetrap.set_popover_menu!`](@ref)
+ [`mousetrap.set_relative_position!`](@ref)


+ [`mousetrap.connect_signal_activate!`](@ref)
+ [`mousetrap.disconnect_signal_activate!`](@ref)
+ [`mousetrap.emit_signal_activate`](@ref)
+ [`mousetrap.get_signal_activate_blocked`](@ref)
+ [`mousetrap.set_signal_activate_blocked!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## PopoverMenu
```@docs
PopoverMenu
```
#### Functions that operate on this type:
+ [`mousetrap.set_popover_menu!`](@ref)


+ [`mousetrap.connect_signal_closed!`](@ref)
+ [`mousetrap.disconnect_signal_closed!`](@ref)
+ [`mousetrap.emit_signal_closed`](@ref)
+ [`mousetrap.get_signal_closed_blocked`](@ref)
+ [`mousetrap.set_signal_closed_blocked!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## ProgressBar
```@docs
ProgressBar
```
#### Functions that operate on this type:
+ [`mousetrap.get_fraction`](@ref)
+ [`mousetrap.get_is_inverted`](@ref)
+ [`mousetrap.get_orientation`](@ref)
+ [`mousetrap.get_show_text`](@ref)
+ [`mousetrap.get_text`](@ref)
+ [`mousetrap.pulse`](@ref)
+ [`mousetrap.set_fraction!`](@ref)
+ [`mousetrap.set_is_inverted!`](@ref)
+ [`mousetrap.set_orientation!`](@ref)
+ [`mousetrap.set_show_text!`](@ref)
+ [`mousetrap.set_text!`](@ref)


---
## RGBA
```@docs
RGBA
```
#### Functions that operate on this type:
+ [`mousetrap.rgba_to_hsva`](@ref)
+ [`mousetrap.rgba_to_html_code`](@ref)
+ [`mousetrap.set_color!`](@ref)


---
## RenderArea
```@docs
RenderArea
```
#### Functions that operate on this type:
+ [`mousetrap.add_render_task!`](@ref)
+ [`mousetrap.clear`](@ref)
+ [`mousetrap.clear_render_tasks!`](@ref)
+ [`mousetrap.flush`](@ref)
+ [`mousetrap.from_gl_coordinates`](@ref)
+ [`mousetrap.make_current`](@ref)
+ [`mousetrap.queue_render`](@ref)
+ [`mousetrap.render_render_tasks`](@ref)
+ [`mousetrap.to_gl_coordinates`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_render!`](@ref)
+ [`mousetrap.disconnect_signal_render!`](@ref)
+ [`mousetrap.emit_signal_render`](@ref)
+ [`mousetrap.get_signal_render_blocked`](@ref)
+ [`mousetrap.set_signal_render_blocked!`](@ref)


+ [`mousetrap.connect_signal_resize!`](@ref)
+ [`mousetrap.disconnect_signal_resize!`](@ref)
+ [`mousetrap.emit_signal_resize`](@ref)
+ [`mousetrap.get_signal_resize_blocked`](@ref)
+ [`mousetrap.set_signal_resize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## RenderTask
```@docs
RenderTask
```
#### Functions that operate on this type:
+ [`mousetrap.add_render_task!`](@ref)
+ [`mousetrap.get_uniform_float`](@ref)
+ [`mousetrap.get_uniform_hsva`](@ref)
+ [`mousetrap.get_uniform_int`](@ref)
+ [`mousetrap.get_uniform_rgba`](@ref)
+ [`mousetrap.get_uniform_transform`](@ref)
+ [`mousetrap.get_uniform_uint`](@ref)
+ [`mousetrap.get_uniform_vec2`](@ref)
+ [`mousetrap.get_uniform_vec3`](@ref)
+ [`mousetrap.get_uniform_vec4`](@ref)
+ [`mousetrap.render`](@ref)
+ [`mousetrap.set_uniform_float!`](@ref)
+ [`mousetrap.set_uniform_hsva!`](@ref)
+ [`mousetrap.set_uniform_int!`](@ref)
+ [`mousetrap.set_uniform_rgba!`](@ref)
+ [`mousetrap.set_uniform_transform!`](@ref)
+ [`mousetrap.set_uniform_uint!`](@ref)
+ [`mousetrap.set_uniform_vec2!`](@ref)
+ [`mousetrap.set_uniform_vec3!`](@ref)
+ [`mousetrap.set_uniform_vec4!`](@ref)


---
## RenderTexture
```@docs
RenderTexture
```
#### Functions that operate on this type:
+ [`mousetrap.bind_as_render_target`](@ref)
+ [`mousetrap.unbind_as_render_target`](@ref)


---
## Revealer
```@docs
Revealer
```
#### Functions that operate on this type:
+ [`mousetrap.get_is_revealed`](@ref)
+ [`mousetrap.get_transition_duration`](@ref)
+ [`mousetrap.get_transition_type`](@ref)
+ [`mousetrap.remove_child!`](@ref)
+ [`mousetrap.set_child!`](@ref)
+ [`mousetrap.set_is_revealed!`](@ref)
+ [`mousetrap.set_transition_duration!`](@ref)
+ [`mousetrap.set_transition_type!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_revealed!`](@ref)
+ [`mousetrap.disconnect_signal_revealed!`](@ref)
+ [`mousetrap.emit_signal_revealed`](@ref)
+ [`mousetrap.get_signal_revealed_blocked`](@ref)
+ [`mousetrap.set_signal_revealed_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## RotateEventController
```@docs
RotateEventController
```
#### Functions that operate on this type:
+ [`mousetrap.get_angle_delta`](@ref)


+ [`mousetrap.connect_signal_rotation_changed!`](@ref)
+ [`mousetrap.disconnect_signal_rotation_changed!`](@ref)
+ [`mousetrap.emit_signal_rotation_changed`](@ref)
+ [`mousetrap.get_signal_rotation_changed_blocked`](@ref)
+ [`mousetrap.set_signal_rotation_changed_blocked!`](@ref)




---
## Scale
```@docs
Scale
```
#### Functions that operate on this type:
+ [`mousetrap.add_mark!`](@ref)
+ [`mousetrap.clear_marks!`](@ref)
+ [`mousetrap.get_adjustment`](@ref)
+ [`mousetrap.get_has_origin`](@ref)
+ [`mousetrap.get_lower`](@ref)
+ [`mousetrap.get_orientation`](@ref)
+ [`mousetrap.get_should_draw_value`](@ref)
+ [`mousetrap.get_step_increment`](@ref)
+ [`mousetrap.get_upper`](@ref)
+ [`mousetrap.get_value`](@ref)
+ [`mousetrap.set_has_origin!`](@ref)
+ [`mousetrap.set_lower!`](@ref)
+ [`mousetrap.set_orientation!`](@ref)
+ [`mousetrap.set_should_draw_value!`](@ref)
+ [`mousetrap.set_step_increment!`](@ref)
+ [`mousetrap.set_upper!`](@ref)
+ [`mousetrap.set_value!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


+ [`mousetrap.connect_signal_value_changed!`](@ref)
+ [`mousetrap.disconnect_signal_value_changed!`](@ref)
+ [`mousetrap.emit_signal_value_changed`](@ref)
+ [`mousetrap.get_signal_value_changed_blocked`](@ref)
+ [`mousetrap.set_signal_value_changed_blocked!`](@ref)




---
## ScrollEventController
```@docs
ScrollEventController
```
#### Functions that operate on this type:


+ [`mousetrap.connect_signal_kinetic_scroll_decelerate!`](@ref)
+ [`mousetrap.disconnect_signal_kinetic_scroll_decelerate!`](@ref)
+ [`mousetrap.emit_signal_kinetic_scroll_decelerate`](@ref)
+ [`mousetrap.get_signal_kinetic_scroll_decelerate_blocked`](@ref)
+ [`mousetrap.set_signal_kinetic_scroll_decelerate_blocked!`](@ref)




+ [`mousetrap.connect_signal_scroll!`](@ref)
+ [`mousetrap.connect_signal_scroll_begin!`](@ref)
+ [`mousetrap.connect_signal_scroll_end!`](@ref)
+ [`mousetrap.disconnect_signal_scroll!`](@ref)
+ [`mousetrap.disconnect_signal_scroll_begin!`](@ref)
+ [`mousetrap.disconnect_signal_scroll_end!`](@ref)
+ [`mousetrap.emit_signal_scroll`](@ref)
+ [`mousetrap.emit_signal_scroll_begin`](@ref)
+ [`mousetrap.emit_signal_scroll_end`](@ref)
+ [`mousetrap.get_signal_scroll_begin_blocked`](@ref)
+ [`mousetrap.get_signal_scroll_blocked`](@ref)
+ [`mousetrap.get_signal_scroll_end_blocked`](@ref)
+ [`mousetrap.set_signal_scroll_begin_blocked!`](@ref)
+ [`mousetrap.set_signal_scroll_blocked!`](@ref)
+ [`mousetrap.set_signal_scroll_end_blocked!`](@ref)






---
## Scrollbar
```@docs
Scrollbar
```
#### Functions that operate on this type:
+ [`mousetrap.get_adjustment`](@ref)
+ [`mousetrap.get_orientation`](@ref)
+ [`mousetrap.set_orientation!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## SelectionModel
```@docs
SelectionModel
```
#### Functions that operate on this type:
+ [`mousetrap.get_n_items`](@ref)
+ [`mousetrap.get_selection`](@ref)
+ [`mousetrap.get_selection_mode`](@ref)
+ [`mousetrap.select!`](@ref)
+ [`mousetrap.select_all!`](@ref)
+ [`mousetrap.unselect!`](@ref)
+ [`mousetrap.unselect_all!`](@ref)


+ [`mousetrap.connect_signal_selection_changed!`](@ref)
+ [`mousetrap.disconnect_signal_selection_changed!`](@ref)
+ [`mousetrap.emit_signal_selection_changed`](@ref)
+ [`mousetrap.get_signal_selection_changed_blocked`](@ref)
+ [`mousetrap.set_signal_selection_changed_blocked!`](@ref)




---
## Separator
```@docs
Separator
```
#### Functions that operate on this type:
+ [`mousetrap.get_orientation`](@ref)
+ [`mousetrap.set_orientation!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## Shader
```@docs
Shader
```
#### Functions that operate on this type:
+ [`mousetrap.create_from_file!`](@ref)
+ [`mousetrap.create_from_string!`](@ref)
+ [`mousetrap.get_fragment_shader_id`](@ref)
+ [`mousetrap.get_program_id`](@ref)
+ [`mousetrap.get_uniform_location`](@ref)
+ [`mousetrap.get_vertex_shader_id`](@ref)
+ [`mousetrap.render`](@ref)
+ [`mousetrap.set_uniform_float!`](@ref)
+ [`mousetrap.set_uniform_int!`](@ref)
+ [`mousetrap.set_uniform_transform!`](@ref)
+ [`mousetrap.set_uniform_uint!`](@ref)
+ [`mousetrap.set_uniform_vec2!`](@ref)
+ [`mousetrap.set_uniform_vec3!`](@ref)
+ [`mousetrap.set_uniform_vec4!`](@ref)


---
## Shape
```@docs
Shape
```
#### Functions that operate on this type:
+ [`mousetrap.Outline`](@ref)
+ [`mousetrap.as_circle!`](@ref)
+ [`mousetrap.as_circular_ring!`](@ref)
+ [`mousetrap.as_ellipse!`](@ref)
+ [`mousetrap.as_elliptical_ring!`](@ref)
+ [`mousetrap.as_line!`](@ref)
+ [`mousetrap.as_line_strip!`](@ref)
+ [`mousetrap.as_lines!`](@ref)
+ [`mousetrap.as_outline!`](@ref)
+ [`mousetrap.as_point!`](@ref)
+ [`mousetrap.as_points!`](@ref)
+ [`mousetrap.as_polygon!`](@ref)
+ [`mousetrap.as_rectangle!`](@ref)
+ [`mousetrap.as_rectangular_frame!`](@ref)
+ [`mousetrap.as_triangle!`](@ref)
+ [`mousetrap.as_wireframe!`](@ref)
+ [`mousetrap.get_bounding_box`](@ref)
+ [`mousetrap.get_centroid`](@ref)
+ [`mousetrap.get_is_visible`](@ref)
+ [`mousetrap.get_n_vertices`](@ref)
+ [`mousetrap.get_native_handle`](@ref)
+ [`mousetrap.get_size`](@ref)
+ [`mousetrap.get_top_left`](@ref)
+ [`mousetrap.get_vertex_color`](@ref)
+ [`mousetrap.get_vertex_position`](@ref)
+ [`mousetrap.get_vertex_texture_coordinate`](@ref)
+ [`mousetrap.render`](@ref)
+ [`mousetrap.rotate!`](@ref)
+ [`mousetrap.set_centroid!`](@ref)
+ [`mousetrap.set_color!`](@ref)
+ [`mousetrap.set_is_visible!`](@ref)
+ [`mousetrap.set_texture!`](@ref)
+ [`mousetrap.set_top_left!`](@ref)
+ [`mousetrap.set_vertex_color!`](@ref)
+ [`mousetrap.set_vertex_position!`](@ref)
+ [`mousetrap.set_vertex_texture_coordinate!`](@ref)


---
## ShortcutEventController
```@docs
ShortcutEventController
```
#### Functions that operate on this type:
+ [`mousetrap.add_action!`](@ref)
+ [`mousetrap.get_scope`](@ref)
+ [`mousetrap.remove_action!`](@ref)
+ [`mousetrap.set_scope!`](@ref)


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
+ [`mousetrap.get_current_button`](@ref)
+ [`mousetrap.get_only_listens_to_button`](@ref)
+ [`mousetrap.get_touch_only`](@ref)
+ [`mousetrap.set_only_listens_to_button!`](@ref)
+ [`mousetrap.set_touch_only!`](@ref)


---
## SpinButton
```@docs
SpinButton
```
#### Functions that operate on this type:
+ [`mousetrap.get_acceleration_rate`](@ref)
+ [`mousetrap.get_adjustment`](@ref)
+ [`mousetrap.get_allow_only_numeric`](@ref)
+ [`mousetrap.get_lower`](@ref)
+ [`mousetrap.get_n_digits`](@ref)
+ [`mousetrap.get_orientation`](@ref)
+ [`mousetrap.get_should_snap_to_ticks`](@ref)
+ [`mousetrap.get_should_wrap`](@ref)
+ [`mousetrap.get_step_increment`](@ref)
+ [`mousetrap.get_upper`](@ref)
+ [`mousetrap.get_value`](@ref)
+ [`mousetrap.reset_text_to_value_function!`](@ref)
+ [`mousetrap.reset_value_to_text_function!`](@ref)
+ [`mousetrap.set_acceleration_rate!`](@ref)
+ [`mousetrap.set_allow_only_numeric!`](@ref)
+ [`mousetrap.set_lower!`](@ref)
+ [`mousetrap.set_n_digits!`](@ref)
+ [`mousetrap.set_orientation!`](@ref)
+ [`mousetrap.set_should_snap_to_ticks!`](@ref)
+ [`mousetrap.set_should_wrap!`](@ref)
+ [`mousetrap.set_step_increment!`](@ref)
+ [`mousetrap.set_text_to_value_function!`](@ref)
+ [`mousetrap.set_upper!`](@ref)
+ [`mousetrap.set_value!`](@ref)
+ [`mousetrap.set_value_to_text_function!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


+ [`mousetrap.connect_signal_value_changed!`](@ref)
+ [`mousetrap.disconnect_signal_value_changed!`](@ref)
+ [`mousetrap.emit_signal_value_changed`](@ref)
+ [`mousetrap.get_signal_value_changed_blocked`](@ref)
+ [`mousetrap.set_signal_value_changed_blocked!`](@ref)




+ [`mousetrap.connect_signal_wrapped!`](@ref)
+ [`mousetrap.disconnect_signal_wrapped!`](@ref)
+ [`mousetrap.emit_signal_wrapped`](@ref)
+ [`mousetrap.get_signal_wrapped_blocked`](@ref)
+ [`mousetrap.set_signal_wrapped_blocked!`](@ref)


---
## Spinner
```@docs
Spinner
```
#### Functions that operate on this type:
+ [`mousetrap.get_is_spinning`](@ref)
+ [`mousetrap.set_is_spinning!`](@ref)
+ [`mousetrap.start!`](@ref)
+ [`mousetrap.stop!`](@ref)


---
## Stack
```@docs
Stack
```
#### Functions that operate on this type:
+ [`mousetrap.add_child!`](@ref)
+ [`mousetrap.get_child_at`](@ref)
+ [`mousetrap.get_is_horizontally_homogeneous`](@ref)
+ [`mousetrap.get_is_vertically_homogeneous`](@ref)
+ [`mousetrap.get_selection_model`](@ref)
+ [`mousetrap.get_should_interpolate_size`](@ref)
+ [`mousetrap.get_transition_duration`](@ref)
+ [`mousetrap.get_transition_type`](@ref)
+ [`mousetrap.get_visible_child`](@ref)
+ [`mousetrap.remove_child!`](@ref)
+ [`mousetrap.set_is_horizontally_homogeneous!`](@ref)
+ [`mousetrap.set_is_vertically_homogeneous!`](@ref)
+ [`mousetrap.set_should_interpolate_size!`](@ref)
+ [`mousetrap.set_transition_duration!`](@ref)
+ [`mousetrap.set_transition_type!`](@ref)
+ [`mousetrap.set_visible_child!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


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


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## StackSwitcher
```@docs
StackSwitcher
```
#### Functions that operate on this type:


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## StylusEventController
```@docs
StylusEventController
```
#### Functions that operate on this type:
+ [`mousetrap.get_axis_value`](@ref)
+ [`mousetrap.get_hardware_id`](@ref)
+ [`mousetrap.get_tool_type`](@ref)
+ [`mousetrap.has_axis`](@ref)


+ [`mousetrap.connect_signal_motion!`](@ref)
+ [`mousetrap.disconnect_signal_motion!`](@ref)
+ [`mousetrap.emit_signal_motion`](@ref)
+ [`mousetrap.get_signal_motion_blocked`](@ref)
+ [`mousetrap.set_signal_motion_blocked!`](@ref)


+ [`mousetrap.connect_signal_proximity!`](@ref)
+ [`mousetrap.disconnect_signal_proximity!`](@ref)
+ [`mousetrap.emit_signal_proximity`](@ref)
+ [`mousetrap.get_signal_proximity_blocked`](@ref)
+ [`mousetrap.set_signal_proximity_blocked!`](@ref)


+ [`mousetrap.connect_signal_stylus_down!`](@ref)
+ [`mousetrap.connect_signal_stylus_up!`](@ref)
+ [`mousetrap.disconnect_signal_stylus_down!`](@ref)
+ [`mousetrap.disconnect_signal_stylus_up!`](@ref)
+ [`mousetrap.emit_signal_stylus_down`](@ref)
+ [`mousetrap.emit_signal_stylus_up`](@ref)
+ [`mousetrap.get_signal_stylus_down_blocked`](@ref)
+ [`mousetrap.get_signal_stylus_up_blocked`](@ref)
+ [`mousetrap.set_signal_stylus_down_blocked!`](@ref)
+ [`mousetrap.set_signal_stylus_up_blocked!`](@ref)






---
## SwipeEventController
```@docs
SwipeEventController
```
#### Functions that operate on this type:
+ [`mousetrap.get_velocity`](@ref)


+ [`mousetrap.connect_signal_swipe!`](@ref)
+ [`mousetrap.disconnect_signal_swipe!`](@ref)
+ [`mousetrap.emit_signal_swipe`](@ref)
+ [`mousetrap.get_signal_swipe_blocked`](@ref)
+ [`mousetrap.set_signal_swipe_blocked!`](@ref)


---
## Switch
```@docs
Switch
```
#### Functions that operate on this type:
+ [`mousetrap.get_is_active`](@ref)
+ [`mousetrap.set_is_active!`](@ref)


+ [`mousetrap.connect_signal_activate!`](@ref)
+ [`mousetrap.disconnect_signal_activate!`](@ref)
+ [`mousetrap.emit_signal_activate`](@ref)
+ [`mousetrap.get_signal_activate_blocked`](@ref)
+ [`mousetrap.set_signal_activate_blocked!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## TextView
```@docs
TextView
```
#### Functions that operate on this type:
+ [`mousetrap.get_bottom_margin`](@ref)
+ [`mousetrap.get_cursor_visible`](@ref)
+ [`mousetrap.get_editable`](@ref)
+ [`mousetrap.get_justify_mode`](@ref)
+ [`mousetrap.get_left_margin`](@ref)
+ [`mousetrap.get_right_margin`](@ref)
+ [`mousetrap.get_text`](@ref)
+ [`mousetrap.get_top_margin`](@ref)
+ [`mousetrap.get_was_modified`](@ref)
+ [`mousetrap.redo!`](@ref)
+ [`mousetrap.set_bottom_margin!`](@ref)
+ [`mousetrap.set_cursor_visible!`](@ref)
+ [`mousetrap.set_editable!`](@ref)
+ [`mousetrap.set_justify_mode!`](@ref)
+ [`mousetrap.set_left_margin!`](@ref)
+ [`mousetrap.set_right_margin!`](@ref)
+ [`mousetrap.set_text!`](@ref)
+ [`mousetrap.set_top_margin!`](@ref)
+ [`mousetrap.set_was_modified!`](@ref)
+ [`mousetrap.undo!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_text_changed!`](@ref)
+ [`mousetrap.disconnect_signal_text_changed!`](@ref)
+ [`mousetrap.emit_signal_text_changed`](@ref)
+ [`mousetrap.get_signal_text_changed_blocked`](@ref)
+ [`mousetrap.set_signal_text_changed_blocked!`](@ref)




+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


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
+ [`mousetrap.bind`](@ref)
+ [`mousetrap.create!`](@ref)
+ [`mousetrap.create_from_image!`](@ref)
+ [`mousetrap.download`](@ref)
+ [`mousetrap.get_native_handle`](@ref)
+ [`mousetrap.get_scale_mode`](@ref)
+ [`mousetrap.get_size`](@ref)
+ [`mousetrap.get_wrap_mode`](@ref)
+ [`mousetrap.set_scale_mode!`](@ref)
+ [`mousetrap.set_texture!`](@ref)
+ [`mousetrap.set_wrap_mode!`](@ref)
+ [`mousetrap.unbind`](@ref)


---
## Time
```@docs
Time
```
#### Functions that operate on this type:
+ [`mousetrap.as_microseconds`](@ref)
+ [`mousetrap.as_milliseconds`](@ref)
+ [`mousetrap.as_minutes`](@ref)
+ [`mousetrap.as_nanoseconds`](@ref)
+ [`mousetrap.as_seconds`](@ref)
+ [`mousetrap.set_transition_duration!`](@ref)


---
## ToggleButton
```@docs
ToggleButton
```
#### Functions that operate on this type:
+ [`mousetrap.get_is_active`](@ref)
+ [`mousetrap.get_is_circular`](@ref)
+ [`mousetrap.remove_child!`](@ref)
+ [`mousetrap.set_child!`](@ref)
+ [`mousetrap.set_icon!`](@ref)
+ [`mousetrap.set_is_active!`](@ref)
+ [`mousetrap.set_is_circular!`](@ref)


+ [`mousetrap.connect_signal_activate!`](@ref)
+ [`mousetrap.disconnect_signal_activate!`](@ref)
+ [`mousetrap.emit_signal_activate`](@ref)
+ [`mousetrap.get_signal_activate_blocked`](@ref)
+ [`mousetrap.set_signal_activate_blocked!`](@ref)


+ [`mousetrap.connect_signal_clicked!`](@ref)
+ [`mousetrap.disconnect_signal_clicked!`](@ref)
+ [`mousetrap.emit_signal_clicked`](@ref)
+ [`mousetrap.get_signal_clicked_blocked`](@ref)
+ [`mousetrap.set_signal_clicked_blocked!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_toggled!`](@ref)
+ [`mousetrap.disconnect_signal_toggled!`](@ref)
+ [`mousetrap.emit_signal_toggled`](@ref)
+ [`mousetrap.get_signal_toggled_blocked`](@ref)
+ [`mousetrap.set_signal_toggled_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


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
+ [`mousetrap.get_has_frame`](@ref)
+ [`mousetrap.get_horizontal_adjustment`](@ref)
+ [`mousetrap.get_horizontal_scrollbar_policy`](@ref)
+ [`mousetrap.get_kinetic_scrolling_enabled`](@ref)
+ [`mousetrap.get_propagate_natural_height`](@ref)
+ [`mousetrap.get_propagate_natural_width`](@ref)
+ [`mousetrap.get_scrollbar_placement`](@ref)
+ [`mousetrap.get_vertical_adjustment`](@ref)
+ [`mousetrap.get_vertical_scrollbar_policy`](@ref)
+ [`mousetrap.remove_child!`](@ref)
+ [`mousetrap.set_child!`](@ref)
+ [`mousetrap.set_has_frame!`](@ref)
+ [`mousetrap.set_horizontal_scrollbar_policy!`](@ref)
+ [`mousetrap.set_kinetic_scrolling_enabled!`](@ref)
+ [`mousetrap.set_propagate_natural_height!`](@ref)
+ [`mousetrap.set_propagate_natural_width!`](@ref)
+ [`mousetrap.set_scrollbar_placement!`](@ref)
+ [`mousetrap.set_vertical_scrollbar_policy!`](@ref)


+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_scroll_child!`](@ref)
+ [`mousetrap.disconnect_signal_scroll_child!`](@ref)
+ [`mousetrap.emit_signal_scroll_child`](@ref)
+ [`mousetrap.get_signal_scroll_child_blocked`](@ref)
+ [`mousetrap.set_signal_scroll_child_blocked!`](@ref)




+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
## Widget
```@docs
Widget
```
#### Functions that operate on this type:
+ [`mousetrap.activate!`](@ref)
+ [`mousetrap.add_child!`](@ref)
+ [`mousetrap.add_controller!`](@ref)
+ [`mousetrap.add_overlay!`](@ref)
+ [`mousetrap.add_widget!`](@ref)
+ [`mousetrap.find`](@ref)
+ [`mousetrap.get_allocated_size`](@ref)
+ [`mousetrap.get_can_respond_to_input`](@ref)
+ [`mousetrap.get_child_position`](@ref)
+ [`mousetrap.get_clipboard`](@ref)
+ [`mousetrap.get_expand_horizontally`](@ref)
+ [`mousetrap.get_expand_vertically`](@ref)
+ [`mousetrap.get_focus_on_click`](@ref)
+ [`mousetrap.get_has_focus`](@ref)
+ [`mousetrap.get_hide_on_overflow`](@ref)
+ [`mousetrap.get_horizontal_alignment`](@ref)
+ [`mousetrap.get_is_focusable`](@ref)
+ [`mousetrap.get_is_realized`](@ref)
+ [`mousetrap.get_is_visible`](@ref)
+ [`mousetrap.get_margin_bottom`](@ref)
+ [`mousetrap.get_margin_end`](@ref)
+ [`mousetrap.get_margin_start`](@ref)
+ [`mousetrap.get_margin_top`](@ref)
+ [`mousetrap.get_minimum_size`](@ref)
+ [`mousetrap.get_natural_size`](@ref)
+ [`mousetrap.get_opacity`](@ref)
+ [`mousetrap.get_position`](@ref)
+ [`mousetrap.get_size`](@ref)
+ [`mousetrap.get_size_request`](@ref)
+ [`mousetrap.get_vertical_alignment`](@ref)
+ [`mousetrap.grab_focus!`](@ref)
+ [`mousetrap.hide!`](@ref)
+ [`mousetrap.insert_after!`](@ref)
+ [`mousetrap.insert_at!`](@ref)
+ [`mousetrap.insert_next_to!`](@ref)
+ [`mousetrap.push_back!`](@ref)
+ [`mousetrap.push_front!`](@ref)
+ [`mousetrap.remove!`](@ref)
+ [`mousetrap.remove_child!`](@ref)
+ [`mousetrap.remove_controller!`](@ref)
+ [`mousetrap.remove_overlay!`](@ref)
+ [`mousetrap.remove_tick_callback!`](@ref)
+ [`mousetrap.remove_tooltip_widget!`](@ref)
+ [`mousetrap.set_alignment!`](@ref)
+ [`mousetrap.set_can_respond_to_input!`](@ref)
+ [`mousetrap.set_center_child!`](@ref)
+ [`mousetrap.set_child!`](@ref)
+ [`mousetrap.set_child_position!`](@ref)
+ [`mousetrap.set_cursor!`](@ref)
+ [`mousetrap.set_cursor_from_image!`](@ref)
+ [`mousetrap.set_default_widget!`](@ref)
+ [`mousetrap.set_end_child!`](@ref)
+ [`mousetrap.set_expand!`](@ref)
+ [`mousetrap.set_expand_horizontally!`](@ref)
+ [`mousetrap.set_expand_vertically!`](@ref)
+ [`mousetrap.set_focus_on_click!`](@ref)
+ [`mousetrap.set_hide_on_overflow!`](@ref)
+ [`mousetrap.set_horizontal_alignment!`](@ref)
+ [`mousetrap.set_is_focusable!`](@ref)
+ [`mousetrap.set_is_visible!`](@ref)
+ [`mousetrap.set_label_widget!`](@ref)
+ [`mousetrap.set_listens_for_shortcut_action!`](@ref)
+ [`mousetrap.set_margin!`](@ref)
+ [`mousetrap.set_margin_bottom!`](@ref)
+ [`mousetrap.set_margin_end!`](@ref)
+ [`mousetrap.set_margin_horizontal!`](@ref)
+ [`mousetrap.set_margin_start!`](@ref)
+ [`mousetrap.set_margin_top!`](@ref)
+ [`mousetrap.set_margin_vertical!`](@ref)
+ [`mousetrap.set_opacity!`](@ref)
+ [`mousetrap.set_size_request!`](@ref)
+ [`mousetrap.set_start_child!`](@ref)
+ [`mousetrap.set_tick_callback!`](@ref)
+ [`mousetrap.set_title_widget!`](@ref)
+ [`mousetrap.set_titlebar_widget!`](@ref)
+ [`mousetrap.set_tooltip_text!`](@ref)
+ [`mousetrap.set_tooltip_widget!`](@ref)
+ [`mousetrap.set_vertical_alignment!`](@ref)
+ [`mousetrap.show!`](@ref)
+ [`mousetrap.unparent!`](@ref)


---
## Window
```@docs
Window
```
#### Functions that operate on this type:
+ [`mousetrap.close!`](@ref)
+ [`mousetrap.destroy!`](@ref)
+ [`mousetrap.get_destroy_with_parent`](@ref)
+ [`mousetrap.get_focus_visible`](@ref)
+ [`mousetrap.get_has_close_button`](@ref)
+ [`mousetrap.get_hide_on_close`](@ref)
+ [`mousetrap.get_is_decorated`](@ref)
+ [`mousetrap.get_is_modal`](@ref)
+ [`mousetrap.get_title`](@ref)
+ [`mousetrap.present!`](@ref)
+ [`mousetrap.remove_child!`](@ref)
+ [`mousetrap.remove_titlebar_widget!`](@ref)
+ [`mousetrap.set_application!`](@ref)
+ [`mousetrap.set_child!`](@ref)
+ [`mousetrap.set_default_widget!`](@ref)
+ [`mousetrap.set_destroy_with_parent!`](@ref)
+ [`mousetrap.set_focus_visible!`](@ref)
+ [`mousetrap.set_fullscreen!`](@ref)
+ [`mousetrap.set_has_close_button!`](@ref)
+ [`mousetrap.set_hide_on_close!`](@ref)
+ [`mousetrap.set_is_decorated!`](@ref)
+ [`mousetrap.set_is_modal!`](@ref)
+ [`mousetrap.set_maximized!`](@ref)
+ [`mousetrap.set_minimized!`](@ref)
+ [`mousetrap.set_startup_notification_identifier!`](@ref)
+ [`mousetrap.set_title!`](@ref)
+ [`mousetrap.set_titlebar_widget!`](@ref)
+ [`mousetrap.set_transient_for!`](@ref)


+ [`mousetrap.connect_signal_activate_default_widget!`](@ref)
+ [`mousetrap.disconnect_signal_activate_default_widget!`](@ref)
+ [`mousetrap.emit_signal_activate_default_widget`](@ref)
+ [`mousetrap.get_signal_activate_default_widget_blocked`](@ref)
+ [`mousetrap.set_signal_activate_default_widget_blocked!`](@ref)




+ [`mousetrap.connect_signal_activate_focused_widget!`](@ref)
+ [`mousetrap.disconnect_signal_activate_focused_widget!`](@ref)
+ [`mousetrap.emit_signal_activate_focused_widget`](@ref)
+ [`mousetrap.get_signal_activate_focused_widget_blocked`](@ref)
+ [`mousetrap.set_signal_activate_focused_widget_blocked!`](@ref)




+ [`mousetrap.connect_signal_close_request!`](@ref)
+ [`mousetrap.disconnect_signal_close_request!`](@ref)
+ [`mousetrap.emit_signal_close_request`](@ref)
+ [`mousetrap.get_signal_close_request_blocked`](@ref)
+ [`mousetrap.set_signal_close_request_blocked!`](@ref)




+ [`mousetrap.connect_signal_destroy!`](@ref)
+ [`mousetrap.disconnect_signal_destroy!`](@ref)
+ [`mousetrap.emit_signal_destroy`](@ref)
+ [`mousetrap.get_signal_destroy_blocked`](@ref)
+ [`mousetrap.set_signal_destroy_blocked!`](@ref)


+ [`mousetrap.connect_signal_hide!`](@ref)
+ [`mousetrap.disconnect_signal_hide!`](@ref)
+ [`mousetrap.emit_signal_hide`](@ref)
+ [`mousetrap.get_signal_hide_blocked`](@ref)
+ [`mousetrap.set_signal_hide_blocked!`](@ref)


+ [`mousetrap.connect_signal_map!`](@ref)
+ [`mousetrap.disconnect_signal_map!`](@ref)
+ [`mousetrap.emit_signal_map`](@ref)
+ [`mousetrap.get_signal_map_blocked`](@ref)
+ [`mousetrap.set_signal_map_blocked!`](@ref)


+ [`mousetrap.connect_signal_realize!`](@ref)
+ [`mousetrap.disconnect_signal_realize!`](@ref)
+ [`mousetrap.emit_signal_realize`](@ref)
+ [`mousetrap.get_signal_realize_blocked`](@ref)
+ [`mousetrap.set_signal_realize_blocked!`](@ref)


+ [`mousetrap.connect_signal_show!`](@ref)
+ [`mousetrap.disconnect_signal_show!`](@ref)
+ [`mousetrap.emit_signal_show`](@ref)
+ [`mousetrap.get_signal_show_blocked`](@ref)
+ [`mousetrap.set_signal_show_blocked!`](@ref)


+ [`mousetrap.connect_signal_unmap!`](@ref)
+ [`mousetrap.disconnect_signal_unmap!`](@ref)
+ [`mousetrap.emit_signal_unmap`](@ref)
+ [`mousetrap.get_signal_unmap_blocked`](@ref)
+ [`mousetrap.set_signal_unmap_blocked!`](@ref)


+ [`mousetrap.connect_signal_unrealize!`](@ref)
+ [`mousetrap.disconnect_signal_unrealize!`](@ref)
+ [`mousetrap.emit_signal_unrealize`](@ref)
+ [`mousetrap.get_signal_unrealize_blocked`](@ref)
+ [`mousetrap.set_signal_unrealize_blocked!`](@ref)


---
