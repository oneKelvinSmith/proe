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

  def capitalize_sentences(sentences) when is_binary(sentences) do
    do_capitalize_sentences(sentences, true, <<>>)
  end

  defp do_capitalize_sentences(<<>>, _, output), do: output
  defp do_capitalize_sentences(<< head::utf8, tail::binary >>, new_sentence?, capitalized) do
    {new_sentence?, capitalized} =
      case head do
        32 ->
          {new_sentence?, capitalized <> << head >>}
        46 ->
          {true, capitalized <> << head >>}
        char when 97 <= char and char <= 122 and new_sentence? ->
          {false, capitalized <> << char - 32 >>}
        char when 65 <= char and char <= 90 ->
          {false, capitalized <> << char + 32 >>}
        char ->
          {false, capitalized <> << char >>}
      end

    do_capitalize_sentences(tail, new_sentence?, capitalized)
  end
end
