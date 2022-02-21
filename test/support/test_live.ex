defmodule LifeCycleHookTest.TestLive do
  use Phoenix.LiveView
  use LifeCycleHook

  @impl true
  def render(assigns) do
    ~H"""
    test
    <button phx-click="click"></button>
    """
  end

  @impl true
  def handle_event("click", _params, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_info(:message, socket) do
    {:noreply, socket}
  end
end
