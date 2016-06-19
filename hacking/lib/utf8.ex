defmodule Utf8 do
  def each(string, func) when is_binary(string), do: do_each(string, func)
  defp do_each(<< head::utf8, tail::binary >>, func) do
    func.(head)
    do_each(tail, func)
  end
  defp do_each(<<>>, _func), do: []
end
