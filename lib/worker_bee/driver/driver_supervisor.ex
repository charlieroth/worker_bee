defmodule WorkerBee.Driver.Supervisor do
  use DynamicSupervisor
  alias WorkerBee.Driver

  def start_link(_args) do
    DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def add_driver(driver_id) do
    child_spec = {Driver, driver_id}
    DynamicSupervisor.start_child(__MODULE__, child_spec)
  end

  @impl true
  def init(_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
