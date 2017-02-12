defmodule TickerTest do
  use ExUnit.Case

  describe "interval/0" do
    test "is one second" do
      assert Ticker.interval == 1_000
    end
  end

  describe "start/0" do
    test "registers the ticker globally" do
      Ticker.start

      assert :global.whereis_name(:ticker) != :undefined
    end
  end

  describe "register/1" do
    test "registers a given client to receive ticks" do
      Ticker.start
      Ticker.register(self())

      assert_receive {:tick}, Ticker.interval + 10
    end

    test "registers multiple clients to receive ticks" do
      test = self()

      Ticker.start

      receiver = fn ->
        receive do
          {:tick} -> send test, {:ticked, self()}
        end
      end

      first = spawn(receiver)
      second = spawn(receiver)

      Ticker.register(first)
      Ticker.register(second)

      timeout = Ticker.interval + 10

      assert_receive {:ticked, ^second}, timeout
      assert_receive {:ticked, ^first}, timeout
    end
  end
end
