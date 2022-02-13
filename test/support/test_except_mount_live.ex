defmodule LifeCycleHookTest.TestExceptMountLive do
  use Phoenix.LiveView
  use LifeCycleHook, except: [:mount]

  @impl true
  def render(assigns) do
    ~H"""
    test except mount
    """
  end
end
