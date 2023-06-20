defmodule WorkerBee.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # {Bandit, plug: WorkerBee.Router},
      {Registry, [keys: :unique, name: WorkerBee.Registry]},
      {Phoenix.PubSub, name: :workerbee_pubsub},
      {WorkerBee.Location.Supervisor, []},
      {WorkerBee.Driver.Supervisor, []}
    ]

    opts = [strategy: :one_for_one, name: WorkerBee.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
