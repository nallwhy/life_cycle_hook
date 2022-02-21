defmodule LifeCycleHook do
  @external_resource "README.md"
  @moduledoc "README.md"
             |> File.read!()
             |> String.split("<!-- MDOC !-->")
             |> Enum.fetch!(1)

  import Phoenix.LiveView
  require Logger

  @life_cycle_stages [:mount, :handle_params, :handle_event, :handle_info]

  defmacro __using__(opts) do
    only = Keyword.get(opts, :only)
    except = Keyword.get(opts, :except)
    log_level = Keyword.get(opts, :log_level, :debug)

    stages =
      case {only, except} do
        {nil, nil} -> @life_cycle_stages
        {only, nil} when is_list(only) -> @life_cycle_stages |> Enum.filter(&(&1 in only))
        {nil, except} when is_list(except) -> @life_cycle_stages |> Enum.reject(&(&1 in except))
        _ -> raise ":only and :except can'nt be given together to LifeCycleHook"
      end

    quote do
      on_mount({unquote(__MODULE__), %{stages: unquote(stages), log_level: unquote(log_level)}})
    end
  end

  def on_mount(%{stages: stages, log_level: log_level}, params, session, socket) do
    socket =
      stages
      |> Enum.reduce(socket, fn stage, socket ->
        case stage do
          :mount ->
            log_mount_life_cycle(socket, params, session, log_level)

            socket

          stage ->
            socket |> attach_life_cycle_hook(stage, log_level)
        end
      end)

    {:cont, socket}
  end

  defp log_mount_life_cycle(socket, _params, _session, log_level) do
    message =
      [get_common_message(socket, :mount), get_connection_message(socket)]
      |> Enum.join(" ")

    Logger.log(log_level, message)
  end

  defp attach_life_cycle_hook(socket, :handle_params, log_level) do
    socket
    |> attach_hook(:life_cycle_hook, :handle_params, fn _params, _uri, socket ->
      message =
        [get_common_message(socket, :handle_params), get_connection_message(socket)]
        |> Enum.join(" ")

      Logger.log(log_level, message)

      {:cont, socket}
    end)
  end

  defp attach_life_cycle_hook(socket, :handle_event, log_level) do
    socket
    |> attach_hook(:life_cycle_hook, :handle_event, fn event, _params, socket ->
      message =
        [get_common_message(socket, :handle_event), "event: #{event}"]
        |> Enum.join(" ")

      Logger.log(log_level, message)

      {:cont, socket}
    end)
  end

  defp attach_life_cycle_hook(socket, :handle_info, log_level) do
    socket
    |> attach_hook(:life_cycle_hook, :handle_info, fn message, socket ->
      message =
        [get_common_message(socket, :handle_info), "message: #{message}"]
        |> Enum.join(" ")

      Logger.log(log_level, message)

      {:cont, socket}
    end)
  end

  defp get_connection_message(socket) do
    "connected: #{connected?(socket)}"
  end

  defp get_common_message(socket, stage) do
    module_name = socket.view |> inspect()

    "#{module_name} #{stage}"
  end
end
