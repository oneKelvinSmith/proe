defmodule Fibonacci do
  def solve(scheduler) do
    send scheduler, {:ready, self()}
    receive do
      {:fib, n, client} ->
        send client, {:answer, n, calculate(n), self()}
        solve(scheduler)
      {:shutdown} ->
        exit :normal
    end
  end

  defp calculate(0), do: 0
  defp calculate(1), do: 1
  defp calculate(n), do: calculate(n - 1) + calculate(n - 2)
end
