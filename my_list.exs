defmodule MyList do
  def len([]),             do: 0
  def len([_head | tail]), do: 1 + len(tail)

  def square(list), do: map(list, &(&1 * &1))

  def add_1(list), do: map(list, &(&1 + 1))

  def map([], _func),           do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]

  def sum_no_acc([]),            do: 0
  def sum_no_acc([head | tail]), do: head + sum_no_acc(tail)

  def sum(list), do: sum(list, 0)

  defp sum([], total),            do: total
  defp sum([head | tail], total), do: sum(tail, head + total)
end
