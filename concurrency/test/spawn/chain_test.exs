defmodule ChainTest do
  use ExUnit.Case

  test "it doesn't take much time to spawn a concurrent counter" do
    {time_for_10, "Result is 10"} = :timer.tc(Chain, :create_processes, [10])

    assert time_for_10 < 2_000 # 2ms

    {time_for_100, "Result is 100"} = :timer.tc(Chain, :create_processes, [100])

    assert time_for_100 < 2_000 # 2ms

    {time_for_10_000, "Result is 10000"} = :timer.tc(Chain, :create_processes, [10_000])
    assert time_for_10_000 < 100_000 # 100ms

    {time_for_100_000, "Result is 100000"} = :timer.tc(Chain, :create_processes, [100_000])
    assert time_for_100_000 < 1_000_000 # 1s
  end
end
