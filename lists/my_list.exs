defmodule MyList do
  def map([], _func),           do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]

  def reduce([], value, _func), do: value
  def reduce([head | tail], value, func) do
    reduce(tail, func.(head, value), func)
  end

  def sum(list), do: reduce list, 0, &(&1 + &2)

  def sum_no_acc([]),            do: 0
  def sum_no_acc([head | tail]), do: head + sum_no_acc(tail)

  def len([]),             do: 0
  def len([_head | tail]), do: 1 + len(tail)

  def span(from, to) when from == to, do: [from]
  def span(from, to) when from > to,  do: span(to, from)
  def span(from, to), do: [from | span(from + 1, to)]

  def max([]), do: nil
  def max([head | tail]), do: do_max(tail, head)
  defp do_max([], max),                            do: max
  defp do_max([head | tail], max) when max > head, do: do_max(tail, max)
  defp do_max([head | tail], _max),                do: do_max(tail, head)

  def square(list), do: map(list, &(&1 * &1))

  def add_1(list), do: map(list, &(&1 + 1))

  def mapsum(list, func) do
    list
    |> map(func)
    |> sum
  end

  def flatten([]),     do: []
  def flatten([head | tail]) do
    flatten(head) ++ flatten(tail)
  end
  def flatten(item), do: [item]

  def caesar([], _),   do: []
  def caesar(list, n), do: map list, &shift(&1, n)

  @char_offset 96
  defp shift(char, n), do: shift_mod_26(char - @char_offset, n) + @char_offset

  @modulus 26
  defp shift_mod_26(char, n), do: rem(char + n, @modulus)
end
