defmodule WorkerBee do
  @moduledoc false

  alias WorkerBee.Location
  require Logger

  def add_location(location_alias) do
    location_id = Uniq.UUID.uuid4()
    {:ok, location_pid} = Location.Supervisor.add_location({location_id, location_alias})
    Logger.info("Location #{location_alias} (#{location_id}) added")
    {location_id, location_pid}
  end
end
