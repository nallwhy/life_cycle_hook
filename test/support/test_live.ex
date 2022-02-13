defmodule LifeCycleHookTest.TestLive do
  use Phoenix.LiveView
  use LifeCycleHook

  @impl true
  def render(assigns) do
    ~H"""
    test
    """
  end
end
