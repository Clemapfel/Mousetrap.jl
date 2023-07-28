#
# Author: C. Cords (mail@clemens-cords.com)
# https://github.com/clemapfel/mousetrap.jl
#
# Copyright © 2023, Licensed under lGPL3-0
#

@document Alignment enum_docs(:Alignment,
    "Determines alignment of widgets along the horizontal or vertical axis.", [
    :ALIGNMENT_CENTER,
    :ALIGNMENT_END,
    :ALIGNMENT_START
])
@document ALIGNMENT_START "Aligned left if horizontal, top if vertical"
@document ALIGNMENT_CENTER "Aligned centered, regardless of orientation"
@document ALIGNMENT_END "Aligned right if horizontal, bottom if vertical."

@document BlendMode enum_docs(:BlendMode,
    "Governs how colors are mixed when two fragments are rendered on top of each other.", [
    :BLEND_MODE_ADD,
    :BLEND_MODE_MAX,
    :BLEND_MODE_MIN,
    :BLEND_MODE_MULTIPLY,
    :BLEND_MODE_NONE,
    :BLEND_MODE_REVERSE_SUBTRACT,
    :BLEND_MODE_SUBTRACT
])
@document BLEND_MODE_NORMAL "Traditional alpha blending, alpha component of both colors is treated as emission."
@document BLEND_MODE_ADD "result = source.rgb + destination.rgb"
@document BLEND_MODE_MAX "result = max(source.rgb, destination.rgb)"
@document BLEND_MODE_MIN "result = min(source.rgb, destination.rgb)"
@document BLEND_MODE_MULTIPLY "result = source.rgb * destination.rgb"
@document BLEND_MODE_NONE "result = destination.rgba"
@document BLEND_MODE_REVERSE_SUBTRACT "result = source.rgb - destination.rgb"
@document BLEND_MODE_SUBTRACT "result = destination.rgb - source.rgb"

@document ButtonID enum_docs(:ButtonID,
    "ID of a mouse button, manufacturer-specific.", [
    :BUTTON_ID_ANY,
    :BUTTON_ID_BUTTON_01,
    :BUTTON_ID_BUTTON_02,
    :BUTTON_ID_BUTTON_03,
    :BUTTON_ID_BUTTON_04,
    :BUTTON_ID_BUTTON_05,
    :BUTTON_ID_BUTTON_06,
    :BUTTON_ID_BUTTON_07,
    :BUTTON_ID_BUTTON_08,
    :BUTTON_ID_BUTTON_09,
    :BUTTON_ID_NONE
])
@document BUTTON_ID_ANY "Any button, regardless of ID"
@document BUTTON_ID_BUTTON_01 "Button #1, usually the left mouse button, or a touchscreen press"
@document BUTTON_ID_BUTTON_02 "Button #2, usually the right mouse button"
@document BUTTON_ID_BUTTON_03 "Button #3, manufacturer specific"
@document BUTTON_ID_BUTTON_04 "Button #4, manufacturer specific"
@document BUTTON_ID_BUTTON_05 "Button #5, manufacturer specific"
@document BUTTON_ID_BUTTON_06 "Button #6, manufacturer specific"
@document BUTTON_ID_BUTTON_07 "Button #7, manufacturer specific"
@document BUTTON_ID_BUTTON_08 "Button #8, manufacturer specific"
@document BUTTON_ID_BUTTON_09 "Button #9, manufacturer specific"
@document BUTTON_ID_NONE "No button, regardless of ID"

@document CheckButtonState enum_docs(:CheckButtonState,
    "State of a [`CheckButton`](@ref)", [
    :CHECK_BUTTON_STATE_ACTIVE,
    :CHECK_BUTTON_STATE_INACTIVE,
    :CHECK_BUTTON_STATE_INCONSISTENT
])
@document CHECK_BUTTON_STATE_ACTIVE "Active, usually displayed as a check mark"
@document CHECK_BUTTON_STATE_INACTIVE "Inactive, usually displayed as no check mark"
@document CHECK_BUTTON_STATE_INCONSISTENT "Neither active nor inactive, usually displayed with a tilde `~`"

