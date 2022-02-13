# LifeCycleHook

LifeCycleHook is a simple hook that logs each life-cycle step of LiveView.

It is good for learning Phoenix LiveView life-cycle.

## Overview

> :warning: Logging `handle_parmas` stage with LifeCycleHook is not working with **sticky nested** LiveView.

By mounting `LifeCycleHook` on LiveView with `use LifeCycleHook`, you can see logs for each life-cycle.

```elixir
defmodule MyApp.MyLive do
  use Phoenix.LiveView
  use LifeCycleHook

  @impl true
  def render(assigns) do
    ...
  end
end
```

```
[debug] Elixir.MyApp.MyLive mount with HTTP
[debug] Elixir.MyApp.MyLive handle_params with HTTP
[debug] Elixir.MyApp.MyLive mount with WebSocket
[debug] Elixir.MyApp.MyLive handle_params with WebSocket
```

If you want to choose specific stages to log, you can use `only` or `except` option in `use LifeCycleHook`.

```elixir
defmodule MyApp.MyLive do
  use Phoenix.LiveView
  use LifeCycleHook, only: [:mount]

  @impl true
  def render(assigns) do
    ...
  end
end
```

```
[debug] Elixir.MyApp.MyLive mount with HTTP
[debug] Elixir.MyApp.MyLive mount with WebSocket
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `life_cycle_hook` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:life_cycle_hook, "~> 0.3.0"}
  ]
end
```

## TO DO

- [x] Add `handle_params` hook
- [x] Add macro that replace `on_mount({LifeCycleHook, __MODULE__})`
- [ ] Support nested LiveView with `sticky: true` option
- [ ] Add `handle_event` hook
- [ ] Add `handle_info` hook
- [x] Support `only`, `except` options in `use LifeCycleHook`
