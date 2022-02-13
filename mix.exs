defmodule LifeCycleHook.MixProject do
  use Mix.Project

  @version "0.2.1"
  @source_url "https://github.com/nallwhy/life_cycle_hook"

  def project do
    [
      app: :life_cycle_hook,
      version: @version,
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      package: package(),
      description: description(),
      source_url: @source_url,
      docs: docs()
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix_live_view, "~> 0.17"},
      {:jason, "~> 1.0", optional: true},
      {:floki, "~> 0.30.0", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url},
      maintainers: ["Jinkyou Son(nallwhy@gmail.com)"],
      files: ["lib", "mix.exs", "LICENSE", "README.md"]
    ]
  end

  defp description() do
    "A simple hook that logs each life-cycle step of LiveView"
  end

  defp docs() do
    [main: "readme", extras: ["README.md"]]
  end
end