@document CornerPlacement enum_docs(:CornerPlacement,
    "Placement of both scrollbars relative to the center of a `Viewport`", [
    :CORNER_PLACEMENT_BOTTOM_LEFT,
    :CORNER_PLACEMENT_BOTTOM_RIGHT,
    :CORNER_PLACEMENT_TOP_LEFT,
    :CORNER_PLACEMENT_TOP_RIGHT
])
@document CORNER_PLACEMENT_BOTTOM_LEFT "Horizontal scrollbar bottom, vertical scrollbar left"
@document CORNER_PLACEMENT_BOTTOM_RIGHT "Horizontal scrollbar bottom, vertical scrollbar right"
@document CORNER_PLACEMENT_TOP_LEFT "Horizontal scrollbar top, vertical scrollbar left"
@document CORNER_PLACEMENT_TOP_RIGHT "Horizontal scrollbar top, vertical scrollbar right"

@document CursorType enum_docs(:CursorType,
    "Determines what the users cursor will look like while it is inside the allocated area of the widget", [
    :CURSOR_TYPE_ALL_SCROLL,
    :CURSOR_TYPE_CELL,
    :CURSOR_TYPE_COLUMN_RESIZE,
    :CURSOR_TYPE_CONTEXT_MENU,
    :CURSOR_TYPE_CROSSHAIR,
    :CURSOR_TYPE_DEFAULT,
    :CURSOR_TYPE_EAST_RESIZE,
    :CURSOR_TYPE_GRAB,
    :CURSOR_TYPE_GRABBING,
    :CURSOR_TYPE_HELP,
    :CURSOR_TYPE_MOVE,
    :CURSOR_TYPE_NONE,
    :CURSOR_TYPE_NORTH_EAST_RESIZE,
    :CURSOR_TYPE_NORTH_RESIZE,
    :CURSOR_TYPE_NORTH_WEST_RESIZE,
    :CURSOR_TYPE_NOT_ALLOWED,
    :CURSOR_TYPE_POINTER,
    :CURSOR_TYPE_PROGRESS,
    :CURSOR_TYPE_ROW_RESIZE,
    :CURSOR_TYPE_SOUTH_EAST_RESIZE,
    :CURSOR_TYPE_SOUTH_RESIZE,
    :CURSOR_TYPE_SOUTH_WEST_RESIZE,
    :CURSOR_TYPE_TEXT,
    :CURSOR_TYPE_WAIT,
    :CURSOR_TYPE_WEST_RESIZE,
    :CURSOR_TYPE_ZOOM_IN,
    :CURSOR_TYPE_ZOOM_OUT
])
@document CURSOR_TYPE_ALL_SCROLL "Omni-directional scrolling"
@document CURSOR_TYPE_CELL "Cross, used for selecting cells from a table"
@document CURSOR_TYPE_COLUMN_RESIZE "Left-right arrow"
@document CURSOR_TYPE_CONTEXT_MENU "Questionmark, instructs the user that clicking will open a context menu"
@document CURSOR_TYPE_CROSSHAIR "Crosshair, used for making pixel-perfect selections"
@document CURSOR_TYPE_DEFAULT "Default arrow pointer"
@document CURSOR_TYPE_EAST_RESIZE "Left arrow"
@document CURSOR_TYPE_GRAB "Hand, not yet grabbing"
@document CURSOR_TYPE_GRABBING "Hand, currently grabbing"
@document CURSOR_TYPE_HELP "Questionmark, instructs the user that clicking or hovering above this element will open a help menu"
@document CURSOR_TYPE_MOVE "4-directional arrow"
@document CURSOR_TYPE_NONE "Invisible cursor"
@document CURSOR_TYPE_NORTH_EAST_RESIZE "Up-left arrow"
@document CURSOR_TYPE_NORTH_RESIZE "Up-arrow"
@document CURSOR_TYPE_NORTH_WEST_RESIZE "Up-right arrow"
@document CURSOR_TYPE_NOT_ALLOWED "Instructs the user that this action is currently disabled"
@document CURSOR_TYPE_POINTER "Hand pointing"
@document CURSOR_TYPE_PROGRESS "Spinning animation, signifies that the object is currently busy"
@document CURSOR_TYPE_ROW_RESIZE "Up-down arrow"
@document CURSOR_TYPE_SOUTH_EAST_RESIZE "Down-left arrow"
@document CURSOR_TYPE_SOUTH_RESIZE "Down arrow"
@document CURSOR_TYPE_SOUTH_WEST_RESIZE "Down-right arrow"
@document CURSOR_TYPE_TEXT "Caret"
@document CURSOR_TYPE_WAIT "Loading animation, Instructs the user that an action will become available soon"
@document CURSOR_TYPE_WEST_RESIZE "Right arrow"
@document CURSOR_TYPE_ZOOM_IN "Lens, usually with a plus icon"
@document CURSOR_TYPE_ZOOM_OUT "Lens, usually with a minus icon"

