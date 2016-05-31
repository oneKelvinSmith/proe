defmodule FizzBuzz do
  def upto(n) when n > 0, do: do_downto(n, [])
  defp do_downto(0, result), do: result
  defp do_downto(current, result) do
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
    do_downto(current - 1, [next_answer | result])
  end
end
