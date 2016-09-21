defmodule SleeperTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  test "sleeping before listening does not lose the messages" do
    assert capture_io(fn ->
      Sleeper.link
    end) == """
    Child reported :death_is_imminent
    Child died
    Nothing more to report
    """
  end


  @tag :capture_log
  test "sleeping before listening for exceptions loses the exception" do
    message = capture_io(fn ->
      Sleeper.link_with_exception
    end)

    assert message == """
    Child reported :not_going_quietly
    Child was immolated
    Nothing more to report
    """
  end
end
