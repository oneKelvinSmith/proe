defmodule MyList do
  def len([]),             do: 0
  def len([_head | tail]), do: 1 + len(tail)

  def square(list), do: map(list, &(&1 * &1))

  def add_1(list), do: map(list, &(&1 + 1))

  def map([], _func),           do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]
end
