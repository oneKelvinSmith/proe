defmodule ChopTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  test "guess/2 prints guesses until the number is reached" do
    assert capture_io(fn ->
      Chop.guess(4, 1..10)
    end) == "Is it 5?\nIs it 3?\nIs it 4?\n"
  end

  test "guess/2 returns the guessed number" do
    assert Chop.guess(2, 1..10) == 2
  end
end
