defmodule LinkTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  test "noone is notified when a process dies" do
    assert capture_io(fn ->
      Link.run_without_link
    end) == """
    Nothing happened as far as I am concerned
    """
  end

  test "a linked process dies as well" do
    trap = Process.flag(:trap_exit, true)

    assert capture_io(fn ->
      Link.run_with_link
    end) == """
    MESSAGE RECEIVED: :boom
    """

    Process.flag(:trap_exit, trap)
  end

  test "trapping the exit does not kill a linked process" do
    assert capture_io(fn ->
      Link.run_with_trap
    end) == """
    MESSAGE RECEIVED: :boom
    """
  end
end
