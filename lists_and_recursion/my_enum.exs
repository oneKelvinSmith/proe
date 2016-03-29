defmodule MyEnum do
  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end
  def each([], _func), do: :ok

  def all?([], _func),           do: true
  def all?([head | tail], func), do: func.(head) and all?(tail, func)

  def filter([], _func), do: []
  def filter([head | tail], func) do
    if func.(head) do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end

  def split([], _count),                 do: {[], []}
  def split(list, count) when count < 0, do: split(list, count(list) + count)
  def split(list, count),                do: do_split([], list, count)
  defp do_split(left, [head | tail], count) when count > 0 do
    do_split([head | left], tail, count - 1)
  end
  defp do_split(left, right, 0), do: {reverse(left), right}

  def count(list), do: do_count(list, 0)
  defp do_count([_head | tail], count), do: do_count(tail, count + 1)
  defp do_count([], count),             do: count

  def reverse([head | tail]), do: do_reverse(tail, [head])
  def reverse([]),            do: []
  defp do_reverse([head | tail], reversed) do
    do_reverse(tail, [head | reversed])
  end
  defp do_reverse([], reversed), do: reversed
end
