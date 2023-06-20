defmodule WorkerBee.Location do
  use GenServer

  def start_link({location_id, location_alias}) do
    GenServer.start_link(__MODULE__, {location_id, location_alias}, name: via_tuple(location_id))
  end

  @impl true
  def init({location_id, location_alias}) do
    :ok = Phoenix.PubSub.subscribe(:workerbee_pubsub, "location:#{location_id}")

    {
      :ok,
      %{
        location_id: location_id,
        location_alias: location_alias,
        drivers: [],
        deliveries: [],
        log: []
      }
    }
  end

  defp via_tuple(location_id), do: {:via, Registry, {WorkerBee.Registry, location_id}}
end
