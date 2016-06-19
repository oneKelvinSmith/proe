defmodule Prime do
  def upto(n) do
    2..n
    |> Enum.to_list
    |> do_upto
  end

  defp do_upto([]), do: []
  defp do_upto([head | tail]) do
    filtered = for n <- tail, !is_divisible?(n, head), do: n
    [head | do_upto(filtered)]
  end

  defp is_divisible?(x, y) do
    rem(x, y) == 0
  end
end
