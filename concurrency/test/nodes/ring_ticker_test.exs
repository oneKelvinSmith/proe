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

    test "registered the new client globally" do
      {:ok, client}     = RingTicker.start
      {:ok, new_client} = RingTicker.start

      refute :global.whereis_name(:ring_ticker) == client
      assert :global.whereis_name(:ring_ticker) == new_client
    end
  end

  describe "generator/1" do
    test "sends ticks to the client" do
      test = self()
      generator = spawn(RingTicker, :generator, [test])

      receive do
        {:tick} ->
          send test,      {:ticked}
          send generator, {:tick}
      end

      assert_receive {:ticked}

      receive do
        {:tick} -> send test, {:ticked_again}
      end

      assert_receive {:ticked_again}
    end
  end
end
