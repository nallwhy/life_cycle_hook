defmodule LifeCycleHookTest.EndpointOverridable do
  defmacro __before_compile__(_env) do
    quote do
      defoverridable call: 2

      def call(conn, _) do
        conn
        |> Plug.Conn.put_private(:phoenix_endpoint, __MODULE__)
        |> LifeCycleHookTest.Router.call([])
      end
    end
  end
end

defmodule LifeCycleHookTest.Endpoint do
  use Phoenix.Endpoint, otp_app: :life_cycle_hook

  @before_compile LifeCycleHookTest.EndpointOverridable

  socket("/live", Phoenix.LiveView.Socket)

  defoverridable url: 0, script_name: 0, config: 1, config: 2, static_path: 1
  def script_name(), do: []
  def config(:live_view), do: [signing_salt: "112345678212345678312345678412"]
  def config(:secret_key_base), do: String.duplicate("57689", 50)
  def config(:otp_app), do: :life_cycle_hook
  def config(:static_url), do: [path: "/static"]
  def config(which), do: super(which)
end
