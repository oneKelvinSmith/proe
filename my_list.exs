defmodule MyList do
  def map([], _func),           do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]

  def reduce([], value, _func), do: value
  def reduce([head | tail], value, func) do
    reduce(tail, func.(head, value), func)
  end

  def len([]),             do: 0
  def len([_head | tail]), do: 1 + len(tail)

  def square(list), do: map(list, &(&1 * &1))

  def add_1(list), do: map(list, &(&1 + 1))

  def mapsum(list, func) do
    list
    |> map(func)
    |> sum
  end

  def sum_no_acc([]),            do: 0
  def sum_no_acc([head | tail]), do: head + sum_no_acc(tail)

  def sum(list), do: do_sum(list, 0)
  defp do_sum([], total),            do: total
  defp do_sum([head | tail], total), do: do_sum(tail, head + total)
end
