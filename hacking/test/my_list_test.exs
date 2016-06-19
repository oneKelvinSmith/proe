defmodule MyListTest do
  use ExUnit.Case

  test "span/2 generates a range of numbers" do
    assert MyList.span(1, 2) == [1, 2]
  end

  test "span/2 returns a list with one number when given that number twice" do
    assert MyList.span(42, 42) == [42]
  end

  test "span/2 handles descending and negative numbers gracefully" do
    assert MyList.span(3, -1) == [-1, 0, 1, 2, 3]
  end

  test "primes/1 returns a list of prime numbers from 2 to n" do
    primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41]
    assert MyList.primes(42) == primes
  end

  test "primes/1 returns and empty list when a number smaller than 2 is given" do
    assert MyList.primes(-42) == []
  end

  test "primes/1 returns [2] when 2 is given" do
    assert MyList.primes(2) == [2]
  end
end
