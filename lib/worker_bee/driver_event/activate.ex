defmodule WorkerBee.DriverEvent.Activate do
  @enforce_keys [:driver_id, :timestamp, :vehicle_type]
  defstruct [:driver_id, :timestamp, :vehicle_type]
end
