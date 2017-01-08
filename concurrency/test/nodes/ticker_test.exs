defmodule TickerTest do
  use ExUnit.Case

  describe "start/0" do
    test "registers the ticker globally" do
      Ticker.start

      assert :global.whereis_name(:ticker) != :undefined
    end
  end

  describe "register/1" do
    test "registers a given client to receive ticks" do
      test = self()

      Ticker.start
      Ticker.register(test)

      Process.sleep 1_000

      assert_receive {:tick}
    end

    test "registers multiple clients to receive ticks" do
      test = self()

      Ticker.start

      receiver = fn ->
        receive do
          {:tick} -> send test, {:ticked, self()}
        end
      end

      first = spawn receiver
      second = spawn receiver

      Ticker.register(first)
      Ticker.register(second)

      Process.sleep 1_000

      assert_receive {:ticked, first}
      assert_receive {:ticked, second}
    end
  end
end
