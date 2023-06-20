defmodule WorkerBee.Location.Event.ShiftStarted do
  @enforce_keys [:location_id, :timestamp, :driver_id]
  defstruct [:location_id, :timestamp, :driver_id]
end
