defmodule FizzBuzzTest do
  use ExUnit.Case

  test "upto/1 outputs 'Fizz' for multiples of three" do
    assert FizzBuzz.upto(3) == [1, 2, "Fizz"]
  end

  test "upto/1 outputs 'Buzz' for multiples of five" do
    assert FizzBuzz.upto(5) == [1, 2, "Fizz", 4, "Buzz"]
  end

  test "upto/1 outputs 'FizzBuzz' for multiples of three and five" do
    assert FizzBuzz.upto(15) == [
      1,      2,      "Fizz",
      4,      "Buzz", "Fizz",
      7,      8,      "Fizz",
      "Buzz", 11,     "Fizz",
      13,     14,     "FizzBuzz"
    ]
  end

  test "upto/1 only handles positive integers" do
    assert_raise FunctionClauseError, fn ->
      FizzBuzz.upto(0)
    end
  end

  test "upto_with_cond/1 behaves like upto/1" do
    number = 15
    assert FizzBuzz.upto(number) == FizzBuzz.upto_with_cond(number)
  end

  test "upto_with_case/1 behaves like upto/1" do
    number = 15
    assert FizzBuzz.upto(number) == FizzBuzz.upto_with_case(number)
  end
end