@document DeviceAxis enum_docs(:DeviceAxis,
    "Axes of stylus- and touchpad device, capture by `StylusEventController`. Not all manufactures support all or even any of these.", [
    :DEVICE_AXIS_DELTA_X,
    :DEVICE_AXIS_DELTA_Y,
    :DEVICE_AXIS_DISTANCE,
    :DEVICE_AXIS_PRESSURE,
    :DEVICE_AXIS_ROTATION,
    :DEVICE_AXIS_SLIDER,
    :DEVICE_AXIS_WHEEL,
    :DEVICE_AXIS_X,
    :DEVICE_AXIS_X_TILT,
    :DEVICE_AXIS_Y,
    :DEVICE_AXIS_Y_TILT
])
@document DEVICE_AXIS_DELTA_X "Horizontal offset"
@document DEVICE_AXIS_DELTA_Y "Vertical offset"
@document DEVICE_AXIS_DISTANCE "Distance between the stylus' tip and the touchpad"
@document DEVICE_AXIS_PRESSURE "Current pressure of the stylus"
@document DEVICE_AXIS_ROTATION "Rotation of the stylus, usually in radians"
@document DEVICE_AXIS_SLIDER "State of the stylus slider"
@document DEVICE_AXIS_WHEEL "State of the stylus scroll wheel"
@document DEVICE_AXIS_X "X-position of the stylus"
@document DEVICE_AXIS_X_TILT "Tilt along the horizontal axis"
@document DEVICE_AXIS_Y "Y-position of the stylus"
@document DEVICE_AXIS_Y_TILT "Tilt along the vertical axis"

@document EllipsizeMode enum_docs(:EllipsizeMode,
    "Determines how ellipses are inserted when a `Label`s allocated area exceeds the space it is allowed to allocated", [
    :ELLIPSIZE_MODE_END,
    :ELLIPSIZE_MODE_MIDDLE,
    :ELLIPSIZE_MODE_NONE,
    :ELLIPSIZE_MODE_START
])
@document ELLIPSIZE_MODE_END "Inserted at the end: `text...`"
@document ELLIPSIZE_MODE_MIDDLE "Inserted in the middle: `te...xt`"
@document ELLIPSIZE_MODE_NONE "No ellipsizing will take place"
@document ELLIPSIZE_MODE_START "Insert at the start: `...text`"

@document FileChooserAction enum_docs(:FileChooserAction,
    "Determines layout, which, and how many files/folders a user can select when using [`FileChooser`](@ref)", [
    :FILE_CHOOSER_ACTION_OPEN_FILE,
    :FILE_CHOOSER_ACTION_OPEN_MULTIPLE_FILES,
    :FILE_CHOOSER_ACTION_SAVE,
    :FILE_CHOOSER_ACTION_SELECT_FOLDER,
    :FILE_CHOOSER_ACTION_SELECT_MULTIPLE_FOLDERS
])
@document FILE_CHOOSER_ACTION_OPEN_FILE "Select exactly one file"
@document FILE_CHOOSER_ACTION_OPEN_MULTIPLE_FILES "Select one or more files"
@document FILE_CHOOSER_ACTION_SAVE "Choose a name and location"
@document FILE_CHOOSER_ACTION_SELECT_FOLDER "Select exactly one folder"
@document FILE_CHOOSER_ACTION_SELECT_MULTIPLE_FOLDERS "Select one or more folders"

@document FileMonitorEvent enum_docs(:FileMonitorEvent,
    "Classifies user behavior that triggered the callback of [`FileMonitor`](@ref)", [
    :FILE_MONITOR_EVENT_ATTRIBUTE_CHANGED,
    :FILE_MONITOR_EVENT_CHANGED,
    :FILE_MONITOR_EVENT_CHANGES_DONE_HINT,
    :FILE_MONITOR_EVENT_CREATED,
    :FILE_MONITOR_EVENT_DELETED,
    :FILE_MONITOR_EVENT_MOVED_IN,
    :FILE_MONITOR_EVENT_MOVED_OUT,
    :FILE_MONITOR_EVENT_RENAMED
])
@document FILE_MONITOR_EVENT_ATTRIBUTE_CHANGED "Metadata about monitored file changed"
@document FILE_MONITOR_EVENT_CHANGED "Content of monitored file changed"
@document FILE_MONITOR_EVENT_CHANGES_DONE_HINT "Emitted to signal the end of a series of changes"
@document FILE_MONITOR_EVENT_CREATED "A new file was created inside the monitored folder"
@document FILE_MONITOR_EVENT_DELETED "File, Folder, or file inside monitored folder was deleted"
@document FILE_MONITOR_EVENT_MOVED_IN "File was move into the monitored folder"
@document FILE_MONITOR_EVENT_MOVED_OUT "File was moved out of the monitored folder"
@document FILE_MONITOR_EVENT_RENAMED "File or folder was renamed"

