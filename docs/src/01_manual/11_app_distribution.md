```@meta
DocTestSetup = quote
  using Mousetrap
  function Window(app::Application)
      out = Mousetrap.Window(app)
      set_tick_callback!(out, out) do clock, self
          close!(self)
          return TICK_CALLBACK_RESULT_DISCONTINUE
      end
      return out
  end
end
```

# Chapter 11: App Distribution

In this chapter, we will learn:
+ How to load and store assets
+ How to bundle our app for distribution
+ How to install our app on a user's machine

---

!!! compat
    These features are not yet implemented, this section is incomplete. As of version 0.3.0, there is no unified way to bundle and distribute a Mousetrap app. See [here](https://github.com/users/Clemapfel/projects/2?pane=issue&itemId=33978204#) for more information.
