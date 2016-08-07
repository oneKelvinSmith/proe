defmodule Issues.Mixfile do
  use Mix.Project

  def project do
    [app: :issues,
     escript: escript_config,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [
      {:credo, "~> 0.4", only: [:dev, :test]},
      {:httpoison, "~> 0.9"},
      {:poison, "~> 2.0"}
    ]
  end

  defp escript_config do
    [main_module: Issues.CLI]
  end
end
