const _generate_function_docs = quote

    for name in mousetrap.functions
        println("""
        @document $name @function_docs($name,
            \"\"\"
            TODO
            \"\"\",
            Cvoid, x::TODO
        )
        """)
    end
end

#@document :@log_info 
"""
```
@log_info(domain::LogDomain, message::Message)
```

Send a log message with log level "INFO". Messages of
this level will only be displayed once `set_surpress_info`
is set to `false` for this log domain.
"""

#@document :@log_debug 
"""
```
@log_debug(domain::LogDomain, message::Message)
```
Send a log message with log level "DEBUG". Messages of
this level will only be displayed once `set_surpress_debug`
is set to `false` for this log domain.
"""

#@document :@log_warning 
"""
```
@log_warning(domain::LogDomain, message::Message)
```
Send a log message with log level "WARNING".
"""

#@document :@log_critical 
"""
```
@log_critical(domain::LogDomain, message::Message)
```
Send a log message with log level "CRITICAL".
"""

#@document :@log_fatal 
"""
```
@log_fatal(domain::LogDomain, message::Message)
```
Send a log mess with log level "FATAL". Immediately after
this messages is printed, runtime will exit.
"""

@document Circle @function_docs(Circle,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document CircularRing @function_docs(CircularRing,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document EllipticalRing @function_docs(EllipticalRing,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document Line @function_docs(Line,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document LineStrip @function_docs(LineStrip,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document Outline @function_docs(Outline,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document Point @function_docs(Point,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document Polygon @function_docs(Polygon,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document Rectangle @function_docs(Rectangle,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document RectangularFrame @function_docs(RectangularFrame,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document Triangle @function_docs(Triangle,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document Wireframe @function_docs(Wireframe,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document activate @function_docs(activate,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document activate! @function_docs(activate!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document add_action! @function_docs(add_action!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document add_allow_all_supported_image_formats! @function_docs(add_allow_all_supported_image_formats!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document add_allowed_mime_type! @function_docs(add_allowed_mime_type!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document add_allowed_pattern! @function_docs(add_allowed_pattern!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document add_allowed_suffix! @function_docs(add_allowed_suffix!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document add_child! @function_docs(add_child!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document add_controller! @function_docs(add_controller!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document add_icon! @function_docs(add_icon!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document add_marker! @function_docs(add_marker!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document add_overlay! @function_docs(add_overlay!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document add_render_task! @function_docs(add_render_task!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document add_resource_path! @function_docs(add_resource_path!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document add_section! @function_docs(add_section!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document add_shortcut! @function_docs(add_shortcut!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document add_submenu! @function_docs(add_submenu!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document add_widget! @function_docs(add_widget!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document alt_pressed @function_docs(alt_pressed,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document apply_to @function_docs(apply_to,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_circle! @function_docs(as_circle!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_circular_ring! @function_docs(as_circular_ring!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_cropped @function_docs(as_cropped,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_degrees @function_docs(as_degrees,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_ellipse! @function_docs(as_ellipse!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_elliptical_ring! @function_docs(as_elliptical_ring!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_line! @function_docs(as_line!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_line_strip! @function_docs(as_line_strip!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_lines! @function_docs(as_lines!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_microseconds @function_docs(as_microseconds,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_milliseconds @function_docs(as_milliseconds,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_minutes @function_docs(as_minutes,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_nanoseconds @function_docs(as_nanoseconds,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_outline! @function_docs(as_outline!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_point! @function_docs(as_point!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_points! @function_docs(as_points!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_polygon! @function_docs(as_polygon!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_radians @function_docs(as_radians,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_rectangle! @function_docs(as_rectangle!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_rectangular_frame! @function_docs(as_rectangular_frame!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_scaled @function_docs(as_scaled,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_seconds @function_docs(as_seconds,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_string @function_docs(as_string,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_triangle! @function_docs(as_triangle!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document as_wireframe! @function_docs(as_wireframe!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document attach_to! @function_docs(attach_to!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document bind @function_docs(bind,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document cancel! @function_docs(cancel!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document clear @function_docs(clear,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document clear! @function_docs(clear!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document clear_render_tasks! @function_docs(clear_render_tasks!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document clear_shortcuts! @function_docs(clear_shortcuts!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document close! @function_docs(close!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document combine_with @function_docs(combine_with,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document contains_file @function_docs(contains_file,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document contains_image @function_docs(contains_image,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document contains_string @function_docs(contains_string,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document control_pressed @function_docs(control_pressed,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document copy! @function_docs(copy!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document create! @function_docs(create!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document create_as_file_preview! @function_docs(create_as_file_preview!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document create_directory_at! @function_docs(create_directory_at!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document create_file_at! @function_docs(create_file_at!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document create_from_file! @function_docs(create_from_file!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document create_from_icon! @function_docs(create_from_icon!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document create_from_image! @function_docs(create_from_image!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document create_from_path! @function_docs(create_from_path!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document create_from_string! @function_docs(create_from_string!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document create_from_theme! @function_docs(create_from_theme!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document create_from_uri! @function_docs(create_from_uri!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document create_monitor @function_docs(create_monitor,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document degrees @function_docs(degrees,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document delete_at! @function_docs(delete_at!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document device_axis_to_string @function_docs(device_axis_to_string,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document download @function_docs(download,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document elapsed @function_docs(elapsed,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document exists @function_docs(exists,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document flush @function_docs(flush,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document from_gl_coordinates @function_docs(from_gl_coordinates,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_acceleration_rate @function_docs(get_acceleration_rate,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_accept_label @function_docs(get_accept_label,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_action @function_docs(get_action,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_adjustment @function_docs(get_adjustment,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_allocated_size @function_docs(get_allocated_size,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_allow_only_numeric @function_docs(get_allow_only_numeric,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_always_show_arrow @function_docs(get_always_show_arrow,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_autohide @function_docs(get_autohide,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_bottom_margin @function_docs(get_bottom_margin,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_bounding_box @function_docs(get_bounding_box,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_can_respond_to_input @function_docs(get_can_respond_to_input,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_centroid @function_docs(get_centroid,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_child_position @function_docs(get_child_position,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_child_x_alignment @function_docs(get_child_x_alignment,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_child_y_alignment @function_docs(get_child_y_alignment,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_children @function_docs(get_children,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_clipboard @function_docs(get_clipboard,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_column_at @function_docs(get_column_at,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_column_spacing @function_docs(get_column_spacing,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_column_with_title @function_docs(get_column_with_title,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_columns_homogeneous @function_docs(get_columns_homogeneous,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_comment_above_group @function_docs(get_comment_above_group,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_comment_above_key @function_docs(get_comment_above_key,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_content_type @function_docs(get_content_type,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_current_button @function_docs(get_current_button,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_current_offset @function_docs(get_current_offset,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_current_page @function_docs(get_current_page,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_cursor_visible @function_docs(get_cursor_visible,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_delay_factor @function_docs(get_delay_factor,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_destroy_with_parent @function_docs(get_destroy_with_parent,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_display_mode @function_docs(get_display_mode,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_editable @function_docs(get_editable,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_ellipsize_mode @function_docs(get_ellipsize_mode,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_enabled @function_docs(get_enabled,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_enabled_rubberband_selection @function_docs(get_enabled_rubberband_selection,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_end_child_resizable @function_docs(get_end_child_resizable,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_end_child_shrinkable @function_docs(get_end_child_shrinkable,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_expand_horizontally @function_docs(get_expand_horizontally,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_expand_vertically @function_docs(get_expand_vertically,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_file_extension @function_docs(get_file_extension,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_fixed_width @function_docs(get_fixed_width,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_focus_on_click @function_docs(get_focus_on_click,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_focus_visible @function_docs(get_focus_visible,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_fraction @function_docs(get_fraction,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_fragment_shader_id @function_docs(get_fragment_shader_id,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_frame_clock @function_docs(get_frame_clock,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_groups @function_docs(get_groups,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_hardware_id @function_docs(get_hardware_id,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_has_base_arrow @function_docs(get_has_base_arrow,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_has_border @function_docs(get_has_border,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_has_close_button @function_docs(get_has_close_button,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_has_focus @function_docs(get_has_focus,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_has_frame @function_docs(get_has_frame,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_has_wide_handle @function_docs(get_has_wide_handle,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_hide_on_overflow @function_docs(get_hide_on_overflow,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_homogeneous @function_docs(get_homogeneous,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_horizontal_adjustment @function_docs(get_horizontal_adjustment,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_horizontal_alignemtn @function_docs(get_horizontal_alignemtn,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_horizontal_scrollbar_policy @function_docs(get_horizontal_scrollbar_policy,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_icon_names @function_docs(get_icon_names,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_id @function_docs(get_id,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_increment @function_docs(get_increment,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_inverted @function_docs(get_inverted,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_is_active @function_docs(get_is_active,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_is_circular @function_docs(get_is_circular,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_is_decorated @function_docs(get_is_decorated,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_is_focusable @function_docs(get_is_focusable,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_is_horizontally_homogeneous @function_docs(get_is_horizontally_homogeneous,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_is_inverted @function_docs(get_is_inverted,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_is_modal @function_docs(get_is_modal,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_is_realized @function_docs(get_is_realized,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_is_resizable @function_docs(get_is_resizable,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_is_scrollable @function_docs(get_is_scrollable,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_is_spinning @function_docs(get_is_spinning,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_is_stateful @function_docs(get_is_stateful,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_is_vertically_homogeneous @function_docs(get_is_vertically_homogeneous,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_is_visible @function_docs(get_is_visible,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_item_at @function_docs(get_item_at,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_justify_mode @function_docs(get_justify_mode,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_keys @function_docs(get_keys,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_kinetic_scrolling_enabled @function_docs(get_kinetic_scrolling_enabled,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_label_x_alignment! @function_docs(get_label_x_alignment!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_layout @function_docs(get_layout,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_left_margin @function_docs(get_left_margin,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_lower @function_docs(get_lower,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_margin_bottom @function_docs(get_margin_bottom,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_margin_end @function_docs(get_margin_end,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_margin_start @function_docs(get_margin_start,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_margin_top @function_docs(get_margin_top,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_max_length @function_docs(get_max_length,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_max_n_columns @function_docs(get_max_n_columns,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_max_width_chars @function_docs(get_max_width_chars,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_min_n_columns @function_docs(get_min_n_columns,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_min_value @function_docs(get_min_value,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_minimum_size @function_docs(get_minimum_size,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_mode @function_docs(get_mode,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_n_columns @function_docs(get_n_columns,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_n_digits @function_docs(get_n_digits,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_n_items @function_docs(get_n_items,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_n_pages @function_docs(get_n_pages,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_n_pixels @function_docs(get_n_pixels,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_n_rows @function_docs(get_n_rows,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_n_vertices @function_docs(get_n_vertices,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_name @function_docs(get_name,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_native_handle @function_docs(get_native_handle,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_natural_size @function_docs(get_natural_size,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_only_listens_to_button @function_docs(get_only_listens_to_button,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_opacity @function_docs(get_opacity,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_orientation @function_docs(get_orientation,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_parent @function_docs(get_parent,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_path @function_docs(get_path,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_path_relative_to @function_docs(get_path_relative_to,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_pixel @function_docs(get_pixel,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_position @function_docs(get_position,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_program_id @function_docs(get_program_id,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_propagate_natural_height @function_docs(get_propagate_natural_height,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_propagate_natural_width @function_docs(get_propagate_natural_width,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_propagation_phase @function_docs(get_propagation_phase,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_quick_change_menu_enabled @function_docs(get_quick_change_menu_enabled,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_ratio @function_docs(get_ratio,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_relative_position @function_docs(get_relative_position,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_revealed @function_docs(get_revealed,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_right_margin @function_docs(get_right_margin,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_row_spacing @function_docs(get_row_spacing,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_rows_homogeneous @function_docs(get_rows_homogeneous,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_scale_delta @function_docs(get_scale_delta,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_scale_mode @function_docs(get_scale_mode,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_scope @function_docs(get_scope,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_scrollbar_placement @function_docs(get_scrollbar_placement,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_selectable @function_docs(get_selectable,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_selected @function_docs(get_selected,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_selection @function_docs(get_selection,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_selection_model @function_docs(get_selection_model,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_shortcuts @function_docs(get_shortcuts,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_should_interpolate_size @function_docs(get_should_interpolate_size,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_should_snap_to_ticks @function_docs(get_should_snap_to_ticks,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_should_wrap @function_docs(get_should_wrap,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_show_arrow @function_docs(get_show_arrow,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_show_column_separators @function_docs(get_show_column_separators,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_show_row_separators @function_docs(get_show_row_separators,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_show_separators @function_docs(get_show_separators,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_show_title_buttons @function_docs(get_show_title_buttons,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_single_click_activate @function_docs(get_single_click_activate,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_size @function_docs(get_size,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_size_request @function_docs(get_size_request,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_spacing @function_docs(get_spacing,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_start_child_resizable @function_docs(get_start_child_resizable,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_start_child_shrinkable @function_docs(get_start_child_shrinkable,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_start_position @function_docs(get_start_position,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_state @function_docs(get_state,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_step_increment @function_docs(get_step_increment,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_string @function_docs(get_string,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_tab_position @function_docs(get_tab_position,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_tabs_reorderable @function_docs(get_tabs_reorderable,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_tabs_visible @function_docs(get_tabs_visible,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_target_frame_duration @function_docs(get_target_frame_duration,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_text @function_docs(get_text,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_text_visible @function_docs(get_text_visible,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_time_since_last_frame @function_docs(get_time_since_last_frame,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_title @function_docs(get_title,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_tool_type @function_docs(get_tool_type,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_top_left @function_docs(get_top_left,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_top_margin @function_docs(get_top_margin,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_touch_only @function_docs(get_touch_only,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_transition_duration @function_docs(get_transition_duration,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_transition_type @function_docs(get_transition_type,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_uniform_float @function_docs(get_uniform_float,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_uniform_int @function_docs(get_uniform_int,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_uniform_location @function_docs(get_uniform_location,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_uniform_rgba @function_docs(get_uniform_rgba,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_uniform_transform @function_docs(get_uniform_transform,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_uniform_uint @function_docs(get_uniform_uint,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_uniform_vec2 @function_docs(get_uniform_vec2,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_uniform_vec3 @function_docs(get_uniform_vec3,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_uniform_vec4 @function_docs(get_uniform_vec4,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_upper @function_docs(get_upper,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_uri @function_docs(get_uri,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_use_markup @function_docs(get_use_markup,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_value @function_docs(get_value,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_velocity @function_docs(get_velocity,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_vertex_color @function_docs(get_vertex_color,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_vertex_color_location @function_docs(get_vertex_color_location,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_vertex_position @function_docs(get_vertex_position,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_vertex_position_location @function_docs(get_vertex_position_location,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_vertex_shader_id @function_docs(get_vertex_shader_id,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_vertex_texture_coordinate @function_docs(get_vertex_texture_coordinate,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_vertex_texture_coordinate_location @function_docs(get_vertex_texture_coordinate_location,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_vertical_adjustment @function_docs(get_vertical_adjustment,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_vertical_alignment @function_docs(get_vertical_alignment,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_vertical_scrollbar_policy @function_docs(get_vertical_scrollbar_policy,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_visible_child @function_docs(get_visible_child,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_was_modified @function_docs(get_was_modified,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_wrap_mode @function_docs(get_wrap_mode,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_x_alignment @function_docs(get_x_alignment,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document get_y_alignment @function_docs(get_y_alignment,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document goto_page! @function_docs(goto_page!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document grab_focus! @function_docs(grab_focus!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document has_action @function_docs(has_action,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document has_axis @function_docs(has_axis,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document has_column_with_title @function_docs(has_column_with_title,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document has_group @function_docs(has_group,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document has_icon @function_docs(has_icon,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document has_key @function_docs(has_key,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document hide! @function_docs(hide!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document hold! @function_docs(hold!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document hsva_to_rgba @function_docs(hsva_to_rgba,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document html_code_to_rgba @function_docs(html_code_to_rgba,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document insert! @function_docs(insert!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document insert_after! @function_docs(insert_after!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document insert_column! @function_docs(insert_column!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document insert_column_at! @function_docs(insert_column_at!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document insert_row_at! @function_docs(insert_row_at!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document is_cancelled @function_docs(is_cancelled,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document is_file @function_docs(is_file,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document is_folder @function_docs(is_folder,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document is_local @function_docs(is_local,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document is_symlink @function_docs(is_symlink,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document is_valid_html_code @function_docs(is_valid_html_code,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document main @function_docs(main,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document make_current @function_docs(make_current,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document mark_as_busy! @function_docs(mark_as_busy!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document microseconds @function_docs(microseconds,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document milliseconds @function_docs(milliseconds,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document minutes @function_docs(minutes,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document mouse_button_01_pressed @function_docs(mouse_button_01_pressed,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document mouse_button_02_pressed @function_docs(mouse_button_02_pressed,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document move! @function_docs(move!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document nanoseconds @function_docs(nanoseconds,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document next_page! @function_docs(next_page!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document on_accept! @function_docs(on_accept!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document on_cancel! @function_docs(on_cancel!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document on_file_changed! @function_docs(on_file_changed!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document popdown! @function_docs(popdown!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document popoup! @function_docs(popoup!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document popup! @function_docs(popup!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document present! @function_docs(present!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document previous_page! @function_docs(previous_page!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document pulse @function_docs(pulse,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document push_back! @function_docs(push_back!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document push_back_column! @function_docs(push_back_column!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document push_back_row! @function_docs(push_back_row!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document push_front! @function_docs(push_front!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document push_front_column! @function_docs(push_front_column!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document push_front_row! @function_docs(push_front_row!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document query_info @function_docs(query_info,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document quit! @function_docs(quit!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document radians @function_docs(radians,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document read_symlink @function_docs(read_symlink,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document redo! @function_docs(redo!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document release! @function_docs(release!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document remove! @function_docs(remove!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document remove_action! @function_docs(remove_action!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document remove_center_child! @function_docs(remove_center_child!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document remove_child @function_docs(remove_child,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document remove_child! @function_docs(remove_child!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document remove_column! @function_docs(remove_column!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document remove_controller! @function_docs(remove_controller!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document remove_end_child @function_docs(remove_end_child,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document remove_end_child! @function_docs(remove_end_child!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document remove_label_widget! @function_docs(remove_label_widget!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document remove_marker! @function_docs(remove_marker!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document remove_overlay! @function_docs(remove_overlay!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document remove_popover! @function_docs(remove_popover!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document remove_primary_icon! @function_docs(remove_primary_icon!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document remove_row_at! @function_docs(remove_row_at!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document remove_secondary_icon! @function_docs(remove_secondary_icon!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document remove_start_child @function_docs(remove_start_child,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document remove_start_child! @function_docs(remove_start_child!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document remove_tick_callback! @function_docs(remove_tick_callback!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document remove_titlebar_widget! @function_docs(remove_titlebar_widget!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document remove_tooltip_widget! @function_docs(remove_tooltip_widget!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document render @function_docs(render,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document render_render_tasks @function_docs(render_render_tasks,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document reset! @function_docs(reset!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document reset_text_to_value_function! @function_docs(reset_text_to_value_function!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document reset_value_to_text_function! @function_docs(reset_value_to_text_function!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document restart! @function_docs(restart!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document rgba_to_hsva @function_docs(rgba_to_hsva,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document rgba_to_html_code @function_docs(rgba_to_html_code,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document rotate! @function_docs(rotate!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document run! @function_docs(run!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document save_to_file @function_docs(save_to_file,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document scale! @function_docs(scale!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document seconds @function_docs(seconds,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document select! @function_docs(select!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document select_all! @function_docs(select_all!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document self_is_focused @function_docs(self_is_focused,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document self_or_child_is_focused @function_docs(self_or_child_is_focused,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_acceleration_rate! @function_docs(set_acceleration_rate!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_accept_label! @function_docs(set_accept_label!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_action! @function_docs(set_action!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_alignment! @function_docs(set_alignment!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_allow_only_numeric! @function_docs(set_allow_only_numeric!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_always_show_arrow! @function_docs(set_always_show_arrow!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_application! @function_docs(set_application!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_autohide! @function_docs(set_autohide!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_bottom_margin! @function_docs(set_bottom_margin!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_can_respond_to_input! @function_docs(set_can_respond_to_input!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_center_child! @function_docs(set_center_child!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_centroid! @function_docs(set_centroid!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_child! @function_docs(set_child!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_child_position! @function_docs(set_child_position!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_child_x_alignment! @function_docs(set_child_x_alignment!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_child_y_alignment! @function_docs(set_child_y_alignment!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_column_spacing! @function_docs(set_column_spacing!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_columns_homogeneous! @function_docs(set_columns_homogeneous!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_comment_above! @function_docs(set_comment_above!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_comment_above_group! @function_docs(set_comment_above_group!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_comment_above_key! @function_docs(set_comment_above_key!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_current_blend_mode @function_docs(set_current_blend_mode,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_cursor! @function_docs(set_cursor!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_cursor_from_image! @function_docs(set_cursor_from_image!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_cursor_visible! @function_docs(set_cursor_visible!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_default_widget! @function_docs(set_default_widget!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_delay_factor @function_docs(set_delay_factor,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_destroy_with_parent! @function_docs(set_destroy_with_parent!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_display_mode! @function_docs(set_display_mode!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_editable! @function_docs(set_editable!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_ellipsize_mode! @function_docs(set_ellipsize_mode!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_enable_rubberband_selection @function_docs(set_enable_rubberband_selection,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_enabled! @function_docs(set_enabled!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_end_child! @function_docs(set_end_child!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_end_child_resizable! @function_docs(set_end_child_resizable!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_end_child_shrinkable @function_docs(set_end_child_shrinkable,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_expand! @function_docs(set_expand!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_expand_horizontally! @function_docs(set_expand_horizontally!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_expand_vertically! @function_docs(set_expand_vertically!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_file! @function_docs(set_file!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_fixed_width @function_docs(set_fixed_width,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_focus_on_click! @function_docs(set_focus_on_click!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_focus_visible! @function_docs(set_focus_visible!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_fraction! @function_docs(set_fraction!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_fullscreen! @function_docs(set_fullscreen!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_function! @function_docs(set_function!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_has_base_arrow! @function_docs(set_has_base_arrow!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_has_border! @function_docs(set_has_border!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_has_close_button! @function_docs(set_has_close_button!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_has_frame @function_docs(set_has_frame,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_has_frame! @function_docs(set_has_frame!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_has_wide_handle @function_docs(set_has_wide_handle,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_header_menu! @function_docs(set_header_menu!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_hide_on_close! @function_docs(set_hide_on_close!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_hide_on_overflow! @function_docs(set_hide_on_overflow!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_homogeneous! @function_docs(set_homogeneous!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_horizontal_alignment! @function_docs(set_horizontal_alignment!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_horizontal_scrollbar_policy! @function_docs(set_horizontal_scrollbar_policy!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_icon! @function_docs(set_icon!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_image! @function_docs(set_image!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_increment! @function_docs(set_increment!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_inverted! @function_docs(set_inverted!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_is_active! @function_docs(set_is_active!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_is_circular @function_docs(set_is_circular,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_is_circular! @function_docs(set_is_circular!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_is_decorated! @function_docs(set_is_decorated!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_is_focusable! @function_docs(set_is_focusable!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_is_horizontally_homogeneous @function_docs(set_is_horizontally_homogeneous,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_is_inverted! @function_docs(set_is_inverted!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_is_modal! @function_docs(set_is_modal!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_is_resizable! @function_docs(set_is_resizable!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_is_scrollable! @function_docs(set_is_scrollable!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_is_spinning! @function_docs(set_is_spinning!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_is_vertically_homogeneous @function_docs(set_is_vertically_homogeneous,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_is_visible! @function_docs(set_is_visible!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_justify_mode! @function_docs(set_justify_mode!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_kinetic_scrolling_enabled! @function_docs(set_kinetic_scrolling_enabled!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_label_widget! @function_docs(set_label_widget!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_label_x_alignment! @function_docs(set_label_x_alignment!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_layout! @function_docs(set_layout!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_left_margin! @function_docs(set_left_margin!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_log_file @function_docs(set_log_file,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_lower! @function_docs(set_lower!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_margin_bottom! @function_docs(set_margin_bottom!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_margin_end! @function_docs(set_margin_end!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_margin_horizontal! @function_docs(set_margin_horizontal!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_margin_margin! @function_docs(set_margin_margin!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_margin_start! @function_docs(set_margin_start!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_margin_top! @function_docs(set_margin_top!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_margin_vertical! @function_docs(set_margin_vertical!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_max_length! @function_docs(set_max_length!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_max_n_columns! @function_docs(set_max_n_columns!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_max_value! @function_docs(set_max_value!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_max_width_chars! @function_docs(set_max_width_chars!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_maximized! @function_docs(set_maximized!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_min_n_columns! @function_docs(set_min_n_columns!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_min_value! @function_docs(set_min_value!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_mode! @function_docs(set_mode!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_n_digits! @function_docs(set_n_digits!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_only_listens_to_button! @function_docs(set_only_listens_to_button!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_opacity! @function_docs(set_opacity!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_orientation @function_docs(set_orientation,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_orientation! @function_docs(set_orientation!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_pixel! @function_docs(set_pixel!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_popover! @function_docs(set_popover!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_popover_menu! @function_docs(set_popover_menu!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_popover_position! @function_docs(set_popover_position!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_position! @function_docs(set_position!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_primary_icon! @function_docs(set_primary_icon!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_propagate_natural_height! @function_docs(set_propagate_natural_height!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_propagate_natural_width! @function_docs(set_propagate_natural_width!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_propagation_phase! @function_docs(set_propagation_phase!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_quick_change_menu_enabled! @function_docs(set_quick_change_menu_enabled!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_ratio! @function_docs(set_ratio!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_relative_position! @function_docs(set_relative_position!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_resource_path! @function_docs(set_resource_path!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_revealed! @function_docs(set_revealed!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_right_margin! @function_docs(set_right_margin!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_row_spacing! @function_docs(set_row_spacing!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_rows_homogeneous! @function_docs(set_rows_homogeneous!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_scale! @function_docs(set_scale!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_scale_mode! @function_docs(set_scale_mode!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_scope! @function_docs(set_scope!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_scrollbar_placement! @function_docs(set_scrollbar_placement!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_secondary_icon! @function_docs(set_secondary_icon!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_selectable! @function_docs(set_selectable!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_selected @function_docs(set_selected,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_should_interpolate_size @function_docs(set_should_interpolate_size,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_should_snap_to_ticks! @function_docs(set_should_snap_to_ticks!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_should_wrap! @function_docs(set_should_wrap!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_show_arrow! @function_docs(set_show_arrow!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_show_column_separators @function_docs(set_show_column_separators,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_show_row_separators @function_docs(set_show_row_separators,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_show_separators @function_docs(set_show_separators,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_show_title_buttons! @function_docs(set_show_title_buttons!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_single_click_activate @function_docs(set_single_click_activate,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_single_click_activate! @function_docs(set_single_click_activate!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_spacing! @function_docs(set_spacing!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_start_child! @function_docs(set_start_child!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_start_child_resizable! @function_docs(set_start_child_resizable!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_start_child_shrinkable @function_docs(set_start_child_shrinkable,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_startup_notification_identifier! @function_docs(set_startup_notification_identifier!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_state! @function_docs(set_state!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_stateful_function! @function_docs(set_stateful_function!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_step_increment! @function_docs(set_step_increment!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_string! @function_docs(set_string!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_surpress_debug @function_docs(set_surpress_debug,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_surpress_info @function_docs(set_surpress_info,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_tab_position! @function_docs(set_tab_position!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_tabs_reorderable! @function_docs(set_tabs_reorderable!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_tabs_visible! @function_docs(set_tabs_visible!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_text! @function_docs(set_text!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_text_to_value_function! @function_docs(set_text_to_value_function!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_text_visible! @function_docs(set_text_visible!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_texture! @function_docs(set_texture!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_tick_callback! @function_docs(set_tick_callback!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_title @function_docs(set_title,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_title! @function_docs(set_title!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_title_widget! @function_docs(set_title_widget!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_titlebar_widget! @function_docs(set_titlebar_widget!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_tooltip_text! @function_docs(set_tooltip_text!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_tooltip_widget! @function_docs(set_tooltip_widget!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_top_left! @function_docs(set_top_left!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_top_margin! @function_docs(set_top_margin!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_touch_only! @function_docs(set_touch_only!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_transient_for! @function_docs(set_transient_for!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_transition_duration! @function_docs(set_transition_duration!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_transition_type @function_docs(set_transition_type,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_transition_type! @function_docs(set_transition_type!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_uniform_float! @function_docs(set_uniform_float!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_uniform_hsva! @function_docs(set_uniform_hsva!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_uniform_int! @function_docs(set_uniform_int!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_uniform_rgba! @function_docs(set_uniform_rgba!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_uniform_transform! @function_docs(set_uniform_transform!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_uniform_uint! @function_docs(set_uniform_uint!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_uniform_vec2! @function_docs(set_uniform_vec2!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_uniform_vec3! @function_docs(set_uniform_vec3!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_uniform_vec4! @function_docs(set_uniform_vec4!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_upper! @function_docs(set_upper!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_use_markup! @function_docs(set_use_markup!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_value! @function_docs(set_value!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_value_to_text_function! @function_docs(set_value_to_text_function!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_vertex_color! @function_docs(set_vertex_color!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_vertex_position! @function_docs(set_vertex_position!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_vertex_texture_coordinate @function_docs(set_vertex_texture_coordinate,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_vertical_alignment! @function_docs(set_vertical_alignment!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_vertical_scrollbar_policy! @function_docs(set_vertical_scrollbar_policy!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_visible_child! @function_docs(set_visible_child!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_was_modified! @function_docs(set_was_modified!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_widget! @function_docs(set_widget!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_widget_at! @function_docs(set_widget_at!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_wrap_mode! @function_docs(set_wrap_mode!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_x_alignment! @function_docs(set_x_alignment!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document set_y_alignment! @function_docs(set_y_alignment!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document shift_pressed @function_docs(shift_pressed,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document should_shortcut_trigger_trigger @function_docs(should_shortcut_trigger_trigger,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document show! @function_docs(show!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document start! @function_docs(start!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document stop! @function_docs(stop!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document to_gl_coordinates @function_docs(to_gl_coordinates,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document translate! @function_docs(translate!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document unbind @function_docs(unbind,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document undo! @function_docs(undo!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document unmark_as_busy! @function_docs(unmark_as_busy!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document unparent! @function_docs(unparent!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document unselect! @function_docs(unselect!,
    """
    TODO
    """,
    Cvoid, x::TODO
)

@document unselect_all! @function_docs(unselect_all!,
    """
    TODO
    """,
    Cvoid, x::TODO
)


