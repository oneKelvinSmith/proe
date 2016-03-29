defmodule MyEnum do
  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end
  def each([], _func), do: :ok

  def all?([head | tail], func), do: func.(head) and all?(tail, func)
  def all?([], _func), do: true

  def filter([head | tail], func) do
    if func.(head) do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end
  def filter([], _func), do: []

  def split(list, count) when count < 0, do: split(list, count(list) + count)
  def split(list, count), do: do_split(list, {count, [], []})
  defp do_split([head | tail], {count, left, right}) do
    if count > 0 do
      left = [head | left]
    else
      right = [head | right]
    end
    do_split(tail, {count - 1, left, right})
  end
  defp do_split([], {_, left, right}), do: {reverse(left), reverse(right)}

  def count(list), do: do_count(list, 0)
  defp do_count([_head | tail], count), do: do_count(tail, count + 1)
  defp do_count([], count), do: count

  def reverse([head | tail]), do: do_reverse(tail, [head])
  def reverse([]), do: []
  defp do_reverse([head | tail], reversed), do: do_reverse(tail, [head | reversed])
  defp do_reverse([], reversed), do: reversed
end
