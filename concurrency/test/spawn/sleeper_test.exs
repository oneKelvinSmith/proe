defmodule SleeperTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  describe "spawning links" do
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
    test "sleeping before listening does not lose the error" do
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

  describe "spawning monitors" do
    test "sleeping before listening loses the messages" do
      assert capture_io(fn ->
        Sleeper.monitor
      end) == """
      Nothing more to report
      """
    end


    @tag :capture_log
    test "sleeping before listening loses the error" do
      message = capture_io(fn ->
        Sleeper.monitor_with_exception
      end)

      assert message == """
      Nothing more to report
      """
    end
  end
end
