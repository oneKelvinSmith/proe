defmodule SpawnTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "greets from another process" do
    pid = spawn(Spawn, :greet, [])

    send pid, {self(), "World!"}

    greeting = capture_io(fn ->
      receive do
        {:ok, message} -> IO.puts message
      end
    end)

    assert greeting == """
    Hello, World!
    """
  end

  test "greets multiple times" do
    pid = spawn(Spawn, :greet, [])

    send pid, {self(), "World!"}

    receive do
      {:ok, _message} -> :ignore
    end

    send pid, {self(), "Kermit!"}

    greeting = capture_io(fn ->
      receive do
        {:ok, message} ->
          IO.puts message
      after 500 ->
          IO.puts "The Greeter has gone away"
      end
    end)

    assert greeting != """
    The Greeter has gone away
    """

    assert greeting == """
    Hello, Kermit!
    """
  end
end
