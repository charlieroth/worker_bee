defmodule WebSockEx.DriverServer do
  @moduledoc false
  alias Phoenix.PubSub
  require Logger

  def init(state) do
    PubSub.subscribe(:workerbee_pubsub, "driver")
    {:ok, state}
  end

  def handle_in({json, [opcode: :text]}, state) do
    # TODO
    {:ok, state}
  end

  def handle_info(info, state) do
    {:reply, :ok, {:text, info}, state}
  end

  def terminate(reason, state) do
    PubSub.unsubscribe(:workerbee_pubsub, "driver")
    Logger.info("terminating, reason: #{inspect(reason)}, state: #{inspect(state)}")
    :ok
  end
end
