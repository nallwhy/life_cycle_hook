defmodule LifeCycleHookTest.TestOnlyMountLive do
  use Phoenix.LiveView
  use LifeCycleHook, only: [:mount]

  @impl true
  def render(assigns) do
    ~H"""
    test only mount
    """
  end
end
