defmodule CalculatorTest do
  use ExUnit.Case

  test "calculate/1 handles addition" do
    assert Calculator.calculate("123 + 27") == 150
  end

  test "caluclate/1 handles substraction" do
    assert Calculator.calculate("54 - 12") == 42
  end
end
