defmodule LifeCycleHookTest.TestLogLevelLive do
  use Phoenix.LiveView
  use LifeCycleHook, log_level: :warn

  @impl true
  def render(assigns) do
    ~H"""
    test log level
    """
  end
end
