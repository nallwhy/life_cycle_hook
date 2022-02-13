defmodule LifeCycleHook.MixProject do
  use Mix.Project

  @source_url "https://github.com/nallwhy/life_cycle_hook"
  @version "0.4.0"

  def project do
    [
      app: :life_cycle_hook,
      version: @version,
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      package: package(),
      docs: docs()
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:phoenix_live_view, "~> 0.17"},
      {:jason, "~> 1.0", optional: true},
      {:floki, "~> 0.30.0", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      description: "A simple hook that logs each life-cycle step of LiveView",
      licenses: ["MIT"],
      maintainers: ["Jinkyou Son(nallwhy@gmail.com)"],
      files: ["lib", "mix.exs", "LICENSE", "README.md", "CHANGELOG.md"],
      links: %{
        "Changelog" => "https://hexdocs.pm/life_cycle_hook/changelog.html",
        "GitHub" => @source_url
      },
    ]
  end

  defp docs do
    [
      extras: [
        "CHANGELOG.md": [],
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      source_url: @source_url,
      main: "readme",
      api_reference: false,
      formatters: ["html"]
    ]
  end
end
