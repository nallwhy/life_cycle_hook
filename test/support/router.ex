defmodule LifeCycleHookTest.Router do
  use Phoenix.Router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug(:accepts, ["html"])
  end

  scope "/", LifeCycleHookTest do
    pipe_through([:browser])

    live("/test", TestLive)
    live("/test_only_mount", TestOnlyMountLive)
    live("/test_except_mount", TestExceptMountLive)
    live("/test_log_level", TestLogLevelLive)
  end
end
