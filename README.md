# LifeCycleHook

[![Hex Version](https://img.shields.io/hexpm/v/life_cycle_hook.svg)](https://hex.pm/packages/life_cycle_hook)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/life_cycle_hook/)
[![Total Download](https://img.shields.io/hexpm/dt/life_cycle_hook.svg)](https://hex.pm/packages/life_cycle_hook)
[![License](https://img.shields.io/hexpm/l/life_cycle_hook.svg)](https://github.com/nallwhy/life_cycle_hook/blob/master/LICENSE.md)
[![Last Updated](https://img.shields.io/github/last-commit/nallwhy/life_cycle_hook.svg)](https://github.com/nallwhy/life_cycle_hook/commits/main)

<!-- MDOC !-->

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

The package can be installed by adding `:life_cycle_hook` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:life_cycle_hook, "~> 0.4.0"}
  ]
end
```
<!-- MDOC !-->

## TO DO

- [x] Add `handle_params` hook
- [x] Add macro that replace `on_mount({LifeCycleHook, __MODULE__})`
- [ ] Support nested LiveView with `sticky: true` option
- [ ] Add `handle_event` hook
- [ ] Add `handle_info` hook
- [x] Support `only`, `except` options in `use LifeCycleHook`
- [ ] Support setting log level
- [ ] Support watching params of each hook

## Copyright and License

Copyright (c) 2022 Jinkyou Son (Json)

This work is free. You can redistribute it and/or modify it under the
terms of the MIT License. See the [LICENSE.md](./LICENSE.md) file for more details.
