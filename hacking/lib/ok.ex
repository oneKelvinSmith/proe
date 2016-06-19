defmodule Ok do
  def ok!({:ok, data}), do: data
  def ok!(param) do
    raise RuntimeError, message: "#{inspect param} does not match {:ok, ...}"
  end
end
