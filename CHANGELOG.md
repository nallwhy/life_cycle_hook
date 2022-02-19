# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## v0.6.0 (2022-02-20)

- Enhancements
  - Add logging `handle_event/3` life-cycle of LiveView

## v0.5.0 (2022-02-18)

- Enhancements
  - Support `log_level` option in `use LifeCycleHook`

## v0.4.0 (2022-02-13)

- Enhancements
  - Support `only`, `except` options in `use LifeCycleHook`

## v0.3.0 (2022-02-13)

- Enhancements
  - Add logging `handle_params/3` life-cycle of LiveView

## v0.2.1 (2022-02-13)

- Fixs
  - Remove unnecessary input in `on_mount/1`

## v0.2.0 (2022-02-13)

- Enhancements
  - Add `__using__/1` macro to LifeCycleHook that replaces `on_mount({LifeCycleHook, __MODULE__})` with `use LifeCycleHook`

## v0.1.0 (2022-02-13)

- Initial Release
  - Add logging `mount/3` life-cycle of LiveView

