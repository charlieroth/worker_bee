defmodule WorkerBee.DriverState do
  @enforce_keys [:log, :status]
  defstruct [:log, :status]
end