@document InterpolationType enum_docs(:InterpolationType,
    "Determines interpolation algorithm used when scaling [`Image`](@ref)", [
    :INTERPOLATION_TYPE_BILINEAR,
    :INTERPOLATION_TYPE_HYPERBOLIC,
    :INTERPOLATION_TYPE_NEAREST,
    :INTERPOLATION_TYPE_TILES
])
@document INTERPOLATION_TYPE_BILINEAR "Linear interpolation, adequate speed and quality"
@document INTERPOLATION_TYPE_HYPERBOLIC "Cubic interpolation, slow speed, high quality"
@document INTERPOLATION_TYPE_NEAREST "Nearest neigbhor interpolation, fastest but no filtering takes place"
@document INTERPOLATION_TYPE_TILES "Linear when scaling down, nearest neighbor when scaling up."

@document JustifyMode enum_docs(:JustifyMode,
    "Determines how words are arranged along the horizontal axis of a [`Label`](@ref) or [`TextView`](@ref)", [
    :JUSTIFY_MODE_CENTER,
    :JUSTIFY_MODE_FILL,
    :JUSTIFY_MODE_LEFT,
    :JUSTIFY_MODE_RIGHT
])
@document JUSTIFY_MODE_CENTER "Push towards the center"
@document JUSTIFY_MODE_FILL "Expand such that the entire width is filled"
@document JUSTIFY_MODE_LEFT "Push towards left"
@document JUSTIFY_MODE_RIGHT "Push towards right"

@document LabelWrapMode enum_docs(:LabelWrapMode,
    "Determines at which point in a `Label`s contents a linebreak will be inserted", [
    :LABEL_WRAP_MODE_NONE,
    :LABEL_WRAP_MODE_ONLY_ON_CHAR,
    :LABEL_WRAP_MODE_ONLY_ON_WORD,
    :LABEL_WRAP_MODE_WORD_OR_CHAR
])
@document LABEL_WRAP_MODE_NONE "Never wrap, will always be exactly one line"
@document LABEL_WRAP_MODE_ONLY_ON_CHAR "Insert linebreaks after a character"
@document LABEL_WRAP_MODE_ONLY_ON_WORD "Insert linebreaks before a space between two words"
@document LABEL_WRAP_MODE_WORD_OR_CHAR "Insert linebreak after a character or before the space between two words"

@document LevelBarMode enum_docs(:LevelBarMode,
    "Determines how a [`LevelBar`](@ref) displays its fraction", [
    :LEVEL_BAR_MODE_CONTINUOUS,
    :LEVEL_BAR_MODE_DISCRETE
])
@document LEVEL_BAR_MODE_CONTINUOUS "Continuous bar, displays floating point value"
@document LEVEL_BAR_MODE_DISCRETE "Segmented bar, displays integer value"

@document Orientation enum_docs(:Orientation,
    "Determines orientation of a widget", [
    :ORIENTATION_HORIZONTAL,
    :ORIENTATION_VERTICAL
])
@document ORIENTATION_HORIZONTAL "Align left-to-right along the x-axis"
@document ORIENTATION_VERTICAL "Align top-to-bottom along the y-axis"

@document PanDirection enum_docs(:PanDirection,
    "Direction of a pan gesture recognized by [`PanEventController`](@ref)", [
    :PAN_DIRECTION_DOWN,
    :PAN_DIRECTION_LEFT,
    :PAN_DIRECTION_RIGHT,
    :PAN_DIRECTION_UP
])
@document PAN_DIRECTION_DOWN "Pan up-down"
@document PAN_DIRECTION_LEFT "Pan left-right"
@document PAN_DIRECTION_RIGHT "Pan right-left"
@document PAN_DIRECTION_UP "Pen down-up"

