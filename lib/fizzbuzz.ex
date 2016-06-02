defmodule FizzBuzz do
  def upto(n) when n > 0, do: 1..n |> Enum.map(&do_fizzbuzz/1)

  defp do_fizzbuzz(n), do: do_fizzword(n, rem(n, 3), rem(n, 5))

  defp do_fizzword(_n, 0, 0), do: "FizzBuzz"
  defp do_fizzword(_n, 0, _), do: "Fizz"
  defp do_fizzword(_n, _, 0), do: "Buzz"
  defp do_fizzword(n, _, _), do: n
end
