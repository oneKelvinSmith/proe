defmodule MyEnumTest do
  use ExUnit.Case

  test "reverse reverses a list" do
    assert MyEnum.reverse([1, 2]) == [2, 1]
  end

  test "revese returns an empty list when given an empty list" do
    assert MyEnum.reverse([]) == []
  end
end
