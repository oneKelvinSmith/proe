defmodule FizzBuzz do
  def upto(n) when n > 0, do: 1..n |> Enum.map(&do_fizzbuzz/1)

  defp do_fizzbuzz(n), do: do_fizzword(n, rem(n, 3), rem(n, 5))
  defp do_fizzword(_n, 0, 0), do: "FizzBuzz"
  defp do_fizzword(_n, 0, _), do: "Fizz"
  defp do_fizzword(_n, _, 0), do: "Buzz"
  defp do_fizzword(n, _, _),  do: n

  def upto_with_cond(n) when n > 0 do
    1..n |> Enum.map(&do_fizzbuzz_with_cond/1)
  end

  defp do_fizzbuzz_with_cond(n) do
    cond do
      rem(n, 3) == 0 and rem(n, 5) == 0 -> "FizzBuzz"
      rem(n, 3) == 0                    -> "Fizz"
      rem(n, 5) == 0                    -> "Buzz"
      true                              -> n
    end
  end

  def upto_with_case(n) when n > 0 do
    1..n |> Enum.map(&do_fizzbuzz_with_case/1)
  end

  defp do_fizzbuzz_with_case(n) do
    case {rem(n, 3), rem(n, 5)} do
      {0, 0} -> "FizzBuzz"
      {0, _} -> "Fizz"
      {_, 0} -> "Buzz"
      _      -> n
    end
  end
end
