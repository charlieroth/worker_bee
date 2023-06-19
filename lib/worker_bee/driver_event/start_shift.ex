defmodule WorkerBee.DriverEvent.StartShift do
  @enforce_keys [:driver_id, :location, :timestamp]
  defstruct [:driver_id, :location, :timestamp]
end