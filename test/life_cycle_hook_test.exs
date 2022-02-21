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

    assert log =~ "[debug] LifeCycleHookTest.TestLive mount connected: false"
    assert log =~ "[debug] LifeCycleHookTest.TestLive handle_params connected: false"
    assert log =~ "[debug] LifeCycleHookTest.TestLive mount connected: true"
    assert log =~ "[debug] LifeCycleHookTest.TestLive handle_params connected: true"

    {_, log} =
      with_log(fn ->
        view |> element("button") |> render_click()
      end)

    assert log =~ "[debug] LifeCycleHookTest.TestLive handle_event event: click"

    {_, log} =
      with_log(fn ->
        view.pid |> send(:message)
      end)

    assert log =~ "[debug] LifeCycleHookTest.TestLive handle_info message: message"
  end

  test "use with only option" do
    conn = Plug.Test.init_test_session(build_conn(), %{})

    {result, log} =
      with_log(fn ->
        live(conn, "/test_only_mount")
      end)

    assert {:ok, _, _} = result

    assert log =~ "[debug] LifeCycleHookTest.TestOnlyMountLive mount connected: false"
    refute log =~ "[debug] LifeCycleHookTest.TestOnlyMountLive handle_params connected: false"
    assert log =~ "[debug] LifeCycleHookTest.TestOnlyMountLive mount connected: true"

    refute log =~
             "[debug] LifeCycleHookTest.TestOnlyMountLive handle_params connected: true"
  end

  test "use with except option" do
    conn = Plug.Test.init_test_session(build_conn(), %{})

    {result, log} =
      with_log(fn ->
        live(conn, "/test_except_mount")
      end)

    assert {:ok, _, _} = result

    refute log =~ "[debug] LifeCycleHookTest.TestExceptMountLive mount connected: false"
    assert log =~ "[debug] LifeCycleHookTest.TestExceptMountLive handle_params connected: false"
    refute log =~ "[debug] LifeCycleHookTest.TestExceptMountLive mount connected: true"
    assert log =~ "[debug] LifeCycleHookTest.TestExceptMountLive handle_params connected: true"
  end

  test "use with log_level option" do
    conn = Plug.Test.init_test_session(build_conn(), %{})

    {result, log} =
      with_log(fn ->
        live(conn, "/test_log_level")
      end)

    assert {:ok, _, _} = result

    assert log =~ "[warning] LifeCycleHookTest.TestLogLevelLive mount connected: false"
    assert log =~ "[warning] LifeCycleHookTest.TestLogLevelLive handle_params connected: false"
    assert log =~ "[warning] LifeCycleHookTest.TestLogLevelLive mount connected: true"
    assert log =~ "[warning] LifeCycleHookTest.TestLogLevelLive handle_params connected: true"
  end
end
