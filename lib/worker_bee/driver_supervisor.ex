defmodule WorkerBee.DriverSupervisor do
  use DynamicSupervisor
  alias WorkerBee.Driver

  def start_link(_args) do
    DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def start_child(driver_id) do
    child_spec = {Driver, driver_id}
    DynamicSupervisor.start_child(__MODULE__, child_spec)
  end

  @impl true
  def init(_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
