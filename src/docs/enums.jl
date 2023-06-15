const _generate_enum_docs = quote 
    for enum_name in mousetrap.enums
        enum = getproperty(mousetrap, enum_name)
        values = []
        for value_name in mousetrap.enum_values
            if typeof(getproperty(mousetrap, value_name)) <: enum
                push!(values, value_name)
            end
        end

        value_string = ""
        for i in 1:length(values)
            value_string *= "    " * string(values[i])
            if i != length(values)
                value_string *= ","
            end
            value_string *= "\n"
        end
        
        println("""
        @document $enum_name enum_docs(:$enum_name,
            "TODO", [
        $value_string
        ])
        """)
    end
end

@document Alignment enum_docs(:Alignment,
    "Determines where a widget is positioned when inside a container widget", [
    ALIGNMENT_CENTER,
    ALIGNMENT_END,
    ALIGNMENT_START

])

@document BlendMode enum_docs(:BlendMode,
    "OpenGL blend mode, governs how the result of rendering one fragment on top of another", [
    BLEND_MODE_ADD,
    BLEND_MODE_MAX,
    BLEND_MODE_MIN,
    BLEND_MODE_MULTIPLY,
    BLEND_MODE_NONE,
    BLEND_MODE_REVERSE_SUBTRACT,
    BLEND_MODE_SUBTRACT

])

@document ButtonID enum_docs(:ButtonID,
    "Mouse button ID", [
    BUTTON_ID_ANY,
    BUTTON_ID_BUTTON_01,
    BUTTON_ID_BUTTON_02,
    BUTTON_ID_BUTTON_03,
    BUTTON_ID_BUTTON_04,
    BUTTON_ID_BUTTON_05,
    BUTTON_ID_BUTTON_06,
    BUTTON_ID_BUTTON_07,
    BUTTON_ID_BUTTON_08,
    BUTTON_ID_BUTTON_09,
    BUTTON_ID_NONE

])

@document CheckButtonState enum_docs(:CheckButtonState,
    "State of `CheckButton`, determines visual appearance of the checkmark element", [
    CHECK_BUTTON_STATE_ACTIVE,
    CHECK_BUTTON_STATE_INACTIVE,
    CHECK_BUTTON_STATE_INCONSISTENT

])

@document CornerPlacement enum_docs(:CornerPlacement,
    "Scrollbar placement relative to the center of a `Viewport`", [
    CORNER_PLACEMENT_BOTTOM_LEFT,
    CORNER_PLACEMENT_BOTTOM_RIGHT,
    CORNER_PLACEMENT_TOP_LEFT,
    CORNER_PLACEMENT_TOP_RIGHT

])

@document CursorType enum_docs(:CursorType,
    "Cursor type, determines shape of cursor when it is inside the corresponding widgets allocated area", [
    CURSOR_TYPE_ALL_SCROLL,
    CURSOR_TYPE_CELL,
    CURSOR_TYPE_COLUMN_RESIZE,
    CURSOR_TYPE_CONTEXT_MENU,
    CURSOR_TYPE_CROSSHAIR,
    CURSOR_TYPE_DEFAULT,
    CURSOR_TYPE_EAST_RESIZE,
    CURSOR_TYPE_GRAB,
    CURSOR_TYPE_GRABBING,
    CURSOR_TYPE_HELP,
    CURSOR_TYPE_MOVE,
    CURSOR_TYPE_NONE,
    CURSOR_TYPE_NORTH_EAST_RESIZE,
    CURSOR_TYPE_NORTH_RESIZE,
    CURSOR_TYPE_NORTH_WEST_RESIZE,
    CURSOR_TYPE_NOT_ALLOWED,
    CURSOR_TYPE_POINTER,
    CURSOR_TYPE_PROGRESS,
    CURSOR_TYPE_ROW_RESIZE,
    CURSOR_TYPE_SOUTH_EAST_RESIZE,
    CURSOR_TYPE_SOUTH_RESIZE,
    CURSOR_TYPE_SOUTH_WEST_RESIZE,
    CURSOR_TYPE_TEXT,
    CURSOR_TYPE_WAIT,
    CURSOR_TYPE_WEST_RESIZE,
    CURSOR_TYPE_ZOOM_IN,
    CURSOR_TYPE_ZOOM_OUT

])

