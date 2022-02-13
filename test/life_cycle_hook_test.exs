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

    assert {:ok, _, _} = result

    assert log =~ "[debug] Elixir.LifeCycleHookTest.TestLive mount/3 with HTTP"
    assert log =~ "[debug] Elixir.LifeCycleHookTest.TestLive handle_params/3 with HTTP"
    assert log =~ "[debug] Elixir.LifeCycleHookTest.TestLive mount/3 with Websocket"
    assert log =~ "[debug] Elixir.LifeCycleHookTest.TestLive handle_params/3 with Websocket"
  end
end
