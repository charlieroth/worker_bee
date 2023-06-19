defmodule WorkerBee.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Bandit, plug: WorkerBee.Router},
      {Registry, [keys: :duplicate, name: Registry.WorkerBee]},
      {Phoenix.PubSub, name: :workerbee_pubsub}
    ]

    opts = [strategy: :one_for_one, name: WorkerBee.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
