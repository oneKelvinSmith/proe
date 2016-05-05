defmodule Words do
  def anagram?(first_word, second_word) do
    chars(first_word) -- chars(second_word)
    |> Enum.empty?
  end

  defp chars(word) do
    word
    |> String.to_char_list
    |> Enum.sort
  end

  def center([]), do: :ok
  def center([head | tail] = words) when is_list(words) do
    max = max_length words
    Enum.each words, fn(word) ->
      IO.puts justify(word, max)
    end
  end

  defp justify(word, max) do
    relative_length = div(max + String.length(word), 2)
    String.rjust(word, relative_length)
  end

  defp max_length(words) do
    Enum.reduce words, 0, fn
      word, acc when byte_size(word) > acc ->
        byte_size(word)
      _word, acc ->
        acc
    end
  end
end
