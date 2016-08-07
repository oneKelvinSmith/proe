defmodule Spawn1Test do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "greets from another process" do
    assert capture_io(fn ->
      pid = spawn(Spawn1, :greet, [])
      send pid, {self, "World!"}
      receive do
        {:ok, message} -> IO.puts message
      end
    end) == """
    Hello, World!
    """
  end
end
