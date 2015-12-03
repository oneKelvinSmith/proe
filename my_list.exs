defmodule MyList do
  def map([], _func),           do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]

  def reduce([], value, _func), do: value
  def reduce([head | tail], value, func) do
    reduce(tail, func.(head, value), func)
  end

  def square(list), do: map(list, &(&1 * &1))

  def add_1(list), do: map(list, &(&1 + 1))

  def sum_no_acc([]),            do: 0
  def sum_no_acc([head | tail]), do: head + sum_no_acc(tail)

  def len([]),             do: 0
  def len([_head | tail]), do: 1 + len(tail)

  def sum(list), do: sum(list, 0)

  defp sum([], total),            do: total
  defp sum([head | tail], total), do: sum(tail, head + total)
end
