# Index 

---

## Log

```@docs
LogDomain
@log_debug
@log_info
@log_warning
@log_critical
@log_fatal
set_surpress_debug
get_surpress_debug
set_surpress_info
get_surpress_info
set_log_file
```

---

## Application

```@docs
Application
run!
quit!
hold!
release!
mark_as_busy!
unmark_as_busy!
get_id
add_action!
get_action
remove_action!
has_action
main
```

---

## Window

```@docs
Window
WindowCloseRequestResult
WINDOW_CLOSE_REQUEST_RESULT_ALLOW_CLOSE
WINDOW_CLOSE_REQUEST_RESULT_PREVENT_CLOSE
set_application!
set_fullscreen!
present!
set_hide_on_close!
close!
set_child!(::Window, ::Widget)
remove_child!(::Window)
set_transient_for!
set_destroy_with_parent!
set_title!
get_title
set_titlebar_widget!
remove_titlebar_widget!
set_is_modal!
get_is_modal
set_is_decorated!
set_has_close_button!
get_has_close_button!
set_startup_notification!
set_focus_visible!
get_focus_visible
set_default_widget!
```

--- 

## Action

```@docs
Action
get_id
set_function!
set_stateful_function!
is_stateful
set_state!
get_state
activate
set_enabled!
get_enabled
add_shortcut!
get_shortcuts
clear_shortcuts
``` 

---

## Adjustment

```@docs
Adjustment
get_lower
set_lower!
get_upper
set_upper!
get_value
set_value!
get_increment
set_increment!
```

--- 

## ALIGNMENT

```@docs
Aignment
ALIGNMENT_START
ALIGNMENT_CENTER
ALIGNMENT_END
```

---

## CursorType

```@docs
CursorType
CURSOR_TYPE_NONE
CURSOR_TYPE_DEFAULT
CURSOR_TYPE_HELP
CURSOR_TYPE_POINTER
CURSOR_TYPE_CONTEXT_MENU
CURSOR_TYPE_PROGRESS
CURSOR_TYPE_WAIT
CURSOR_TYPE_CELL
CURSOR_TYPE_CROSSHAIR
CURSOR_TYPE_TEXT
CURSOR_TYPE_MOVE
CURSOR_TYPE_NOT_ALLOWED
CURSOR_TYPE_GRAB
CURSOR_TYPE_GRABBING
CURSOR_TYPE_ALL_SCROLL
CURSOR_TYPE_ZOOM_IN
CURSOR_TYPE_ZOOM_OUT
CURSOR_TYPE_COLUMN_RESIZE
CURSOR_TYPE_ROW_RESIZE
CURSOR_TYPE_NORTH_RESIZE
CURSOR_TYPE_NORTH_EAST_RESIZE
CURSOR_TYPE_EAST_RESIZE
CURSOR_TYPE_SOUTH_EAST_RESIZE
CURSOR_TYPE_SOUTH_RESIZE
CURSOR_TYPE_SOUTH_WEST_RESIZE
CURSOR_TYPE_WEST_RESIZE
CURSOR_TYPE_NORTH_WEST_RESIZE
```

---

## AspectFrame

```@docs
AspectFrame
set_child!
remove_child!
set_ratio!
get_ratio
set_child_x_alignment!
get_child_x_alignment
set_child_y_alignment!
get_child_y_alignment
```

---

## Box

```@docs
Box
push_back!(::Box, ::Widget)
push_front!(::Box, ::Widget)
insert_after!
remove!(::Box, ::Widget)
clear!(::Box)
set_homogeneous!
get_homogeneous
set_spacing!
get_spacing
set_orientation!(::Box, ::Orientation)
get_orientation(::Box)
```