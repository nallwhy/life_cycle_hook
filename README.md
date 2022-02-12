# LifeCycleHook

LifeCycleHook is a simple hook that logs each life-cycle step of LiveView.

It is good for learning Phoenix LiveView life-cycle.

## Overview

By mounting `LifeCycleHook` with `on_mount/1` in LiveView, you can see logs for each life-cycle.

```elixir
defmodule MyApp.MyLive do
  use Phoenix.LiveView

  on_mount({LifeCycleHook, __MODULE__})

  @impl true
  def render(assigns) do
    ...
  end
end
```

```
[debug] Elixir.MyApp.MyLive mount/3 with HTTP
[debug] Elixir.MyApp.MyLive mount/3 with WebSocket
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `life_cycle_hook` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:life_cycle_hook, "~> 0.1.0"}
  ]
end
```
