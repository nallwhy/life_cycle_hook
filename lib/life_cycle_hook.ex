defmodule LifeCycleHook do
  import Phoenix.LiveView
  require Logger

  defmacro __using__(_) do
    quote do
      on_mount(unquote(__MODULE__))
    end
  end

  def on_mount(:default, _params, _session, socket) do
    socket =
      socket
      |> attach_mount_hook()
      |> attach_handle_params_hook()

    {:cont, socket}
  end

  defp attach_mount_hook(socket) do
    log_message(socket, :mount) |> Logger.debug()

    socket
  end

  defp attach_handle_params_hook(socket) do
    socket
    |> attach_hook(:life_cycle_hook, :handle_params, fn _params, _session, socket ->
      log_message(socket, :handle_params) |> Logger.debug()

      {:cont, socket}
    end)
  end

  defp log_message(socket, stage) do
    module = socket.view

    method =
      case connected?(socket) do
        false -> "HTTP"
        true -> "Websocket"
      end

    "#{module} #{stage} with #{method}"
  end
end
