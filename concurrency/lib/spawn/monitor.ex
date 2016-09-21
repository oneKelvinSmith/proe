defmodule Monitor do
  import :timer, only: [ sleep: 1 ]

  def sad_function do
    sleep 500
    exit(:boom)
  end

  def run do
    {pid, ref} = spawn_monitor(Monitor, :sad_function, [])
    receive do
      {:DOWN, ^ref, :process, ^pid, message} ->
        IO.puts "MESSAGE RECEIVED: #{inspect {:DOWN, message}}"
    after 1000 ->
        IO.puts "Nothing happened as far as I am concerned"
    end
  end
end
