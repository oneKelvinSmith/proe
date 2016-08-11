defmodule TailRecursive do
  def factorial(n) do
    do_factorial(n, 1)
  end

  defp do_factorial(0, acc), do: acc
  defp do_factorial(n, acc), do: do_factorial(n - 1, n * acc)
end
