const style_target_descriptors = Dict([
    :STYLE_TARGET_ACTION_BAR => "`ActionBar` widget",
    :STYLE_TARGET_ACTION_BAR_BOX_END => "`ActionBar` back area, populated with `push_back!`",
    :STYLE_TARGET_ACTION_BAR_BOX_START => "`ActionBar` front area, populated with `push_front`",
    :STYLE_TARGET_ASPECT_FRAME => "`AspectFrame` widget",
    :STYLE_TARGET_BOX => "`Box` widget",
    :STYLE_TARGET_BUTTON => "`Button` widget",
    :STYLE_TARGET_BUTTON_PRESSED => "`Button`, while depressed",
    :STYLE_TARGET_CENTER_BOX => "`CenterBox` widget",
    :STYLE_TARGET_CHECK_BUTTON => "`CheckButton` widget",
    :STYLE_TARGET_CHECK_BUTTON_CHECK_MARK_ACTIVE => "`CheckButton` icon while state is `ACTIVE`",
    :STYLE_TARGET_CHECK_BUTTON_CHECK_MARK_INACTIVE => "`CheckButton` icon while state is `INACTIVE`",
    :STYLE_TARGET_CHECK_BUTTON_CHECK_MARK_INCONSISTENT => "`CheckButton` icon while state is `INCONSISTENT`",
    :STYLE_TARGET_CLAMP_FRAME => "`ClampFrame` widget",
    :STYLE_TARGET_COLUMN_VIEW => "`ColumnView` widget",
    :STYLE_TARGET_DROP_DOWN => "`DropDown` widget",
    :STYLE_TARGET_ENTRY => "`Entry` widget",
    :STYLE_TARGET_ENTRY_TEXT => "Text area of an `Entry`",
    :STYLE_TARGET_EXPANDER => "`Expander` widget",
    :STYLE_TARGET_EXPANDER_TITLE => "`Expander` label, set with `set_label_widget!`",
    :STYLE_TARGET_EXPANDER_TITLE_ARROW => "Indicator arrow next to `Expander`s label",
    :STYLE_TARGET_FLOW_BOX => "`FlowBox` widget",
    :STYLE_TARGET_FLOW_BOX_CHILD => "Child of a `FlowBox`",
    :STYLE_TARGET_FRAME => "`Frame` widget",
    :STYLE_TARGET_GRID => "`Grid` widget",
    :STYLE_TARGET_GRID_VIEW => "`GridView` widget",
    :STYLE_TARGET_GRID_VIEW_CHILDREN => "Child of a `GridView`",
    :STYLE_TARGET_GRID_VIEW_NOT_SELECTED => "Child of a 'GridView` that  not currently selected",
    :STYLE_TARGET_GRID_VIEW_SELECTED => "Child of a `GridView` that is currently selected",
    :STYLE_TARGET_HEADER_BAR => "`HeaderBar` widget",
    :STYLE_TARGET_IMAGE_DISPLAY => "`ImageDisplay` widget",
    :STYLE_TARGET_LABEL => "`Label` widget",
    :STYLE_TARGET_LEVEL_BAR => "`LevelBar` widget",
    :STYLE_TARGET_LEVEL_BAR_BLOCK_LOW => "Colored area of `LevelBar` while below 25%",
    :STYLE_TARGET_LEVEL_BAR_BLOCK_HIGH => "Colored area of `LevelBar` while between 25% and 75%",
    :STYLE_TARGET_LEVEL_BAR_BLOCK_FULL => "Colored area of `LevelBar` while above 75%",
    :STYLE_TARGET_LEVEL_BAR_TROUGH => "Backdrop of `LevelBar`",
    :STYLE_TARGET_LIST_VIEW => "`ListView` widget",
    :STYLE_TARGET_LIST_VIEW_CHILDREN => "Child of `ListView`",
    :STYLE_TARGET_LIST_VIEW_NOT_SELECTED => "Child of `ListView` that is not currently selected",
    :STYLE_TARGET_LIST_VIEW_SELECTED => "Any child of `ListView` that is currently selected",
    :STYLE_TARGET_MENU_BAR => "`MenuBar` widget",
    :STYLE_TARGET_MENU_BAR_DISABLED_ITEM => "Disabled items of `MenuBar`",
    :STYLE_TARGET_MENU_BAR_ITEM => "Items of `MenuBar`",
    :STYLE_TARGET_MENU_BAR_SELECTED_ITEM => "Highlighted items of `MenuBar",
    :STYLE_TARGET_NOTEBOOK => "`Notebook` widget",
    :STYLE_TARGET_NOTEBOOK_SELECTED_TAB => "Currently active tab of `Notebook`",
    :STYLE_TARGET_NOTEBOOK_TABS => "All tabs of `Notebook`",
    :STYLE_TARGET_OVERLAY => "`Overlay` widget",
    :STYLE_TARGET_PANED => "`Paned` widget",
    :STYLE_TARGET_PANED_END_CHILD => "Child of `Paned`, set with `set_end_child!`",
    :STYLE_TARGET_PANED_HANDLE => "Handle of `Paned`",
    :STYLE_TARGET_PANED_START_CHILD => "Child of a `Paned`, set with `set_start_child!`",
    :STYLE_TARGET_POPOVER => "`Popover` widget",
    :STYLE_TARGET_POPOVER_ARROW => "Triangular arrow pointing to `Popover`s anchor",
    :STYLE_TARGET_POPOVER_BUTTON => "`PopoverButton` widget",
    :STYLE_TARGET_POPOVER_BUTTON_INDICATOR => "Indicator arrow next to `PopoverButton`s label",
    :STYLE_TARGET_POPOVER_MENU => "`PopoverMenu` widget",
    :STYLE_TARGET_POPOVER_MENU_ARROW => "The triangular arrow pointing to `PopoverMenu`s anchor",
    :POPUP_MESSAGE_OVERLAY => "`PopupMessageOverlay` widget",
    :POPUP_MESSAGE_OVERLAY_POPUP_MESSAGE => "Widget of shown `PopupMessage`",
    :POPUP_MESSAGE_OVERLAY_POPUP_MESSAGE_CONTENT => "Label area of of shown `PopupMessage`",
    :POPUP_MESSAGE_OVERLAY_POPUP_MESSAGE_ACTION_BUTTON => "Optional button of shown `PopupMessage`",
    :POPUP_MESSAGE_OVERLAY_POPUP_MESSAGE_CLOSE_BUTTON => "\"close\" button of shown `PopupMessage`",
    :STYLE_TARGET_PROGRESS_BAR => "`ProgressBar` widget",
    :STYLE_TARGET_PROGRESS_BAR_DURING_PULSE => "`ProgressBar` while the `pulse` animation is active",
    :STYLE_TARGET_PROGRESS_BAR_EMPTY => "`ProgressBar` colored area while at 0%",
    :STYLE_TARGET_PROGRESS_BAR_FULL => "`ProgressBar` colored area while at 100%",
    :STYLE_TARGET_PROGRESS_BAR_TEXT => "`ProgressBar` text or percentage",
    :STYLE_TARGET_PROGRESS_BAR_TROUGH => "Area behind `ProgressBar`s colored area",
    :STYLE_TARGET_REVEALER => "`Revealer` widget",
    :STYLE_TARGET_SCALE => "`Scale` widget",
    :STYLE_TARGET_SCALE_SLIDER => "Moving element of a `Scale`",
    :STYLE_TARGET_SCALE_TROUGH => "Rail along which `Scale`s slider moves",
    :STYLE_TARGET_SCALE_TROUGH_FILL => "Colored area of the `Scale`s rail",
    :STYLE_TARGET_SCALE_VALUE_TEXT => "Text of `Scale` shown with `set_should_draw_value!`",
    :STYLE_TARGET_SCOLLBAR_SLIDER => "Moving element of a `Scrollbar`",
    :STYLE_TARGET_SCROLLBAR => "`Scrollbar` widget",
    :STYLE_TARGET_SCROLLBAR_TROUGH => "Rail along which `Scrollbar`s sliders moves",
    :STYLE_TARGET_SELF => "Wildcard, matches all nodes of the style class",
    :STYLE_TARGET_SEPARATOR => "`Separator` widget",
    :STYLE_TARGET_SPIN_BUTTON => "`SpinButton` widget",
    :STYLE_TARGET_SPIN_BUTTON_BUTTON_DECREASE => "`+` button of a `SpinButton`",
    :STYLE_TARGET_SPIN_BUTTON_BUTTON_INCREASE => "`-` button of a `SpinButton`",
    :STYLE_TARGET_SPIN_BUTTON_TEXT => "Text in entry area of `SpinButton`",
    :STYLE_TARGET_SPINNER => "`Spinner` widget",
    :STYLE_TARGET_STACK => "`Stack` widget",
    :STYLE_TARGET_STACK_SIDEBAR => "`StackSidebar` widget",
    :STYLE_TARGET_STACK_SWITCHER => "`StackSwitcher` widget",
    :STYLE_TARGET_SWITCH => "`Switch` widget",
    :STYLE_TARGET_SWITCH_ACTIVE => "`Switch` while active",
    :STYLE_TARGET_SWITCH_NOT_ACTIVE => "`Switch` while inactive",
    :STYLE_TARGET_SWITCH_SLIDER => "Moving element of `Switch`",
    :STYLE_TARGET_TEXT_VIEW => "`TextView` widget",
    :STYLE_TARGET_TEXT_VIEW_TEXT => "`TextView` text entry area",
    :STYLE_TARGET_TEXT_ENTRY => "Any text entry area of a widget",
    :STYLE_TARGET_TEXT_SELECTION => "Colored text selection",
    :STYLE_TARGET_TOGGLE_BUTTON => "`ToggleButton` widget",
    :STYLE_TARGET_TOGGLE_BUTTON_ACTIVE => "`ToggleButton` while active",
    :STYLE_TARGET_TOGGLE_BUTTON_NOT_ACTIVE => "`ToggleButton` while inactive",
    :STYLE_TARGET_TRANSFORM_BIN => "`TransformBin` widget",
    :STYLE_TARGET_VIEWPORT => "`Viewport` widget",
    :STYLE_TARGET_VIEWPORT_HORIZONTAL_SCROLLBAR_SLIDER => "Slider of horizontal `ScrollBar` of a `Viewport`",
    :STYLE_TARGET_VIEWPORT_HORIZONTAL_SCROLLBAR => "Horizontal `ScrollBar` of `Viewport`",
    :STYLE_TARGET_VIEWPORT_HORIZONTAL_SCROLLBAR_TROUGH => "Rail of horzontal `Scrollbar` of `Viewport`",
    :STYLE_TARGET_VIEWPORT_VERTICAL_SCROLLBAR_SLIDER => "Slider of vertical `ScrollBar` of `Viewport`",
    :STYLE_TARGET_VIEWPORT_VERTICAL_SCROLLBAR => "Vertical `ScrollBar` of `Viewport`",
    :STYLE_TARGET_VIEWPORT_VERTICAL_SCROLLBAR_TROUGH => "Rail of vertical `ScrollBar` of `Viewport`",
    :STYLE_TARGET_WIDGET => "Any `Widget`",
    :STYLE_TARGET_WINDOW => "`Window` widget"
])