@document PropagationPhase enum_docs(:PropagationPhase,
    "Determines at which part during the main loop event propgataion an event controller will consume the event, cf. https://developer-old.gnome.org/gtk4/stable/event-propagation.html", [
    :PROPAGATION_PHASE_BUBBLE,
    :PROPAGATION_PHASE_CAPTURE,
    :PROPAGATION_PHASE_NONE,
    :PROPAGATION_PHASE_TARGET
])
@document PROPAGATION_PHASE_BUBBLE "Consume event during propagation \"upwards\", from child to parent"
@document PROPAGATION_PHASE_CAPTURE "Consume event during progagation \"downwards\", from parent to child"
@document PROPAGATION_PHASE_NONE "Do not capture events"
@document PROPAGATION_PHASE_TARGET "Consume events when the widget targets its event controllers with events"

@document RelativePosition enum_docs(:RelativePosition,
    "Relative position of one object to another", [
    :RELATIVE_POSITION_ABOVE,
    :RELATIVE_POSITION_BELOW,
    :RELATIVE_POSITION_LEFT_OF,
    :RELATIVE_POSITION_RIGHT_OF
])
@document RELATIVE_POSITION_ABOVE "Object is above another"
@document RELATIVE_POSITION_BELOW "Object is below another"
@document RELATIVE_POSITION_LEFT_OF "Object is left of another"
@document RELATIVE_POSITION_RIGHT_OF "Object is right of another"

@document RevealerTransitionType enum_docs(:RevealerTransitionType,
    "Determines animation type when of [`Revealer`] showing or hiding its child", [
    :REVEALER_TRANSITION_TYPE_CROSSFADE,
    :REVEALER_TRANSITION_TYPE_NONE,
    :REVEALER_TRANSITION_TYPE_SLIDE_DOWN,
    :REVEALER_TRANSITION_TYPE_SLIDE_LEFT,
    :REVEALER_TRANSITION_TYPE_SLIDE_RIGHT,
    :REVEALER_TRANSITION_TYPE_SLIDE_UP,
    :REVEALER_TRANSITION_TYPE_SWING_DOWN,
    :REVEALER_TRANSITION_TYPE_SWING_LEFT,
    :REVEALER_TRANSITION_TYPE_SWING_RIGHT,
    :REVEALER_TRANSITION_TYPE_SWING_UP
])
@document REVEALER_TRANSITION_TYPE_CROSSFADE "Crossfade, slowly increasing / decreasing opacity"
@document REVEALER_TRANSITION_TYPE_NONE "Instantly reveal the widget"
@document REVEALER_TRANSITION_TYPE_SLIDE_DOWN "Slide from top to bottom"
@document REVEALER_TRANSITION_TYPE_SLIDE_LEFT "Slide from right to left"
@document REVEALER_TRANSITION_TYPE_SLIDE_RIGHT "Slide from left to right"
@document REVEALER_TRANSITION_TYPE_SLIDE_UP "Slide from bottom to top"
@document REVEALER_TRANSITION_TYPE_SWING_DOWN "Swing from top to bottom"
@document REVEALER_TRANSITION_TYPE_SWING_LEFT "Swing from right to left"
@document REVEALER_TRANSITION_TYPE_SWING_RIGHT "Swing from left to right"
@document REVEALER_TRANSITION_TYPE_SWING_UP "Swing from bottom to top"

@document ScrollType enum_docs(:ScrollType,
    "Classification of keyboard event that triggered the `scroll_child` event of a [`Viewport`](@ref)", [
    :SCROLL_TYPE_JUMP,
    :SCROLL_TYPE_NONE,
    :SCROLL_TYPE_PAGE_BACKWARD,
    :SCROLL_TYPE_PAGE_DOWN,
    :SCROLL_TYPE_PAGE_FORWARD,
    :SCROLL_TYPE_PAGE_LEFT,
    :SCROLL_TYPE_PAGE_RIGHT,
    :SCROLL_TYPE_PAGE_UP,
    :SCROLL_TYPE_SCROLL_END,
    :SCROLL_TYPE_SCROLL_START,
    :SCROLL_TYPE_STEP_BACKWARD,
    :SCROLL_TYPE_STEP_DOWN,
    :SCROLL_TYPE_STEP_FORWARD,
    :SCROLL_TYPE_STEP_LEFT,
    :SCROLL_TYPE_STEP_RIGHT,
    :SCROLL_TYPE_STEP_UP
])
@document SCROLL_TYPE_JUMP "Jump keybinding, if present"
@document SCROLL_TYPE_NONE "No keybinding was used"
@document SCROLL_TYPE_PAGE_BACKWARD "Move one page backwards"
@document SCROLL_TYPE_PAGE_DOWN "Move one page vertically down"
@document SCROLL_TYPE_PAGE_FORWARD "Move one page forward"
@document SCROLL_TYPE_PAGE_LEFT "Move one page vertically left"
@document SCROLL_TYPE_PAGE_RIGHT "Move one page horizontally right"
@document SCROLL_TYPE_PAGE_UP "Move one page vetically up"
@document SCROLL_TYPE_SCROLL_END "Jump to the end"
@document SCROLL_TYPE_SCROLL_START "Jump to the start"
@document SCROLL_TYPE_STEP_BACKWARD "Move one scroll step backwards"
@document SCROLL_TYPE_STEP_DOWN "Move one scroll step vertically down"
@document SCROLL_TYPE_STEP_FORWARD "Move on scroll step forward"
@document SCROLL_TYPE_STEP_LEFT "Move one scroll step horizontally left"
@document SCROLL_TYPE_STEP_RIGHT "Move one scroll step horizontally right"
@document SCROLL_TYPE_STEP_UP "Move on scroll step vertically up"

