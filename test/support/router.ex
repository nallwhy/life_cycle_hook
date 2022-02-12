defmodule LifeCycleHookTest.Router do
  use Phoenix.Router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug(:accepts, ["html"])
  end

  scope "/", LifeCycleHookTest do
    pipe_through([:browser])

    live("/test", TestLive)
  end
end
