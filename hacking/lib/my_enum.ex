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

  def split([], _tallly),                do: {[], []}
  def split(list, tally) when tally < 0, do: split(list, count(list) + tally)
  def split(list, tally),                do: do_split([], list, tally)
  defp do_split(left, [head | tail], tally) when tally > 0 do
    do_split([head | left], tail, tally - 1)
  end
  defp do_split(left, right, 0), do: {reverse(left), right}

  def count(list),                      do: do_count(list, 0)
  defp do_count([_head | tail], tally), do: do_count(tail, tally + 1)
  defp do_count([], tally),             do: tally

  def reverse([head | tail]), do: do_reverse(tail, [head])
  def reverse([]),            do: []
  defp do_reverse([head | tail], reversed) do
    do_reverse(tail, [head | reversed])
  end
  defp do_reverse([], reversed), do: reversed

  def take([], _tallly), do: []
  def take(list, tally) when tally < 0 do
    list
    |> reverse
    |> do_take(-tally, [])
  end
  def take(list, tally) do
    list
    |> do_take(tally, [])
    |> reverse
  end
  defp do_take([head | tail], tally, taken) when tally > 0 do
    do_take(tail, tally - 1, [head | taken])
  end
  defp do_take(_tail, 0, taken), do: taken
end