@document DeviceAxis enum_docs(:DeviceAxis,
    "Stylus / Touchpad device axes. Not all models support all or even any of these.", [
    DEVICE_AXIS_DELTA_X,
    DEVICE_AXIS_DELTA_Y,
    DEVICE_AXIS_DISTANCE,
    DEVICE_AXIS_PRESSURE,
    DEVICE_AXIS_ROTATION,
    DEVICE_AXIS_SLIDER,
    DEVICE_AXIS_WHEEL,
    DEVICE_AXIS_X,
    DEVICE_AXIS_X_TILT,
    DEVICE_AXIS_Y,
    DEVICE_AXIS_Y_TILT

])

@document EllipsizeMode enum_docs(:EllipsizeMode,
    "Determines where an ellipses (`...`) is placed when the allocated widget of label is less than its natural width.", [
    ELLIPSIZE_MODE_END,
    ELLIPSIZE_MODE_MIDDLE,
    ELLIPSIZE_MODE_NONE,
    ELLIPSIZE_MODE_START

])

@document FileChooserAction enum_docs(:FileChooserAction,
    "`FileChooser` mode, determines layout and which items can be selected.", [
    FILE_CHOOSER_ACTION_OPEN_FILE,
    FILE_CHOOSER_ACTION_OPEN_MULTIPLE_FILES,
    FILE_CHOOSER_ACTION_SAVE,
    FILE_CHOOSER_ACTION_SELECT_FOLDER,
    FILE_CHOOSER_ACTION_SELECT_MULTIPLE_FOLDERS

])

@document FileMonitorEvent enum_docs(:FileMonitorEvent,
    "Determines action that caused the `FileMonitor` to invoke its callback.", [
    FILE_MONITOR_EVENT_ATTRIBUTE_CHANGED,
    FILE_MONITOR_EVENT_CHANGED,
    FILE_MONITOR_EVENT_CHANGES_DONE_HINT,
    FILE_MONITOR_EVENT_CREATED,
    FILE_MONITOR_EVENT_DELETED,
    FILE_MONITOR_EVENT_MOVED_IN,
    FILE_MONITOR_EVENT_MOVED_OUT,
    FILE_MONITOR_EVENT_RENAMED

])

@document InterpolationType enum_docs(:InterpolationType,
    "Algorithm used when scaling `Image`", [
    INTERPOLATION_TYPE_BILINEAR,
    INTERPOLATION_TYPE_HYPERBOLIC,
    INTERPOLATION_TYPE_NEAREST,
    INTERPOLATION_TYPE_TILES

])

@document JustifyMode enum_docs(:JustifyMode,
    "Text justify mode, determines horizontal alignment of words.", [
    JUSTIFY_MODE_CENTER,
    JUSTIFY_MODE_FILL,
    JUSTIFY_MODE_LEFT,
    JUSTIFY_MODE_RIGHT

])

@document LabelWrapMode enum_docs(:LabelWrapMode,
    "Wrap mode, determines at which point in a line of a multi-line `Label` and linebreak is inserted", [
    LABEL_WRAP_MODE_NONE,
    LABEL_WRAP_MODE_ONLY_ON_CHAR,
    LABEL_WRAP_MODE_ONLY_ON_WORD,
    LABEL_WRAP_MODE_WORD_OR_CHAR

])

@document LevelBarMode enum_docs(:LevelBarMode,
    "Determines visual appearance of `LevelBar`", [
    LEVEL_BAR_MODE_CONTINUOUS,
    LEVEL_BAR_MODE_DISCRETE

])

@document Orientation enum_docs(:Orientation,
    "Orientation of a widget, determines its layout", [
    ORIENTATION_HORIZONTAL,
    ORIENTATION_VERTICAL

])

@document PanDirection enum_docs(:PanDirection,
    "Possible directions of panning, each `PanEventController` can only recognize gestures along the horizontal xor vertical axis.", [
    PAN_DIRECTION_DOWN,
    PAN_DIRECTION_LEFT,
    PAN_DIRECTION_RIGHT,
    PAN_DIRECTION_UP

])

