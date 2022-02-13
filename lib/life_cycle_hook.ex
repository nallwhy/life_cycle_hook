defmodule LifeCycleHook do
  import Phoenix.LiveView
  require Logger

  defmacro __using__(_) do
    quote do
      on_mount(unquote(__MODULE__))
    end
  end

  def on_mount(:default, _params, _session, socket) do
    module = socket.view

    socket =
      socket
      |> attach_mount_hook(module)

    {:cont, socket}
  end

  defp attach_mount_hook(socket, module) do
    mount_hook(socket, module)

    socket
  end

  defp mount_hook(socket, module) do
    case connected?(socket) do
      false -> Logger.debug("#{module} mount/3 with HTTP")
      true -> Logger.debug("#{module} mount/3 with Websocket")
    end
  end
end
