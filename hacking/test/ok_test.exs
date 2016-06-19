defmodule OkTest do
  use ExUnit.Case

  import Ok, only: [ok!: 1]

  test "ok!/1 returns data from {:ok, data} tuple" do
    assert ok!({:ok, :data}) == :data
  end

  test "ok!/1 raises and exception with information from the parameter" do
    error_message = "{:error, :data} does not match {:ok, ...}"
    assert_raise RuntimeError, error_message, fn ->
      ok! {:error, :data}
    end
  end
end
