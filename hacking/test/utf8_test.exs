defmodule Utf8Test do
  use ExUnit.Case

  import ExUnit.CaptureIO

  test "each/2 applies a function to each UTF8 character in a binary" do
    assert capture_io(fn ->
      Utf8.each("∂og", &IO.puts/1)
    end) == "8706\n111\n103\n"
  end
end
