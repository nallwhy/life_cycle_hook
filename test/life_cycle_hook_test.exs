defmodule LifeCycleHookTest do
  use ExUnit.Case
  doctest LifeCycleHook

  test "greets the world" do
    assert LifeCycleHook.hello() == :world
  end
end
