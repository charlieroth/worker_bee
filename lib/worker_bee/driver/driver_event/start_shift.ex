defmodule WorkerBee.Driver.Event.StartShift do
  @enforce_keys [:driver_id, :location, :timestamp]
  defstruct [:driver_id, :location, :timestamp]
end
