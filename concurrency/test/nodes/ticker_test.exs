defmodule TickerTest do
  use ExUnit.Case

  test "registers the given client pid" do
    test = self

    Ticker.start

    receiver = spawn fn ->
      receive do
        {:tick} -> send test, :pass
        _       -> send test, :fail
      end
    end

    Ticker.register(receiver)

    Process.sleep 1_000

    assert_receive :pass
    refute_receive :fail
  end
end
