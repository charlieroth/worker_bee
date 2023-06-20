defmodule WorkerBee.Location.Supervisor do
  use DynamicSupervisor
  alias WorkerBee.Location

  def start_link(_args) do
    DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def add_location({location_id, location_alias}) do
    child_spec = {Location, {location_id, location_alias}}
    DynamicSupervisor.start_child(__MODULE__, child_spec)
  end

  @impl true
  def init(_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
