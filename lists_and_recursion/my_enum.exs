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
end
