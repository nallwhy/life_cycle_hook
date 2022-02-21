# LifeCycleHook

[![Hex Version](https://img.shields.io/hexpm/v/life_cycle_hook.svg)](https://hex.pm/packages/life_cycle_hook)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/life_cycle_hook/)
[![Total Download](https://img.shields.io/hexpm/dt/life_cycle_hook.svg)](https://hex.pm/packages/life_cycle_hook)
[![License](https://img.shields.io/hexpm/l/life_cycle_hook.svg)](https://github.com/nallwhy/life_cycle_hook/blob/master/LICENSE.md)
[![Last Updated](https://img.shields.io/github/last-commit/nallwhy/life_cycle_hook.svg)](https://github.com/nallwhy/life_cycle_hook/commits/main)

<!-- MDOC !-->

LifeCycleHook is a simple hook that logs each life-cycle stage of LiveView.

It is good for learning Phoenix LiveView life-cycle.

## Overview

By mounting `LifeCycleHook` on LiveView with `use LifeCycleHook`, you can see logs for each life-cycle of LiveView.

```elixir
defmodule MyApp.MyLive do
  use Phoenix.LiveView
  use LifeCycleHook

  @impl true
  def render(assigns) do
    ...
  end

  @impl true
  def handle_event("click", params, socket) do
    ...
  end

  @impl true
  def handle_info(:send, socket) do
    ...
  end
end
```

```
[debug] MyApp.MyLive mount connected: false
[debug] MyApp.MyLive handle_params connected: false
[debug] MyApp.MyLive mount connected: true
[debug] MyApp.MyLive handle_params connected: true

[debug] MyApp.MyLive handle_event event: click
[debug] MyApp.MyLive handle_info message: send
```

### only/except options

If you want to choose specific stages to log, you can use `only` or `except` option in `use LifeCycleHook`.
For example, you can set `only: [:mount]` option to use `LifeCycleHook` in sticky nested LiveView which doesn't support `handle_params` hook.

```elixir
defmodule MyApp.MyStickyNestedLive do
  use Phoenix.LiveView
  use LifeCycleHook, only: [:mount]

  @impl true
  def render(assigns) do
    ...
  end
end
```

```
[debug] MyApp.MyStickyNestedLive mount connected: false
[debug] MyApp.MyStickyNestedLive mount connected: true
```

### log_level option

You can change log level of `LifeCycleHook` with `log_level` option.

```elixir
defmodule MyApp.MyWarnLogLevelLive do
  use Phoenix.LiveView
  use LifeCycleHook, log_level: :warn

  @impl true
  def render(assigns) do
    ...
  end
end
```

```
[warning] MyApp.MyWarnLogLevelLive mount connected: false
[warning] MyApp.MyWarnLogLevelLive mount connected: true
```

## Installation

The package can be installed by adding `:life_cycle_hook` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:life_cycle_hook, "~> 0.8"}
  ]
end
```
<!-- MDOC !-->

## TO DO

- [x] Add `handle_params` hook
- [x] Add macro that replace `on_mount({LifeCycleHook, __MODULE__})`
- [ ] Support nested LiveView with `sticky: true` option
- [x] Add `handle_event` hook
- [x] Add `handle_info` hook
- [x] Support `only`, `except` options in `use LifeCycleHook`
- [x] Support setting log level
- [ ] Support watching params of each hook
- [ ] Support LiveComponent
- [x] Remove `Elixir` prefix from module names in logs

## Copyright and License

Copyright (c) 2022 Jinkyou Son (Json)

This work is free. You can redistribute it and/or modify it under the
terms of the MIT License. See the [LICENSE.md](./LICENSE.md) file for more details.
