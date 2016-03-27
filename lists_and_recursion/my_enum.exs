defmodule MyEnum do
  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end
  def each([], _func), do: :ok

  def all?([head | tail], func) do
    func.(head) and all?(tail, func)
  end
  def all?([], _func), do: true

  def filter([head | tail], func) do
    if func.(head) do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end
  def filter([], _func), do: []
end
