defmodule Link do
  import :timer, only: [ sleep: 1 ]

  def sad_function do
    sleep 500
    exit(:boom)
  end

  def run_without_link do
    spawn(Link, :sad_function, [])
    receive do
      message ->
        IO.puts "MESSAGE RECEIVED: #{inspect message}"
    after 1000 ->
        IO.puts "Nothing happened as far as I am concerned"
    end
  end

  def run_with_link do
    spawn_link(Link, :sad_function, [])
    receive do
      message ->
        IO.puts "MESSAGE RECEIVED: #{inspect message}"
    after 1000 ->
        IO.puts "Nothing happened as far as I am concerned"
    end
  end
end
