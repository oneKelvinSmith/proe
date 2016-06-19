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
  defp do_max([], maximum),             do: maximum
  defp do_max([head | tail], maximum) when maximum > head do
    do_max(tail, maximum)
  end
  defp do_max([head | tail], _maximum), do: do_max(tail, head)

  def square(list), do: map(list, &(&1 * &1))

  def add_1(list), do: map(list, &(&1 + 1))

  def mapsum(list, func) do
    list
    |> map(func)
    |> sum
  end

  def flatten([]),            do: []
  def flatten([head | tail]), do: flatten(head) ++ flatten(tail)
  def flatten(item),          do: [item]

  def caesar([], _),   do: []
  def caesar(list, n), do: map list, &shift(&1, n)

  @char_offset 96
  defp shift(char, n), do: shift_mod_26(char - @char_offset, n) + @char_offset

  @modulus 26
  defp shift_mod_26(char, n), do: rem(char + n, @modulus)

  def primes(n) when n < 2,  do: []
  def primes(n) when n == 2, do: [2]
  def primes(n) do
    all = span(2, n)
    comps = composites(n)

    all -- comps
  end

  def composites(n) do
    x_s = span(2, div(n, 2))

    for x <- x_s, y <- x_s, x <= y, x * y <= n, do: x * y
  end
end
