defmodule Chop do
  def guess(n, range = first..last) when first < last do
    guess(n, middle(first, last), range)
  end

  def guess(n, first..last) do
    guess(n, middle(last, first), last..first)
  end

  defp guess, g when n === g do
    print g
    g
  end

  defp guess(n, g, _..last) when div(n, g) > 0 do
    print g
    guess(n, middle(g, last), g..last)
  end

  defp guess(n, g, first.._) when div(n, g) == 0 do
    print g
    guess(n, middle(first, g), first..g)
  end

  defp middle(first, last) do
    first + div(last - first, 2)
  end

  defp print(number), do: IO.puts "Is it #{number}?"
end
