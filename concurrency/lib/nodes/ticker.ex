defmodule Ticker do
  @interval 1_000
  @name :ticker

  def interval, do: @interval

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), {:register, client_pid}
  end

  def generator(clients) do
    receive do
      {:register, new_client} ->
        IO.puts "registering #{inspect new_client}"
        generator([new_client | clients])
    after
      @interval ->
        clients
        |> tick
        |> generator
    end
  end

  defp tick(clients) do
    case clients do
      [client | rest] ->
        send client, {:tick}
        IO.puts "tick sent to #{inspect client}"
        rest ++ [client]
      [] ->
        IO.puts "tick"
        []
    end
  end
end