@document ProgressBarDisplayMode enum_docs(:ProgressBarDisplayMode,
    "Sets whether `ProgressBar` should display custom text or the current percentage.", [
    PROGRESS_BAR_DISPLAY_MODE_SHOW_PERCENTAGE,
    PROGRESS_BAR_DISPLAY_MODE_SHOW_TEXT

])

@document PropagationPhase enum_docs(:PropagationPhase,
    "Determines at which part of event handling the `EventController` will consume its events.", [
    PROPAGATION_PHASE_BUBBLE,
    PROPAGATION_PHASE_CAPTURE,
    PROPAGATION_PHASE_NONE,
    PROPAGATION_PHASE_TARGET

])

@document RelativePosition enum_docs(:RelativePosition,
    "Relative position of a widget to another widget.", [
    RELATIVE_POSITION_ABOVE,
    RELATIVE_POSITION_BELOW,
    RELATIVE_POSITION_LEFT_OF,
    RELATIVE_POSITION_RIGHT_OF

])

@document RevealerTransitionType enum_docs(:RevealerTransitionType,
    "Type of animation used when `Revealer` shows or hides its child.", [
    REVEALER_TRANSITION_TYPE_CROSSFADE,
    REVEALER_TRANSITION_TYPE_NONE,
    REVEALER_TRANSITION_TYPE_SLIDE_DOWN,
    REVEALER_TRANSITION_TYPE_SLIDE_LEFT,
    REVEALER_TRANSITION_TYPE_SLIDE_RIGHT,
    REVEALER_TRANSITION_TYPE_SLIDE_UP,
    REVEALER_TRANSITION_TYPE_SWING_DOWN,
    REVEALER_TRANSITION_TYPE_SWING_LEFT,
    REVEALER_TRANSITION_TYPE_SWING_RIGHT,
    REVEALER_TRANSITION_TYPE_SWING_UP

])

@document ScrollType enum_docs(:ScrollType,
    "Keybinding event type that triggeered the `scroll_child` signal of `Viewport`", [
    SCROLL_TYPE_JUMP,
    SCROLL_TYPE_NONE,
    SCROLL_TYPE_PAGE_BACKWARD,
    SCROLL_TYPE_PAGE_DOWN,
    SCROLL_TYPE_PAGE_FORWARD,
    SCROLL_TYPE_PAGE_LEFT,
    SCROLL_TYPE_PAGE_RIGHT,
    SCROLL_TYPE_PAGE_UP,
    SCROLL_TYPE_SCROLL_END,
    SCROLL_TYPE_SCROLL_START,
    SCROLL_TYPE_STEP_BACKWARD,
    SCROLL_TYPE_STEP_DOWN,
    SCROLL_TYPE_STEP_FORWARD,
    SCROLL_TYPE_STEP_LEFT,
    SCROLL_TYPE_STEP_RIGHT,
    SCROLL_TYPE_STEP_UP

])

@document ScrollbarVisibilityPolicy enum_docs(:ScrollbarVisibilityPolicy,
    "Determines if or when each scrollbar of a `Viewport` should reveal themself.", [
    SCROLLBAR_VISIBILITY_POLICY_ALWAYS,
    SCROLLBAR_VISIBILITY_POLICY_AUTOMATIC,
    SCROLLBAR_VISIBILITY_POLICY_NEVER

])

@document SectionFormat enum_docs(:SectionFormat,
    "Visual layout of a \"section\" type menu model item.", [
    SECTION_FORMAT_CIRCULAR_BUTTONS,
    SECTION_FORMAT_HORIZONTAL_BUTTONS,
    SECTION_FORMAT_HORIZONTAL_BUTTONS_LEFT_TO_RIGHT,
    SECTION_FORMAT_HORIZONTAL_BUTTONS_RIGHT_TO_LEFT,
    SECTION_FORMAT_INLINE_BUTTONS,
    SECTION_FORMAT_NORMAL

])

