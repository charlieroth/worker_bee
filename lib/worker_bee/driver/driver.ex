defmodule WorkerBee.Driver do
  use GenServer, restart: :transient
  require Logger
  alias WorkerBee.Driver.Event

  def start_link(driver_id) do
    GenServer.start_link(__MODULE__, driver_id, name: via_tuple(driver_id))
  end

  def child_spec(driver_id) do
    %{id: __MODULE__, start: {__MODULE__, :start_link, [driver_id]}}
  end

  @impl true
  def init(driver_id) do
    :ok = Phoenix.PubSub.subscribe(:workerbee_pubsub, "driver:#{driver_id}")
    {:ok, %{id: driver_id, log: [], status: :offline}}
  end

  @impl true
  def handle_call(:log, _from, state) do
    {:reply, state.log, state}
  end

  @impl true
  def handle_cast({:start_shift, %Event.StartShift{} = event}, state) do
    new_state = %{state | log: [event | state.log], status: :online}
    {:noreply, new_state}
  end

  @impl true
  def handle_cast({:end_shift, %Event.EndShift{} = event}, state) do
    new_state = %{state | log: [event | state.log], status: :offline}
    {:noreply, new_state}
  end

  def start_shift(driver_id, location) do
    event = %Event.StartShift{
      driver_id: driver_id,
      timestamp: NaiveDateTime.utc_now(),
      location: location
    }

    driver_id
    |> via_tuple()
    |> GenServer.cast({:start_shift, event})
  end

  def activate(driver_id, vehicle_type) do
    event = %Event.Activate{
      driver_id: driver_id,
      timestamp: NaiveDateTime.utc_now(),
      vehicle_type: vehicle_type
    }

    driver_id
    |> via_tuple()
    |> GenServer.cast({:activate, event})
  end

  def request_delivery(driver_id, location) do
  end

  def end_shift(driver_id, location) do
    event = %Event.EndShift{
      driver_id: driver_id,
      timestamp: NaiveDateTime.utc_now(),
      location: location
    }

    driver_id
    |> via_tuple()
    |> GenServer.cast({:end_shift, event})
  end

  def log(driver_id) do
    driver_id |> via_tuple() |> GenServer.call(:log)
  end

  def stop(driver_id, reason) do
    driver_id |> via_tuple() |> GenServer.stop(reason)
  end

  defp via_tuple(driver_id), do: {:via, Registry, {WorkerBee.Registry, driver_id}}
end
