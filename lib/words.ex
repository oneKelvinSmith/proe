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
end
