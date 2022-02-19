defmodule LifeCycleHookTest do
  use ExUnit.Case, async: true
  import Phoenix.ConnTest
  import Phoenix.LiveViewTest
  import ExUnit.CaptureLog, only: [with_log: 1]

  @endpoint LifeCycleHookTest.Endpoint

  test "check logging" do
    conn = Plug.Test.init_test_session(build_conn(), %{})

    {result, log} =
      with_log(fn ->
        live(conn, "/test")
      end)

    assert {:ok, view, _} = result

    assert log =~ "[debug] Elixir.LifeCycleHookTest.TestLive mount with HTTP"
    assert log =~ "[debug] Elixir.LifeCycleHookTest.TestLive handle_params with HTTP"
    assert log =~ "[debug] Elixir.LifeCycleHookTest.TestLive mount with Websocket"
    assert log =~ "[debug] Elixir.LifeCycleHookTest.TestLive handle_params with Websocket"

    {_, log} =
      with_log(fn ->
        view |> element("button") |> render_click()
      end)

    assert log =~ "[debug] Elixir.LifeCycleHookTest.TestLive handle_event with Websocket"
  end

  test "use with only option" do
    conn = Plug.Test.init_test_session(build_conn(), %{})

    {result, log} =
      with_log(fn ->
        live(conn, "/test_only_mount")
      end)

    assert {:ok, _, _} = result

    assert log =~ "[debug] Elixir.LifeCycleHookTest.TestOnlyMountLive mount with HTTP"
    refute log =~ "[debug] Elixir.LifeCycleHookTest.TestOnlyMountLive handle_params with HTTP"
    assert log =~ "[debug] Elixir.LifeCycleHookTest.TestOnlyMountLive mount with Websocket"

    refute log =~
             "[debug] Elixir.LifeCycleHookTest.TestOnlyMountLive handle_params with Websocket"
  end

  test "use with except option" do
    conn = Plug.Test.init_test_session(build_conn(), %{})

    {result, log} =
      with_log(fn ->
        live(conn, "/test_except_mount")
      end)

    assert {:ok, _, _} = result

    refute log =~ "[debug] Elixir.LifeCycleHookTest.TestExceptMountLive mount with HTTP"
    assert log =~ "[debug] Elixir.LifeCycleHookTest.TestExceptMountLive handle_params with HTTP"
    refute log =~ "[debug] Elixir.LifeCycleHookTest.TestExceptMountLive mount with Websocket"

    assert log =~
             "[debug] Elixir.LifeCycleHookTest.TestExceptMountLive handle_params with Websocket"
  end

  test "use with log_level option" do
    conn = Plug.Test.init_test_session(build_conn(), %{})

    {result, log} =
      with_log(fn ->
        live(conn, "/test_log_level")
      end)

    assert {:ok, _, _} = result

    assert log =~ "[warning] Elixir.LifeCycleHookTest.TestLogLevelLive mount with HTTP"
    assert log =~ "[warning] Elixir.LifeCycleHookTest.TestLogLevelLive handle_params with HTTP"
    assert log =~ "[warning] Elixir.LifeCycleHookTest.TestLogLevelLive mount with Websocket"

    assert log =~
             "[warning] Elixir.LifeCycleHookTest.TestLogLevelLive handle_params with Websocket"
  end
end
