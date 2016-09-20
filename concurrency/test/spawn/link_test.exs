defmodule LinkTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  test "noone is notified when a process dies" do
    assert capture_io(fn ->
      Link.run_without_link
    end) == "Nothing happened as far as I am concerned\n"
  end

  test "a linked process dies as well" do
    trap = Process.flag(:trap_exit, true)

    message = capture_io(fn ->
      Link.run_with_link
    end)

    assert message =~ "MESSAGE RECEIVED"
    assert message =~ ":EXIT"
    assert message =~ ":boom"

    Process.flag(:trap_exit, trap)
  end
end
