defmodule TailRecursiveTest do
  use ExUnit.Case

  test "factorial/1 with tail recursion" do
    assert TailRecursive.factorial(0) == 1
    assert TailRecursive.factorial(1) == 1
    assert TailRecursive.factorial(2) == 2
    assert TailRecursive.factorial(3) == 6
    assert TailRecursive.factorial(4) == 24
    assert TailRecursive.factorial(5) == 120
  end
end