@document SelectionMode enum_docs(:SelectionMode,
    "Determines how many children of a selectable widget can be marked as selected.", [
    SELECTION_MODE_MULTIPLE,
    SELECTION_MODE_NONE,
    SELECTION_MODE_SINGLE

])

@document ShaderType enum_docs(:ShaderType,
    "OpenGL shader type.", [
    SHADER_TYPE_FRAGMENT,
    SHADER_TYPE_VERTEX

])

@document ShortcutScope enum_docs(:ShortcutScope,
    "Determines whether a widget should also query its parents such that either can capture shortcut events.", [
    SHORTCUT_SCOPE_GLOBAL,
    SHORTCUT_SCOPE_LOCAL,
    SHORTCUT_SCOPE_MANAGED

])

@document StackTransitionType enum_docs(:StackTransitionType,
    "Animation used for when a stack transitions from one of its children to another", [
    STACK_TRANSITION_TYPE_CROSSFADE,
    STACK_TRANSITION_TYPE_NONE,
    STACK_TRANSITION_TYPE_OVER_DOWN,
    STACK_TRANSITION_TYPE_OVER_LEFT,
    STACK_TRANSITION_TYPE_OVER_LEFT_RIGHT,
    STACK_TRANSITION_TYPE_OVER_RIGHT,
    STACK_TRANSITION_TYPE_OVER_UP,
    STACK_TRANSITION_TYPE_OVER_UP_DOWN,
    STACK_TRANSITION_TYPE_ROTATE_LEFT,
    STACK_TRANSITION_TYPE_ROTATE_LEFT_RIGHT,
    STACK_TRANSITION_TYPE_ROTATE_RIGHT,
    STACK_TRANSITION_TYPE_SLIDE_DOWN,
    STACK_TRANSITION_TYPE_SLIDE_LEFT,
    STACK_TRANSITION_TYPE_SLIDE_LEFT_RIGHT,
    STACK_TRANSITION_TYPE_SLIDE_RIGHT,
    STACK_TRANSITION_TYPE_SLIDE_UP,
    STACK_TRANSITION_TYPE_SLIDE_UP_DOWN,
    STACK_TRANSITION_TYPE_UNDER_DOWN,
    STACK_TRANSITION_TYPE_UNDER_LEFT,
    STACK_TRANSITION_TYPE_UNDER_RIGHT,
    STACK_TRANSITION_TYPE_UNDER_UP

])

@document TextureScaleMode enum_docs(:TextureScaleMode,
    "OpenGL scale mode used when scaling `Texture`", [
    TEXTURE_SCALE_MODE_LINEAR,
    TEXTURE_SCALE_MODE_NEAREST

])

@document TextureWrapMode enum_docs(:TextureWrapMode,
    "OpenGL wrap mode, determines how a texture behaves when the texture cordinates of its shape are outside of [0, 1]", [
    TEXTURE_WRAP_MODE_MIRROR,
    TEXTURE_WRAP_MODE_ONE,
    TEXTURE_WRAP_MODE_REPEAT,
    TEXTURE_WRAP_MODE_STRETCH,
    TEXTURE_WRAP_MODE_ZERO

])

@document TickCallbackResult enum_docs(:TickCallbackResult,
    "Should the tick callback handle remove the tick callback when the connected function exists.", [
    TICK_CALLBACK_RESULT_CONTINUE,
    TICK_CALLBACK_RESULT_DISCONTINUE

])

@document ToolType enum_docs(:ToolType,
    "Mode selection of a touchpad stylus, not all manufactures support these.", [
    TOOL_TYPE_AIRBRUSH,
    TOOL_TYPE_BRUSH,
    TOOL_TYPE_ERASER,
    TOOL_TYPE_LENS,
    TOOL_TYPE_MOUSE,
    TOOL_TYPE_PEN,
    TOOL_TYPE_PENCIL,
    TOOL_TYPE_UNKNOWN

])

@document WindowCloseRequestResult enum_docs(:WindowCloseRequestResult,
    "Should the window handler be allowed to close the window once `close_request` exits", [
    WINDOW_CLOSE_REQUEST_RESULT_ALLOW_CLOSE,
    WINDOW_CLOSE_REQUEST_RESULT_PREVENT_CLOSE
])
