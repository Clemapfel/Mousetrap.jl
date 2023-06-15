const _generate_type_docs = quote
    
    for name in sort(union(
        mousetrap.types, 
        mousetrap.signal_emitters, 
        mousetrap.widgets, 
        mousetrap.event_controllers, 
        mousetrap.abstract_types))

        if name in mousetrap.types
            println("""
            @document $name \"\"\"
                ## $name

                TODO

                \$(@type_constructors(
                ))

                \$(@type_fields(
                ))
            \"\"\"
            """)
        elseif name in mousetrap.abstract_types
            println("""
            @document $name abstract_type_docs($name, Any, \"\"\"
                TODO
            \"\"\")
            """)            
        else
            super = ""

            if name in mousetrap.event_controllers
                super = "EventController"
            elseif name in mousetrap.widgets
                super = "Widget"
            elseif name in mousetrap.signal_emitters
                super = "SignalEmitter"
            else
                continue
            end
            
            println("""
            @document $name \"\"\"
                ## $name <: $super

                TODO

                \$(@type_constructors(
                ))

                \$(@type_signals(Widget, 
                ))

                \$(@type_fields())
            \"\"\"
            """)
        end
    end
end

@document Action """
    ## Action <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Adjustment """
    ## Adjustment <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Angle """
    ## Angle

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Application """
    ## Application <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document AspectFrame """
    ## AspectFrame <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document AxisAlignedRectangle """
    ## AxisAlignedRectangle

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Box """
    ## Box <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Button """
    ## Button <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document CenterBox """
    ## CenterBox <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document CheckButton """
    ## CheckButton <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document ClickEventController """
    ## ClickEventController <: EventController

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Clipboard """
    ## Clipboard <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Clock """
    ## Clock <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document ColumnView """
    ## ColumnView <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document ColumnViewColumn """
    ## ColumnViewColumn <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document DragEventController """
    ## DragEventController <: EventController

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document DropDown """
    ## DropDown <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document DropDownItemID """
    ## DropDownItemID

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Entry """
    ## Entry <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document EventController abstract_type_docs(EventController, Any, """
    TODO
""")

@document Expander """
    ## Expander <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document FileChooser """
    ## FileChooser <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document FileDescriptor """
    ## FileDescriptor <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document FileFilter """
    ## FileFilter <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document FileMonitor """
    ## FileMonitor <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Fixed """
    ## Fixed <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document FocusEventController """
    ## FocusEventController <: EventController

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Frame """
    ## Frame <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document FrameClock """
    ## FrameClock <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document GLTransform """
    ## GLTransform <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Grid """
    ## Grid <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document GridView """
    ## GridView <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document GroupID """
    ## GroupID

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document HSVA """
    ## HSVA

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document HeaderBar """
    ## HeaderBar <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Icon """
    ## Icon

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document IconID """
    ## IconID

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document IconTheme """
    ## IconTheme

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Image """
    ## Image

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document ImageDisplay """
    ## ImageDisplay <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document KeyCode """
    ## KeyCode

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document KeyEventController """
    ## KeyEventController <: EventController

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document KeyFile """
    ## KeyFile <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document KeyID """
    ## KeyID

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Label """
    ## Label <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document LevelBar """
    ## LevelBar <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document ListView """
    ## ListView <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document ListViewIterator """
    ## ListViewIterator

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document LogDomain """
    ## LogDomain

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document LongPressEventController """
    ## LongPressEventController <: EventController

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document MenuBar """
    ## MenuBar <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document MenuModel """
    ## MenuModel <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document ModifierState """
    ## ModifierState

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document MotionEventController """
    ## MotionEventController <: EventController

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Notebook """
    ## Notebook <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Overlay """
    ## Overlay <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document PanEventController """
    ## PanEventController <: EventController

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Paned """
    ## Paned <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document PinchZoomEventController """
    ## PinchZoomEventController <: EventController

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Popover """
    ## Popover <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document PopoverButton """
    ## PopoverButton <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document PopoverMenu """
    ## PopoverMenu <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document ProgressBar """
    ## ProgressBar <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document RGBA """
    ## RGBA

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document RenderArea """
    ## RenderArea <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document RenderTask """
    ## RenderTask <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document RenderTexture """
    ## RenderTexture <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Revealer """
    ## Revealer <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document RotateEventController """
    ## RotateEventController <: EventController

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Scale """
    ## Scale <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document ScrollEventController """
    ## ScrollEventController <: EventController

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Scrollbar """
    ## Scrollbar <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document SelectionModel """
    ## SelectionModel <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Separator """
    ## Separator <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Shader """
    ## Shader <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Shape """
    ## Shape <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document ShortcutEventController """
    ## ShortcutEventController <: EventController

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document ShortcutTrigger """
    ## ShortcutTrigger

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document SignalEmitter abstract_type_docs(SignalEmitter, Any, """
    TODO
""")

@document SingleClickGesture abstract_type_docs(SingleClickGesture, Any, """
    TODO
""")

@document SpinButton """
    ## SpinButton <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Spinner """
    ## Spinner <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Stack """
    ## Stack <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document StackID """
    ## StackID

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document StackSidebar """
    ## StackSidebar <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document StackSwitcher """
    ## StackSwitcher <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document StylusEventController """
    ## StylusEventController <: EventController

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document SwipeEventController """
    ## SwipeEventController <: EventController

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Switch """
    ## Switch <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document TextView """
    ## TextView <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Texture """
    ## Texture <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Time """
    ## Time

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document ToggleButton """
    ## ToggleButton <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document TypedFunction """
    ## TypedFunction

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Vector2 """
    ## Vector2

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Vector2f """
    ## Vector2f

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Vector2i """
    ## Vector2i

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Vector2ui """
    ## Vector2ui

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Vector3 """
    ## Vector3

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Vector3f """
    ## Vector3f

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Vector3i """
    ## Vector3i

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Vector3ui """
    ## Vector3ui

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Vector4 """
    ## Vector4

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Vector4f """
    ## Vector4f

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Vector4i """
    ## Vector4i

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Vector4ui """
    ## Vector4ui

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Viewport """
    ## Viewport <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

@document Widget abstract_type_docs(Widget, Any, """
    TODO
""")

@document Window """
    ## Window <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Widget, 
    ))

    $(@type_fields())
"""

