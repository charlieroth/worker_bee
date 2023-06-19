defmodule WorkerBee.MixProject do
  use Mix.Project

  def project do
    [
      app: :worker_bee,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {WorkerBee.Application, []}
    ]
  end

  defp deps do
    [
      {:bandit, "~> 0.7.7"},
      {:websock_adapter, "~> 0.5.3"},
      {:jason, "~> 1.4"},
      {:phoenix_pubsub, "~> 2.1"}
    ]
  end
end
