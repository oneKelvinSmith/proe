defmodule RingTicker do
  @interval 2_000
  @name :ring_ticker

  def interval, do: @interval

  def generator(client) do
    receive do
      {:link, new_client} ->
        IO.puts "Linked #{inspect client} with #{inspect self()}"
        link_tail(client, new_client, current_client())
        generator(new_client)
      {:tick} ->
        IO.puts "Tick in #{inspect self()}"
        generator(client)
    after
      @interval ->
        tick(client)
        generator(client)
    end
  end

  defp link(client, new_client) do
    case client do
      :no_client -> :noop
      client when is_pid(client) ->
        send client, {:link, new_client}
    end
  end

  defp link_tail(linked_client, new_client, registered_client) do
    IO.puts "linked:  #{inspect linked_client}"
    IO.puts "new:     #{inspect new_client}"
    IO.puts "current: #{inspect registered_client}"
    # case [linked_client, new_client, registered_client] do


    # end
  end

  defp tick(:no_client), do: :no_client
  defp tick(client) when is_pid(client) do
    send client, {:tick}
    client
  end

  def start do
    new_client = spawn_new_client()
    link(current_client(), new_client)
    unregister_current_client()
    register(new_client)
  end

  def spawn_new_client do
    spawn __MODULE__, :generator, [:no_client]
  end

  defp current_client do
    case :global.whereis_name(@name) do
      :undefined -> :no_client
      client     -> client
    end
  end

  defp register(client) do
    case :global.register_name(@name, client) do
      :yes       -> {:ok, client}
      :undefined -> {:error}
    end
  end

  defp unregister_current_client do
    :global.unregister_name(@name)
  end
end
