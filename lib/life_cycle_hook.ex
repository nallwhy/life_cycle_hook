defmodule LifeCycleHook do
  import Phoenix.LiveView
  require Logger

  # TODO: Add more stages
  @life_cycle_stages [:mount, :handle_params]

  defmacro __using__(opts) do
    only = Keyword.get(opts, :only)
    except = Keyword.get(opts, :except)

    stages =
      case {only, except} do
        {nil, nil} -> @life_cycle_stages
        {only, nil} when is_list(only) -> @life_cycle_stages |> Enum.filter(&(&1 in only))
        {nil, except} when is_list(except) -> @life_cycle_stages |> Enum.reject(&(&1 in except))
        _ -> raise ":only and :except can'nt be given together to LifeCycleHook"
      end

    quote do
      on_mount({unquote(__MODULE__), %{stages: unquote(stages)}})
    end
  end

  def on_mount(%{stages: stages}, _params, _session, socket) do
    socket =
      stages
      |> Enum.reduce(socket, fn stage, socket ->
        socket |> attach_life_cycle_hook(stage)
      end)

    {:cont, socket}
  end

  defp attach_life_cycle_hook(socket, :mount) do
    log_message(socket, :mount) |> Logger.debug()

    socket
  end

  defp attach_life_cycle_hook(socket, stage) do
    socket
    |> attach_hook(:life_cycle_hook, stage, fn _params, _session, socket ->
      log_message(socket, stage) |> Logger.debug()

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