@document ScrollbarVisibilityPolicy enum_docs(:ScrollbarVisibilityPolicy,
    "Determines when / if a scrollbar of a [`Viewport`](@ref) reveals itself", [
    :SCROLLBAR_VISIBILITY_POLICY_ALWAYS,
    :SCROLLBAR_VISIBILITY_POLICY_AUTOMATIC,
    :SCROLLBAR_VISIBILITY_POLICY_NEVER
])
@document SCROLLBAR_VISIBILITY_POLICY_ALWAYS "Stay revealed at all times"
@document SCROLLBAR_VISIBILITY_POLICY_AUTOMATIC "Reveal when the users cursor enters the [`Viewport`](@ref), hide when it exits"
@document SCROLLBAR_VISIBILITY_POLICY_NEVER "Stay hidden at all times"

@document SectionFormat enum_docs(:SectionFormat,
    "Visual layout of a [`MenuModel`](@ref) \"section\"-type item", [
    :SECTION_FORMAT_CIRCULAR_BUTTONS,
    :SECTION_FORMAT_HORIZONTAL_BUTTONS,
    :SECTION_FORMAT_HORIZONTAL_BUTTONS_LEFT_TO_RIGHT,
    :SECTION_FORMAT_HORIZONTAL_BUTTONS_RIGHT_TO_LEFT,
    :SECTION_FORMAT_INLINE_BUTTONS,
    :SECTION_FORMAT_NORMAL
])
@document SECTION_FORMAT_CIRCULAR_BUTTONS "Circular buttons"
@document SECTION_FORMAT_HORIZONTAL_BUTTONS "Rectangular buttons"
@document SECTION_FORMAT_HORIZONTAL_BUTTONS_LEFT_TO_RIGHT "Rectangular buttons, pushed to the left"
@document SECTION_FORMAT_HORIZONTAL_BUTTONS_RIGHT_TO_LEFT "Rectangular buttons, pushed to the right"
@document SECTION_FORMAT_INLINE_BUTTONS "Buttons are appeneded right of the section title"
@document SECTION_FORMAT_NORMAL "Default layout"

@document SelectionMode enum_docs(:SelectionMode,
    "Governs if and how many elements can be selected", [
    :SELECTION_MODE_MULTIPLE,
    :SELECTION_MODE_NONE,
    :SELECTION_MODE_SINGLE
])
@document SELECTION_MODE_MULTIPLE "Zero or more widgets can be selected"
@document SELECTION_MODE_NONE "Exactly zero widgets can be selected"
@document SELECTION_MODE_SINGLE "Exactly one widget can be selected"

@document ShaderType enum_docs(:ShaderType,
    "Type of OpenGL shader", [
    :SHADER_TYPE_FRAGMENT,
    :SHADER_TYPE_VERTEX
])
@document SHADER_TYPE_FRAGMENT "Fragment shader"
@document SHADER_TYPE_VERTEX "Vertex shader"

@document ShortcutScope enum_docs(:ShortcutScope,
    "Determines at which scope a shortcut will be captured", [
    :SHORTCUT_SCOPE_GLOBAL,
    :SHORTCUT_SCOPE_LOCAL
    #:SHORTCUT_SCOPE_MANAGED
])
@document SHORTCUT_SCOPE_GLOBAL "If the most top-level parent of the widget holds focus, the shortcut is captured"
@document SHORTCUT_SCOPE_LOCAL "If the widget the event controller was added to holds focus, the shortcut is captured"
# @document SHORTCUT_SCOPE_MANAGED ""

