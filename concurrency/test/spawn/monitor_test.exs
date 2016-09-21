defmodule MonitorTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  test "monitored processes don't get notified" do
    assert capture_io(fn ->
      Monitor.run
    end) == """
    MESSAGE RECEIVED: {:DOWN, :boom}
    """
  end
end
