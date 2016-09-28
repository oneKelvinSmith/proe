defmodule CatCounter do
  def count(file) do
    file
    |> File.read!
    |> String.split
    |> Enum.filter(&contains_cat/1)
    |> Enum.count
  end

  defp contains_cat(word) do
    String.match? word, ~r/cat/
  end
end
