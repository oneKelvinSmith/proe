defmodule CalculatorTest do
  use ExUnit.Case

  test "calculate/1 handles addition" do
    assert Calculator.calculate("123 + 27") == 150
  end

  test "calculate/1 handles substraction" do
    assert Calculator.calculate("54 - 12") == 42
  end

  test "calculate/1 handles division" do
    assert Calculator.calculate("9 / 2") == 4.5
  end

  test "calculate/1 handles multiplication" do
    assert Calculator.calculate("333 * 2") == 666
  end
end
