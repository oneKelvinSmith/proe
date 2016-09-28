defmodule CatCounter do
  def count(file) do
    file
    |> File.read!
    |> String.split
    |> Enum.reduce(0, fn
      ("cat", acc) -> acc + 1
      (_word, acc) -> acc
    end)
  end
end
