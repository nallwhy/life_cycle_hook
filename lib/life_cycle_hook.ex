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
      |> attach_handle_params_hook(module)

    {:cont, socket}
  end

  defp attach_mount_hook(socket, module) do
    log_message(socket, module, :mount) |> Logger.debug()

    socket
  end

  defp attach_handle_params_hook(socket, module) do
    socket
    |> attach_hook(:life_cycle_hook, :handle_params, fn _params, _session, socket ->
      log_message(socket, module, :handle_params) |> Logger.debug()

      {:cont, socket}
    end)
  end

  defp log_message(socket, module, stage) do
    method =
      case connected?(socket) do
        false -> "HTTP"
        true -> "Websocket"
      end

    "#{module} #{stage} with #{method}"
  end
end
