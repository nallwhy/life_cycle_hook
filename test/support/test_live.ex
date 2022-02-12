defmodule LifeCycleHookTest.TestLive do
  use Phoenix.LiveView

  on_mount({LifeCycleHook, __MODULE__})

  @impl true
  def render(assigns) do
    ~H"""
    test
    """
  end
end