@document StackTransitionType enum_docs(:StackTransitionType,
    "Determines animation that plays when a [`Stack`](@ref) switches from one of its pages to another", [
    :STACK_TRANSITION_TYPE_CROSSFADE,
    :STACK_TRANSITION_TYPE_NONE,
    :STACK_TRANSITION_TYPE_OVER_DOWN,
    :STACK_TRANSITION_TYPE_OVER_LEFT,
    :STACK_TRANSITION_TYPE_OVER_LEFT_RIGHT,
    :STACK_TRANSITION_TYPE_OVER_RIGHT,
    :STACK_TRANSITION_TYPE_OVER_UP,
    :STACK_TRANSITION_TYPE_OVER_UP_DOWN,
    :STACK_TRANSITION_TYPE_ROTATE_LEFT,
    :STACK_TRANSITION_TYPE_ROTATE_LEFT_RIGHT,
    :STACK_TRANSITION_TYPE_ROTATE_RIGHT,
    :STACK_TRANSITION_TYPE_SLIDE_DOWN,
    :STACK_TRANSITION_TYPE_SLIDE_LEFT,
    :STACK_TRANSITION_TYPE_SLIDE_LEFT_RIGHT,
    :STACK_TRANSITION_TYPE_SLIDE_RIGHT,
    :STACK_TRANSITION_TYPE_SLIDE_UP,
    :STACK_TRANSITION_TYPE_SLIDE_UP_DOWN,
    :STACK_TRANSITION_TYPE_UNDER_DOWN,
    :STACK_TRANSITION_TYPE_UNDER_LEFT,
    :STACK_TRANSITION_TYPE_UNDER_RIGHT,
    :STACK_TRANSITION_TYPE_UNDER_UP
])
@document STACK_TRANSITION_TYPE_CROSSFADE "Crossfade, slowly increasing opacity"
@document STACK_TRANSITION_TYPE_NONE "Instantly transition"
@document STACK_TRANSITION_TYPE_OVER_DOWN "Slide next page over current, from top to bottom"
@document STACK_TRANSITION_TYPE_OVER_LEFT "Slide next page over current, from right to left"
@document STACK_TRANSITION_TYPE_OVER_LEFT_RIGHT "Slide next page over current, exiting left and entering right"
@document STACK_TRANSITION_TYPE_OVER_RIGHT "Slide next page over current, from left to right"
@document STACK_TRANSITION_TYPE_OVER_UP "Slide next page over current, from bottom to top"
@document STACK_TRANSITION_TYPE_OVER_UP_DOWN "Slide next page over current, exiting up and entering bottom"
@document STACK_TRANSITION_TYPE_ROTATE_LEFT "Rotate the previous page from right to left, then enter the next page from right to left"
@document STACK_TRANSITION_TYPE_ROTATE_LEFT_RIGHT "Rotate the pervious page to the right to left, then enter next next page from left to right"
@document STACK_TRANSITION_TYPE_ROTATE_RIGHT "Rotate the previous page from left to right, then enter the next page from left to right"
@document STACK_TRANSITION_TYPE_SLIDE_DOWN "Slide the current page top to bottom, enter the next page from top to bottom"
@document STACK_TRANSITION_TYPE_SLIDE_LEFT "Slide the current page right to left, enter the next page from right to left"
@document STACK_TRANSITION_TYPE_SLIDE_LEFT_RIGHT "Slide the current page left, enter the next page from left to right"
@document STACK_TRANSITION_TYPE_SLIDE_RIGHT "Slide the current page left to right, enter the next page left to right"
@document STACK_TRANSITION_TYPE_SLIDE_UP "Slide the current page bottom to top, enter the next page bottom to top"
@document STACK_TRANSITION_TYPE_SLIDE_UP_DOWN "Slide the current page bottom top top, enter next bage top to bottom"
@document STACK_TRANSITION_TYPE_UNDER_DOWN "Slide next page under current, from top to bottom"
@document STACK_TRANSITION_TYPE_UNDER_LEFT "Slide next page under current, from left to right"
@document STACK_TRANSITION_TYPE_UNDER_RIGHT "Slide next page under current, from right to left"
@document STACK_TRANSITION_TYPE_UNDER_UP "Slide next page under current, from bottom to top"

