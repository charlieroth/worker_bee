defmodule WorkerBeeTest do
  use ExUnit.Case
  doctest WorkerBee

  test "greets the world" do
    assert WorkerBee.hello() == :world
  end
end
