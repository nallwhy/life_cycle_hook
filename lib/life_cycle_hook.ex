defmodule LifeCycleHook do
  import Phoenix.LiveView
  require Logger

  def on_mount(module, _params, _session, socket) do
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
