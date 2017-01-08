defmodule Parrallel do
  def pmap(collection, function) do
    me = self()
    spawner = fn (element) ->
      spawn_link fn ->
        (send me, {self(), function.(element)})
      end
    end
    receiver = fn (pid) ->
      receive do
        {^pid, result} ->
          result
      end
    end
    collection
    |> Enum.map(spawner)
    |> Enum.map(receiver)
  end
end