@document TextureScaleMode enum_docs(:TextureScaleMode,
    "Determines how [`Texture`](@ref) filters when scaled", [
    :TEXTURE_SCALE_MODE_LINEAR,
    :TEXTURE_SCALE_MODE_NEAREST
])
@document TEXTURE_SCALE_MODE_LINEAR "Linear interpolation"
@document TEXTURE_SCALE_MODE_NEAREST "Nearest-neighbor interploation"

@document TextureWrapMode enum_docs(:TextureWrapMode,
    "Determines content of fragments with a texture coordinate outside of `[0, 1]`", [
    :TEXTURE_WRAP_MODE_MIRROR,
    :TEXTURE_WRAP_MODE_ONE,
    :TEXTURE_WRAP_MODE_REPEAT,
    :TEXTURE_WRAP_MODE_STRETCH,
    :TEXTURE_WRAP_MODE_ZERO
])
@document TEXTURE_WRAP_MODE_MIRROR "Mirror along the closest edge"
@document TEXTURE_WRAP_MODE_ONE "RGBA(1, 1, 1, 1)"
@document TEXTURE_WRAP_MODE_REPEAT "Repeat along the closest edge"
@document TEXTURE_WRAP_MODE_STRETCH "Stretch the outermost fragment of the closest edge"
@document TEXTURE_WRAP_MODE_ZERO "RGBA(0, 0, 0, 0)"

@document Theme enum_docs(:Theme,
    "Determines the look of all widgets when made active using `Application`s `set_current_theme!`."
    :THEME_DEFAULT_LIGHT,
    :THEME_DEFAULT_DARK,
    :THEME_HIGH_CONTRAST_LIGHT,
    :THEME_HIGH_CONTRAST_DARK
)

@document THEME_DEFAULT_LIGHT "Default light theme, this theme is available for all operating systems."
@document THEME_DEFAULT_DARK "Default dark theme, this theme is available for all operating systems."
@document THEME_HIGH_CONTRAST_LIGHT "Default high contrast theme, light variant. Not all operating systems support this."
@document THEME_HIGH_CONTRAST_DARK "Default high contrast theme, dark variant. Not all operating systems support this."

@document TickCallbackResult enum_docs(:TickCallbackResult,
    "Return value of a callback registered via [`set_tick_callback!`](@ref). Determines whether the callback should be removed.", [
    :TICK_CALLBACK_RESULT_CONTINUE,
    :TICK_CALLBACK_RESULT_DISCONTINUE
])
@document TICK_CALLBACK_RESULT_CONTINUE "Continue the callback, it will be invoked the next frame"
@document TICK_CALLBACK_RESULT_DISCONTINUE "Remove the callback, it will not longer be invoked"

@document ToolType enum_docs(:ToolType,
    "Tool type classification of a stylus, not all manufactures support all or even any of these.", [
    :TOOL_TYPE_AIRBRUSH,
    :TOOL_TYPE_BRUSH,
    :TOOL_TYPE_ERASER,
    :TOOL_TYPE_LENS,
    :TOOL_TYPE_MOUSE,
    :TOOL_TYPE_PEN,
    :TOOL_TYPE_PENCIL,
    :TOOL_TYPE_UNKNOWN
])
@document TOOL_TYPE_AIRBRUSH "Airbrush tool"
@document TOOL_TYPE_BRUSH "Variable-width brush"
@document TOOL_TYPE_ERASER "Erase tool"
@document TOOL_TYPE_LENS "Zoom tool"
@document TOOL_TYPE_MOUSE "Cursor tol"
@document TOOL_TYPE_PEN "Basic pen tool"
@document TOOL_TYPE_PENCIL "Fixed-width brush"
@document TOOL_TYPE_UNKNOWN "None of the other values of `ToolType`"

@document WindowCloseRequestResult enum_docs(:WindowCloseRequestResult,
    "Return value of signal `close_request` of [`Window`](@ref). Determines whether the window should close when requested to.", [
    :WINDOW_CLOSE_REQUEST_RESULT_ALLOW_CLOSE,
    :WINDOW_CLOSE_REQUEST_RESULT_PREVENT_CLOSE
])
@document WINDOW_CLOSE_REQUEST_RESULT_ALLOW_CLOSE "Allow invocation of the default handler, the window will close."
@document WINDOW_CLOSE_REQUEST_RESULT_PREVENT_CLOSE "Prevent the window from closing."

