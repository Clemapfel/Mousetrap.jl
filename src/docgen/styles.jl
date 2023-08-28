const style_target_descriptors = Dict([
:STYLE_TARGET_ACTION_BAR => "`ActionBar` widget",
:STYLE_TARGET_ACTION_BAR_BOX_END => "`ActionBar` start area, populated with `push_back!`",
:STYLE_TARGET_ACTION_BAR_BOX_START => "`ActionBar` front area, populated with `push_front`",
:STYLE_TARGET_ASPECT_FRAME => "`AspectFrame` widget",
:STYLE_TARGET_BOX => "`Box` widget",
:STYLE_TARGET_BUTTON => "`Button` widget",
:STYLE_TARGET_BUTTON_PRESSED => "`Button` while depressed",
    :STYLE_TARGET_CENTER_BOX => "`CenterBox` widget",
    :STYLE_TARGET_CHECK_BUTTON => "`CheckButton` widget",
    :STYLE_TARGET_CHECK_BUTTON_CHECK_MARK_ACTIVE => "`CheckButton` icon while state is `CHECK_BUTTON_STATE_ACTIVE`",
    :STYLE_TARGET_CHECK_BUTTON_CHECK_MARK_INACTIVE => "`CheckButton` icon while state is `CHECK_BUTTON_STATE_INACTIVE`",
    :STYLE_TARGET_CHECK_BUTTON_CHECK_MARK_INCONSISTENT => "`CheckButton` icon while state is `CHECK_BUTTON_STATE_INCONSISTENT`",
    :STYLE_TARGET_CLAMP_FRAME => "`ClampFrame` widget",
    :STYLE_TARGET_COLUMN_VIEW => "`ColumnView` widget",
    :STYLE_TARGET_DROP_DOWN => "`DropDown` widget",
    :STYLE_TARGET_ENTRY => "`Entry` widget",
    :STYLE_TARGET_ENTRY_TEXT => "Text area of an `Entry`",
    :STYLE_TARGET_EXPANDER => "`Expander` widget",
    :STYLE_TARGET_EXPANDER_TITLE => "`Expander` label, set with `set_label_widget!`",
    :STYLE_TARGET_EXPANDER_TITLE_ARROW => "Indicator arrow next to the `Expander`s label widget",
    :STYLE_TARGET_FLOW_BOX => "`FlowBox` widget",
    :STYLE_TARGET_FLOW_BOX_CHILD => "Any child of a `FlowBox`",
    :STYLE_TARGET_FRAME => "`Frame` widget",
    :STYLE_TARGET_GRID => "`Grid` widget",
    :STYLE_TARGET_GRID_VIEW => "`GridView` widget",
    :STYLE_TARGET_GRID_VIEW_CHILDREN => "Any child of a `GridView`",
    :STYLE_TARGET_GRID_VIEW_NOT_SELECTED => "Any child of a 'GridView` that is not currently selected",
    :STYLE_TARGET_GRID_VIEW_SELECTED => "Any child of a `GridView` that is currently selected",
    :STYLE_TARGET_HEADER_BAR => "`HeaderBar` widget",
    :STYLE_TARGET_IMAGE_DISPLAY => "`ImageDisplay` widget",
    :STYLE_TARGET_LABEL => "`Label` widget",
    :STYLE_TARGET_LEVEL_BAR => "`LevelBar` widget",
    :STYLE_TARGET_LEVEL_BAR_BLOCK_LOW => "Colored area of a `LevelBar` while below 25%",
    :STYLE_TARGET_LEVEL_BAR_BLOCK_HIGH => "Colored area of a `LevelBar` while between 25% and 75%",
    :STYLE_TARGET_LEVEL_BAR_BLOCK_FULL => "Colored area of a `LevelBar` while above 75%",
    :STYLE_TARGET_LEVEL_BAR_TROUGH => "Shape behind the colored area of a `LevelBar`",
    :STYLE_TARGET_LIST_VIEW => "`ListView` widget",
    :STYLE_TARGET_LIST_VIEW_CHILDREN => "Any child of a `ListView`",
    :STYLE_TARGET_LIST_VIEW_NOT_SELECTED => "Any child of a `ListView` that is not currently selected",
    :STYLE_TARGET_LIST_VIEW_SELECTED => "Any child of a `ListView` that is currently selected",
    :STYLE_TARGET_MENU_BAR => "`MenuBar` widget",
    :STYLE_TARGET_MENU_BAR_DISABLED_ITEM => "Disabled items in the outermost `MenuModel` of a `MenuBar`",
    :STYLE_TARGET_MENU_BAR_ITEM => "Items in the outermost `MenuModel` of a `MenuBar`",
    :STYLE_TARGET_MENU_BAR_SELECTED_ITEM => "Highlighted items in the outermost `MenuModel` of a `MenuBar",
    :STYLE_TARGET_NOTEBOOK => "`Notebook` widget",
    :STYLE_TARGET_NOTEBOOK_SELECTED_TAB => "Currently active tab of a `Notebook`",
    :STYLE_TARGET_NOTEBOOK_TABS => "All tabs of a `Notebook`",
    :STYLE_TARGET_OVERLAY => "`Overlay` widget",
    :STYLE_TARGET_PANED => "`Paned` widget",
    :STYLE_TARGET_PANED_END_CHILD => "Child of `Paned` set with `set_end_child!`",
    :STYLE_TARGET_PANED_HANDLE => "Handle in-between the two children of a `Paned`",
    :STYLE_TARGET_PANED_START_CHILD => "Child of a `Paned` set with `set_start_child!`",
    :STYLE_TARGET_POPOVER => "`Popover` widget",
    :STYLE_TARGET_POPOVER_ARROW => "The triangular arrow pointing to a `Popover`s anchor widget",
    :STYLE_TARGET_POPOVER_BUTTON => "`PopoverButton` widget",
    :STYLE_TARGET_POPOVER_BUTTON_INDICATOR => "Indicator arrow next to a `PopoverButton`s label widget",
    :STYLE_TARGET_POPOVER_MENU => "`PopoverMenu` widget",
    :STYLE_TARGET_POPOVER_MENU_ARROW => "The triangular arrow pointing to a `PopoverMenu`s anchor widget",
    :POPUP_MESSAGE_OVERLAY => "`PopupMessageOverlay` widget",
    :POPUP_MESSAGE_OVERLAY_POPUP_MESSAGE => "Widget of a `PopupMessage` shown via `PopupMessageOverlay`",
    :POPUP_MESSAGE_OVERLAY_POPUP_MESSAGE_CONTENT => "Main label area of of a `PopupMessage` shown via `PopupMessageOverlay`",
    :POPUP_MESSAGE_OVERLAY_POPUP_MESSAGE_ACTION_BUTTON => "Optional button of a `PopupMessage` shown via `PopupMessageOverlay`",
    :POPUP_MESSAGE_OVERLAY_POPUP_MESSAGE_CLOSE_BUTTON => "Non-optional \"close\" button of a `PopupMessage` shown via `PopupMessageOverlay`",
    :STYLE_TARGET_PROGRESS_BAR => "`ProgressBar` widget",
    :STYLE_TARGET_PROGRESS_BAR_DURING_PULSE => "`ProgressBar` colored area while the `pulse` animation is active",
    :STYLE_TARGET_PROGRESS_BAR_EMPTY => "`ProgressBar` colored area while at 0%",
    :STYLE_TARGET_PROGRESS_BAR_FULL => "`ProgressBar` colored area while at 100%",
    :STYLE_TARGET_PROGRESS_BAR_TEXT => "`ProgressBar` text or precentage, only present if `set_show_text!` was set to `true`",
    :STYLE_TARGET_PROGRESS_BAR_TROUGH => "Area behind a `ProgressBar`s colored area",
    :STYLE_TARGET_REVEALER => "`Revealer` widget",
    :STYLE_TARGET_SCALE => "`Scale` widget",
    :STYLE_TARGET_SCALE_SLIDER => "Moving element of a `Sacle`",
    :STYLE_TARGET_SCALE_TROUGH => "Background \"rail\" along which the moving element of a `Scale` slides",
    :STYLE_TARGET_SCALE_TROUGH_FILL => "Colored area of the `Scale` that indicates the current level",
    :STYLE_TARGET_SCALE_VALUE_TEXT => "Text of a `Scale` for whom `set_should_draw_value!` was set to `true`",
    :STYLE_TARGET_SCOLLBAR_SLIDER => "Moving element of a `Scrollbar`",
    :STYLE_TARGET_SCROLLBAR => "`Scrollbar` widget",
    :STYLE_TARGET_SCROLLBAR_TROUGH => "Background \"rail\" along which the moving element of a `Scrollbar` slides",
    :STYLE_TARGET_SELF => "Wildcard, matches all nodes of the style class",
    :STYLE_TARGET_SEPARATOR => "`Separator` widget",
    :STYLE_TARGET_SPIN_BUTTON => "`SpinButton` widget",
    :STYLE_TARGET_SPIN_BUTTON_BUTTON_DECREASE => "`+` button of a `SpinButton`",
    :STYLE_TARGET_SPIN_BUTTON_BUTTON_INCREASE => "`-` button of a `SpinButton`",
    :STYLE_TARGET_SPIN_BUTTON_TEXT => "Text in the text-entry area of a `SpinButton`",
    :STYLE_TARGET_SPINNER => "`Spinner` widget",
    :STYLE_TARGET_STACK => "`Stack` widget",
    :STYLE_TARGET_STACK_SIDEBAR => "`StackSidebar` widget",
    :STYLE_TARGET_STACK_SWITCHER => "`StackSwitcher` widget",
    :STYLE_TARGET_SWITCH => "`Switch` widget",
    :STYLE_TARGET_SWITCH_ACTIVE => "`Switch` while `get_is_active` is `true`",
    :STYLE_TARGET_SWITCH_NOT_ACTIVE => "`Switch` while `get_is_active` is `false`",
    :STYLE_TARGET_SWITCH_SLIDER => "Moving element of a `Switch`",
    :STYLE_TARGET_TEXT_VIEW => "`TextView` widget",
    :STYLE_TARGET_TEXT_VIEW_TEXT => "`TextView` text entry area",
    :STYLE_TARGET_TEXT_ENTRY => "Any text entry area of a widget",
    :STYLE_TARGET_TEXT_SELECTION => "Indicator that the user selects part of the text, for example that of an `Entry` or a `Label` for whom `set_is_selectable!` was set to `true`",
    :STYLE_TARGET_TOGGLE_BUTTON => "`ToggleButton` widget",
    :STYLE_TARGET_TOGGLE_BUTTON_ACTIVE => "`ToggleButton` while `get_is_active` is `true",
    :STYLE_TARGET_TOGGLE_BUTTON_NOT_ACTIVE => "`ToggleButton` while `get_is_active` is `false`",
    :STYLE_TARGET_TRANSFORM_BIN => "`TransformBin` widget",
    :STYLE_TARGET_VIEWPORT => "`Viewport` widget",
    :STYLE_TARGET_VIEWPORT_HORIZONTAL_SCOLLBAR_SLIDER => "Moving element of the horizontal `ScrollBar` of a `Viewport`",
    :STYLE_TARGET_VIEWPORT_HORIZONTAL_SCROLLBAR => "Horizontal `ScrollBar` of a `Viewport`",
    :STYLE_TARGET_VIEWPORT_HORIZONTAL_SCROLLBAR_TROUGH => "Background \"rail\" along which the moving element of the horzontal `Scrollbar` of a `Viewport` slides",
    :STYLE_TARGET_VIEWPORT_VERTICAL_SCOLLBAR_SLIDER => "Moving element of the vertical `ScrollBar` of a `Viewport`",
    :STYLE_TARGET_VIEWPORT_VERTICAL_SCROLLBAR => "Vertical `ScrollBar` of a `Viewport`",
    :STYLE_TARGET_VIEWPORT_VERTICAL_SCROLLBAR_TROUGH => "Moving element of the vertical `ScrollBar` of a `Viewport`",
    :STYLE_TARGET_WIDGET => "Any widget",
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
        out = out * "+ [`$target`](@ref)\n"
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