for pair in style_target_descriptors
    id = pair[1]
    text = """
    # `$id` <: StyleClassTarget

    $(pair[2]).
    """
    eval(:(@document $id $text))
end

function style_property_table()
    ids = ["Name"]
    values = ["CSS Equivalent"]

    for symbol in Mousetrap.style_properties
        push!(ids, "`" * string(symbol) * "`")
        push!(values, getproperty(Mousetrap, symbol))
    end
    return Latexify.mdtable(ids, values; latex=false)
end

function style_target_list()
    out = "Available targets:"
    for target in Mousetrap.style_targets
        out = out * "+ `$target`\n"
    end
    return out
end

macro type_style_targets(nodes...)
    out = "## CSS Nodes\n"
    if !isempty(nodes)

        ids = ["StyleClassTarget"]
        values = ["Meaning"]
    
        for node in nodes 
            push!(ids, "`" * string(node) * "`")
            push!(values, style_target_descriptors[node])
        end

        out *= "$(Latexify.mdtable(ids, values; latex=false))"
    else
        out *= "(no public targets)\n"
    end
    return out
end

function css_property_table()

    print("| Mousetrap Constant | CSS Equivalent |\n")
    for sym in [
        :STYLE_PROPERTY_FOREGROUND_COLOR,
        :STYLE_PROPERTY_COLOR,
        :STYLE_PROPERTY_BACKGROUND_COLOR,
        :STYLE_PROPERTY_OPACITY,
        :STYLE_PROPERTY_FILTER,
        :STYLE_PROPERTY_FONT,
        :STYLE_PROPERTY_FONT_FAMILY,
        :STYLE_PROPERTY_FONT_SIZE,
        :STYLE_PROPERTY_FONT_STYLE,
        :STYLE_PROPERTY_FONT_WEIGHT,
        :STYLE_PROPERTY_FONT_TRANSFORM,
        :STYLE_PROPERTY_CARET_COLOR,
        :STYLE_PROPERTY_TEXT_DECORATION,
        :STYLE_PROPERTY_TEXT_DECORATION_COLOR,
        :STYLE_PROPERTY_TEXT_DECORATION_STYLE,
        :STYLE_PROPERTY_TEXT_SHADOW,
        :STYLE_PROPERTY_ICON_SIZE,
        :STYLE_PROPERTY_TRANSFORM,
        :STYLE_PROPERTY_TRANSFORM_ORIGIN,
        :STYLE_PROPERTY_BORDER,
        :STYLE_PROPERTY_BORDER_STYLE,
        :STYLE_PROPERTY_BORDER_COLOR,
        :STYLE_PROPERTY_BORDER_WIDTH,
        :STYLE_PROPERTY_BORDER_RADIUS,
        :STYLE_PROPERTY_BORDER_SPACING,
        :STYLE_PROPERTY_OUTLINE,
        :STYLE_PROPERTY_OUTLINE_STYLE,
        :STYLE_PROPERTY_OUTLINE_COLOR,
        :STYLE_PROPERTY_OUTLINE_WIDTH,
        :STYLE_PROPERTY_BOX_SHADOW,
        :STYLE_PROPERTY_BACKGROUND_CLIP,
        :STYLE_PROPERTY_BACKGROUND_ORIGIN,
        :STYLE_PROPERTY_BACKGROUND_SIZE,
        :STYLE_PROPERTY_BACKGROUND_POSITION,
        :STYLE_PROPERTY_BACKGROUND_REPEAT,
        :STYLE_PROPERTY_TRANSITION,
        :STYLE_PROPERTY_TRANSITION_PROPERTY,
        :STYLE_PROPERTY_TRANSITION_DURATION,
        :STYLE_PROPERTY_TRANSITION_TIMING_FUNCTION,
        :STYLE_PROPERTY_TRANSITION_DELAY,
        :STYLE_PROPERTY_ANIMATION,
        :STYLE_PROPERTY_ANIMATION_NAME,
        :STYLE_PROPERTY_ANIMATION_DURATION,
        :STYLE_PROPERTY_ANIMATION_TIMING_FUNCTION,
        :STYLE_PROPERTY_ANIMATION_ITERATION_COUNT,
        :STYLE_PROPERTY_ANIMATION_DIRECTION,
        :STYLE_PROPERTY_ANIMATION_PLAY_STATE,
        :STYLE_PROPERTY_ANIMATION_DELAY,
        :STYLE_PROPERTY_ANIMATION_FILL_MODE
    ]
        css = getproperty(Mousetrap, sym)
        println("| `$sym` | [`$css`](https://developer.mozilla.org/en-US/docs/Web/CSS/$css) |")
    end
end