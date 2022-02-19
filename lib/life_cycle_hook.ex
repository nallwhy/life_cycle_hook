defmodule LifeCycleHook do
  @external_resource "README.md"
  @moduledoc "README.md"
             |> File.read!()
             |> String.split("<!-- MDOC !-->")
             |> Enum.fetch!(1)

  import Phoenix.LiveView
  require Logger

  # TODO: Add handle_info
  @life_cycle_stages [:mount, :handle_params, :handle_event]

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

  def on_mount(%{stages: stages, log_level: log_level}, _params, _session, socket) do
    socket =
      stages
      |> Enum.reduce(socket, fn stage, socket ->
        socket |> attach_life_cycle_hook(stage, log_level)
      end)

    {:cont, socket}
  end

  defp attach_life_cycle_hook(socket, :mount, log_level) do
    log_life_cycle(socket, :mount, nil, log_level)

    socket
  end

  defp attach_life_cycle_hook(socket, stage, log_level) do
    socket
    |> attach_hook(:life_cycle_hook, stage, fn params, _session, socket ->
      log_life_cycle(socket, stage, params, log_level)

      {:cont, socket}
    end)
  end

  defp log_life_cycle(socket, stage, params, log_level) do
    Logger.log(log_level, log_message(socket, stage, params))
  end

  defp log_message(socket, stage, _params) when stage in [:mount, :handle_params] do
    module = socket.view

    method =
      case connected?(socket) do
        false -> "HTTP"
        true -> "Websocket"
      end

    "#{module} #{stage} with #{method}"
  end

  defp log_message(socket, :handle_event = stage, event) do
    module = socket.view

    "#{module} #{stage} event: #{event}"
  end
end
