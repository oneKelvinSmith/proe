defmodule SchedulerTest do
  use ExUnit.Case

  defmodule Tester do
    def function(scheduler) do
      send scheduler, {:ready, self()}
      receive do
        {:fib, number, client} ->
          send client, {:answer, number, self(), self()}
          function(scheduler)
        {:shutdown} ->
          exit :normal
      end
    end
  end

  describe "run/1" do
    test "schedules processes for a given funtion" do
      [{0, first}, {1, second}] = Scheduler.run 2, Tester, :function, [0, 1]

      assert is_pid first
      assert is_pid second
      assert first != second
    end
  end
end
