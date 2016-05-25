defmodule FizzBuzz do
  def upto(n) when n > 0, do: do_upto(1, n, [])
  defp do_upto(_current, 0, result), do: Enum.reverse(result)
  defp do_upto(current, left, result) do
    next_answer =
      cond do
        rem(current, 3) == 0 and rem(current, 5) == 0->
          "FizzBuzz"
        rem(current, 3) == 0 ->
          "Fizz"
        rem(current, 5) == 0 ->
          "Buzz"
        true ->
          current
      end
    do_upto(current + 1, left - 1, [next_answer | result])
  end
end
