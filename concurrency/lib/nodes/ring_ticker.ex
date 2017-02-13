defmodule RingTicker do
  @interval 2_000
  @name :ring_ticker

  def interval, do: @interval

  def start do
    client = spawn_client()
    case :global.register_name(@name, client) do
      :yes       -> {:ok, client}
      :undefined -> {:error, :undefined}
    end
  end

  def generator(clients) do
    receive do
    after
      @interval ->
        case clients do
          [client | _] ->
            send client, {:tick}
          [] ->
            generator(clients)
        end
    end
  end

  defp spawn_client do
    spawn(__MODULE__, :generator, [[]])
  end
end
