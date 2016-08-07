defmodule SpawnBasicTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "greet says hello" do
    assert capture_io(fn ->
      SpawnBasic.greet
    end) == """
    Hello
    """
  end
end
