defmodule RingTickerTest do
  use ExUnit.Case

  describe "interval/0" do
    test "is two seconds" do
      assert RingTicker.interval == 2_000
    end
  end

  describe "start/0" do
    test "registers itself globally" do
      {:ok, client} = RingTicker.start

      assert :global.whereis_name(:ring_ticker) == client
    end
  end

  describe "generator/1" do
    test "sends ticks to the client" do
      generator = spawn(RingTicker, :generator, [[self()]])

      timeout = RingTicker.interval + 10

      assert_receive {:tick}, timeout
    end
  end
end
